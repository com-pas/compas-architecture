# CoMPAS Architecture

Interested in contributing? Please read carefully the [CONTRIBUTING guidelines](https://github.com/com-pas/contributing/blob/master/CONTRIBUTING.md).

Refer to [GLOSSARY](./GLOSSARY.md) for technical terms and acronyms.

## Functional architecture

### Overall functional block diagram
![CoMPAS functional block diagram](./functional-diagrams/CoMPAS_functional_block_diagram_v1.svg)

### System Configuration Tool (SCT) functional diagram
![SCT functional diagram](./functional-diagrams/SCT_functional_diagram_v1.svg)


## Technical architecture
### Overview
![CoMPAS technical overview](./technical-overview/CoMPAS_technical_architecture_overview.svg)

### Technnology Survey
An initial survey was taken to determine some technologies we could use:

| Technology                     | Name Technology | Benfits | Challenges | Reference Project |
| ------------------------------ |:---------------:| -------:| ----------:| -----------------:|
| Microservices (cross-platform) | Java Spring or Python Flask | Isolation of features in microservices speed up the development | Limiting number of microservices to a manageable number. | | 
| Scripting                      | Python | Flexible. Object oriented. Cross platform. | No standard libraries, need to agree on subset. | | 
|                                | No code technology | Non developper user can build their own user story built on predevelopped blocks | No many opensource solution and most of them are proprietary | |
| APIs                           | REST, Message queue such as Kafka? | | | | 
| XML processing & file database | sax.js             | Memory efficient. Don't need to have XML file sized RAM | Needs to track state while parsing due to streaming nature of API | https://github.com/StevenLooman/saxpath |
|                                | xQuery, XSLT, XPath|    Standard technologies for XML processing and XML DB querying | Overlapping use cases of very different technologies | https://github.com/BaseXdb/basex |
|                                | RiseClipse | Validates SCL files more precisely than with XSD (using rules expressed in OCL - Object Constraint Language) also validates CIM files | | https://github.com/riseclipse |
|                                | xerces? | fast, work well with big files | | |
| Managing microservices         | container based Microservices using Kubernetes? | | | |
| XML versioning                 | Version through file repository or database, see below | Versioning is automatic if file repo or database are chosen to include this feature | | |
|                                | Something similar to CGMES? Each file hasa header with identification, type and version information of the file. | Files are uniquely identified | | |
| Securing SCL XML files         | GPG Encryption | Industry standard (PGP) text encryption, for transport and storage | | https://github.com/StackExchange/blackbox |
| File repository vs database    | GIT SCM vs Datomic | Both technologies model time meaningfully, Datomic with schema and git with unstructured data | | https://git-scm.com/ vs https://www.datomic.com/ |
|                                | SQLite | Embedded in app. No separate server needed. | Not as powerful as database server. | https://sqlite.org/index.html |
|                                | I would go with file repository for big XML files. | | | |