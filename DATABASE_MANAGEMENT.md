## Database Management

### Versioning Overview
![Versioning overview](./images/database/BaseX_Versioning.png)

To achieve versioning (which is not available out-of-the-box), we need to add something smart to BaseX. This smart thing is [RESTXQ](http://exquery.github.io/exquery/exquery-restxq-specification/restxq-1.0-specification.html) in our case.

With RESTXQ, functions can be created using xQuery and some added intelligence like variables and for-loops for example.

Example RESTXQ function:

```
declare
  %rest:path("/search")
  %rest:query-param("term", "{$term}")
  %rest:single
function page:search($term as xs:string) {
  <ul>{
    for $result in db:open('large-db')//*[text() = $term]
    return <li>{ $result }</li>
  }</ul>
};
```

By using RESTXQ, a versioning mechanism can be created. So for example, in a edit (PUT) function we can do something like: When editing a already stored configuration, save it by incrementing the version and store as a separate configuration. The old configuration is stored in the archive database, the current version is replaced in the current database.

In a get (GET) function, we can make distinction between newer and older versions using RESTXQ. By using xQuery syntax (scl[@version="1"] for example), we can get specific versions of a configuration.

### Points to remember
- home of BaseX = /srv/basex
- RESTXQ file extension = .xqm
- RESTXQPATH variable (in {home}/webapp/WEB-INF/web.xml) points to directory containing the RESTXQ modules (.xqm files)
  - Default is '.', which is relative to the WEBPATH variable (which is {home}/webapp)

### Example using RESTXQ

- Run a BaseX container
- Use shell inside container (docker exec -it <container id> bash)
- create a RESTXQ module: vi /srv/basex/webapp/test.xqm for example
- copy paste the following code:

```
module namespace page = 'http://basex.org/examples/web-page';

declare %rest:path("hello/{$who}") %rest:GET function page:hello($who) {
  <response>
    <title>!Hello { $who }!</title>
  </response>
};
```

- You don't have to restart the container, when doing a REST request it seaches on the fly for functions.
- Do a GET request like http://localhost:8984/hello/World
- You will get a XML containing a title !Hello World!

### Restrictions
A single database is restricted to 2 billion nodes (also, see [BaseX Statistics](https://docs.basex.org/wiki/Statistics))

### Sources
http://www.adamretter.org.uk/presentations/restxq_mugl_20120308.pdf