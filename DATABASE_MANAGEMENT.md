## Database Management

## Versioning Overview
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

### Versioning type
For type of versioning, we prefer [Semantic Versioning](https://semver.org/). This to keep versioning simple. For every changeset CoMPAS is going to ask if it's a major, minor or a patch. This way the version will be adjusted according to the user's needs. An example of distinction can be:
- A changeset is Major in case a full XML section is being added.
- A changeset is Minor is a piece of data is adjusted.
- A changeset is a Patch if a typo is fixed.
But this is up to the user.

Another solution could be [Branch Based Versioning](https://simon-maxen.medium.com/branch-based-versioning-5ebf6ca2bccb). This way, a configuration file can be 'branched', and can be 'merged' when the user think it's fine. When merging, a newer version number can be added (can be done in combination with semantic versioning).
This in indeed a fancy way of versioning, but it's too complex for our use cases. We don't see users branching a configuration file and saving it for a couple of days, before merging it. Besides, this kind of versioning isn't supported in BaseX out of the box so we have to create it ourselves. When comparing added value to effort, this isn't what we want.

## Tech Talk

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
A node in this case is an XML node like an element, attribute, text, etc.

### Sources
http://www.adamretter.org.uk/presentations/restxq_mugl_20120308.pdf

## Database Rights