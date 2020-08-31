## Technnology Survey
An initial survey was taken to determine some technologies we could use:

| Technology                     | Name Technology | Benfits | Challenges | Reference Project | Opinion Rob |
| ------------------------------ |:---------------:| -------:| ----------:| -----------------:| -------:|
| Microservices (cross-platform) | Java Spring or Python Flask | Isolation of features in microservices speed up the development | Limiting number of microservices to a manageable number. | | I don't have experience with Python Flask, development is also not very active. I do have experience with Java Spring, and I think it's a great choice!  |
|                                | NestJS with NodeJS | | | | No experience, but NodeJS is a good candidate. NodeJS seems to have some performance issues with heavy computing (downside) |
|                                | Go Micro | | | | No experience, but very active development. Looks interesting! I also have some experience with the Go language. |
| Scripting                      | Python | Flexible. Object oriented. Cross platform. | No standard libraries, need to agree on subset. | | | Fast, easy language. Lots of experience with Python, so ready to use. |
|                                | No code technology | Non developper user can build their own user story built on predevelopped blocks | No many opensource solution and most of them are proprietary | |
|                                | Typescript or Javascript | | | | No experience with Typescript, but it seems richer than Python for example. I don't know how easy it is in setting up related to Python. |
|                                | Bash | | | | It depends on the tasks to do, but bash can do most of the scripting tasks. Easy and fully integrated in Linux. |
|                                | Groovy | | | | |
| APIs                           | REST, Message queue such as Kafka? | | | | REST is a good standard, yes. Depends on the tasks of the APIs. |
|                                | OpenAPI for REST | | | | | 
| XML processing & file database | sax.js             | Memory efficient. Don't need to have XML file sized RAM | Needs to track state while parsing due to streaming nature of API | https://github.com/StevenLooman/saxpath | |
|                                | xQuery, XSLT, XPath|    Standard technologies for XML processing and XML DB querying | Overlapping use cases of very different technologies | https://github.com/BaseXdb/basex | |
|                                | RiseClipse | Validates SCL files more precisely than with XSD (using rules expressed in OCL - Object Constraint Language) also validates CIM files | | https://github.com/riseclipse | RiseClipse has proven itself, been working with it in past projects. Good candidate! Also dedicated to IEC standards, so perfect. |
|                                | xerces? | fast, work well with big files | | | |
|                                | Node - fastXML | | | | | |
| Managing microservices         | container based Microservices using Kubernetes? | | | | To keep microservices managed, a containerized architecture is definitely the way to go. |
| XML versioning                 | Version through file repository or database, see below | Versioning is automatic if file repo or database are chosen to include this feature | | |
|                                | Something similar to CGMES? Each file hasa header with identification, type and version information of the file. | Files are uniquely identified | | |
| Securing SCL XML files         | GPG Encryption | Industry standard (PGP) text encryption, for transport and storage | | https://github.com/StackExchange/blackbox | Don't have much experience with Encryption of files. Why do we want to do this? |
| File repository vs database    | GIT SCM vs Datomic | Both technologies model time meaningfully, Datomic with schema and git with unstructured data | | https://git-scm.com/ vs https://www.datomic.com/ | |
|                                | SQLite | Embedded in app. No separate server needed. | Not as powerful as database server. | https://sqlite.org/index.html | I think a graph database is the way to go here.  |
|                                | I would go with file repository for big XML files. | | | | OK. |
|                                | PostgreSQL | | | | I think a graph database is the way to go here. |
|                                | Neo4J | | | | Good candidate, native XML database. |
|                                | MongoDB | | | | MongoDB doesn't support XML, it supports BSON. Not handy. it's possible, but demands extra work. |
|                                | InfluxDB | | | | Database build for time series such as operations monitoring, application metrics, Internet of Things sensor data, and real-time analytics.  |