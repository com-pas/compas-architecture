module namespace auth = 'urn:nubisware:muscle:fiber:auth';
import module namespace session = "http://basex.org/modules/session";

declare namespace b64 = "java:java.util.Base64";
declare namespace b64enc = "java:java.util.Base64$Encoder";
declare namespace b64dec = "java:java.util.Base64$Decoder";

declare variable $auth:config := map {
  "keycloakurl" : "https://mykeycloak.org",
  "realm" : "myrealm",
  "clientid" : "myexamplepublicclient",
  "client_redirect_uri" : "http://localhost:8984/auth/oidc-callback"
};

declare %private variable $auth:KEYCLOAK_BASE_URL := 
  $auth:config?keycloakurl || "/auth/realms/" || $auth:config?realm || "/protocol/openid-connect";
declare %private variable $auth:KEYCLOAK_TOKEN_URL := $auth:KEYCLOAK_BASE_URL || "/token";
declare %private variable $auth:KEYCLOAK_LOGOUT_URL := $auth:KEYCLOAK_BASE_URL || "/logout";
declare %private variable $auth:KEYCLOAK_AUTH_URL := $auth:KEYCLOAK_BASE_URL || "/auth";


declare function auth:hex-to-base64url($tbe as xs:hexBinary) {
  auth:bytes-to-base64url(convert:binary-to-bytes($tbe))
};

declare function auth:bytes-to-base64url($tbe as xs:byte*) {
  b64enc:encodeToString(b64:getUrlEncoder(), $tbe)
};

declare function auth:extract-tokens-from-jwt($jwt as node()) as map(*){
  let $b64decoder := b64:getDecoder()
  let $t1 := $jwt/json/access__token/string()
  let $t2 := tokenize($t1, "\.")[2]
  let $t3 := convert:binary-to-string(convert:integers-to-base64(b64dec:decode($b64decoder, $t2)))
  let $at := json:parse($t3)
  let $t := $jwt/json/refresh__token/string()
  return map{ "accesstoken" : $at, "refreshtoken" : $t, "bearer" : "Bearer " || $t1}
};


(: You can just raise an error with code aut:unauthorized from anywhere in your code to get here and be redirected to keycloak:)
declare
  %rest:error("auth:unauthorized")
  %rest:error-param("value", "{$value}")
function auth:unauthorized($value as map(*)?) {
  web:redirect(web:create-url("/auth/login", $value))
};

(: Start OIDC login with code grant flow this makes it unnecessary to share secrets with a front facing application :)
declare
  %rest:path("auth/login")
  %rest:GET
  %rest:query-param("error", "{$error}")
  %rest:query-param("redirect", "{$redirect}", "/")
  %output:method("html")
function auth:login-show-ep($error as xs:string?, $redirect as xs:string) { 
  let $params := map{
    "client_id" : $auth:config?clientid, "response_type" : "code", "scope" : "openid",
    "state" : ($redirect, "/")[1],
    "redirect_uri" : $auth:config?client_redirect_uri
  }
  return web:redirect(web:create-url($auth:KEYCLOAK_AUTH_URL , $params))
};

(: That's the call back uri you will be redirected back after inserting your credentials in Keycloak :)
declare
  %rest:path("auth/oidc-callback")
  %rest:GET
  %rest:query-param("error", "{$error}")
  %rest:query-param("error_description", "{$error-description}")
  %rest:query-param("session_state", "{$session-state}")
  %rest:query-param("state", "{$state}")
  %rest:query-param("code", "{$code}")
  %output:method("html")
function auth:oidc-redirects(
    $error as xs:string?, $error-description as xs:string?,
    $session-state as xs:string?, $code as xs:string?, $state
) { 
  if(exists($error)) then 
   error("Unable to connect to auth service: " || $error-description)
  else   
     let $body := web:create-url("",
     map{
       "grant_type" : "authorization_code",
       "code" : $code,
       "redirect_uri" : $auth:config?client_redirect_uri,
       "client_id" : $auth:config?clientid,
       "scope" : "openid"
     })
     let $token-response := http:send-request(
       <http:request method="POST" href="{$auth:KEYCLOAK_TOKEN_URL}">
         <http:body media-type="application/x-www-form-urlencoded">{substring-after($body, "?")}</http:body>
       </http:request>
     )
     return
       if($token-response[1]/@status != "200") then
         error("Unable to authorize")
       else
         (session:set("principal", ($token-response[2])), web:redirect($state))
};

(: Logout may be just closing the local session but I added also an example for making a backchannel logout thus closing also the SSO session on Keycloak. Note that I am using the original requested url in the state parameter in order to be able to redirect to the requeste d page. Maybe it should be encoded and randomized... :)
declare
  %rest:path("auth/logout")
  %rest:POST
  %rest:form-param("redirect", "{$redirect}", "/")
  %output:method("html")
function auth:logout-ep($redirect as xs:string) { 
  let $tokens := auth:extract-tokens-from-jwt(session:get("principal"))
  let $bearer := $tokens?bearer
  let $refresh := $tokens?refreshtoken
   let $body := web:create-url("",
      map{
       "refresh_token" : $refresh,
       "client_id" : $auth:config?clientid,
       "redirect_uri" : $auth:config?client_redirect_uri
     })
   let $logout := http:send-request(
     <http:request method="POST" href="{$auth:KEYCLOAK_LOGOUT_URL}">
       <http:header name="Authorization" value="{$bearer}"></http:header>
       <http:body media-type="application/x-www-form-urlencoded">{substring-after($body, "?")}</http:body>
     </http:request>
   )
   return
      (
        session:close(),
        web:redirect($redirect)
      )
};

(: The following code represents an example application that you can access at http://localhost:8984/authtest.
   Two example pages a frontpage and an internal page. Both should be protected :)
declare %private %basex:inline function auth:home-page(){
   <html>
    <head>
      <title>Login</title>
    </head>
    <body>
      <h1>Hello Auth Test</h1>
      <h2>Principal: {session:get("principal") ! json:serialize(.)}</h2>
      <form action="/auth/logout" method="POST">
        <input type="hidden" name="redirect" value="/authtest"/>
        <input type="submit" name="submit" value="Logout"/>
      </form>
    </body>
  </html>
};

declare %private %basex:inline function auth:internal-page(){
   <html>
    <head>
      <title>Internal</title>
    </head>
    <body>
      <h1>This is an internal page</h1>
      <h2>Principal: {json:serialize(session:get("principal"))}</h2>
      <a href="/authtest/">Back</a>
      <form action="/auth/logout" method="POST">
        <input type="hidden" name="redirect" value="/authtest"/>
        <input type="submit" name="submit" value="Logout"/>
      </form>
    </body>
  </html>
};

(: This is the permission check on every page of the example application authtest:)
declare %perm:check("/authtest", "{$context}") function auth:access-control($context as map(*)){
  let $principal := session:get("principal")
  return 
    if(empty($principal)) then error(xs:QName("auth:unauthorized"),"",map{ "redirect" : $context?path})
    else ()
};

(: The example application authtest endpoints:)
declare
  %rest:path("/authtest")
  %rest:GET
  %output:method("html")
function auth:home-page-endpoint() { 
  auth:home-page()
};

declare
  %rest:path("/authtest/internal")
  %rest:GET
  %output:method("html")
function auth:internal-page-endpoint() { 
  auth:internal-page()
};