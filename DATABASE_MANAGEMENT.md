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
In a microservice architecture, a microservice's database should be part of the implementation of that service and cannot be accessed directly by other services. This way, the service is loosely coupled and can be developed/scaled/deployed independently.

There are some patterns to keep persistent data private:
- private-tables-per-service
- schema-per-service
- database-server-per-service
As seen, 2 options are not available for BaseX because it's not a relational database. It doesn't have tables or schemas.
A Database-server-per-service pattern helps ensure that the services are lossely coupled.

The CIM - IEC 61850 service for example get's their own database. If another service wants to get SCD files from this service, use the API of that particular service.

### Where do we set the user privelages of Basex?
Basex has it's own [User Management](https://docs.basex.org/wiki/User_Management).

It's pretty straight forward: Basex has Users that can be created. These users can have so-called permissions that can be applied to the user:
![BaseX permissions overview](./images/database/basex_permissions.png)

In this overview, we see 'Global' permissions and 'Local' permissions.
In both permission groups, a higher permission includes all lower permissions. So a user with the 'Create' permission also has the 'Read' permission.

All permissions are stored in a file called users.xml (which can be editted manually) inside the database directory, and is being parsed once BaseX is started.

### How do we connect it with a central user rights repository?
Under Investigation.

### Is direct database access allowed within the microservices architecture?
For maintenance for example, it's of course allowed to have direct database access. There is no best practice available for this. For some things, you just need direct database access.

If other microservices need access to the data of an other microservice, the only way (best practice) to do this is by API calls.

Source:
https://microservices.io/patterns/data/database-per-service.html