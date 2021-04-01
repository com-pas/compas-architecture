# Technology

This page lists the technologies and tools chosen for the project

![Current technology choices](./images/Current_Technology_Choices_Overview.svg)

# Technology Choices
## Programming language - Java
Java 11 is chosen as programming language. 
- Java is well known in the energy sector
- Developers are available
- Java is familiar within LFE projects

## Java build environment - Gradle
For building the applications we use Gradle. Gradle is good suppored in CI/CD.

## Microservice deployment - Docker
Microservices are deployed as Linux based Docker container. Advantages of deployment in Docker container:

- Deployment is independent of deployment platform/OS
- Well supported for cloud deployment
- Tooling readily availabe
- Open source
- Scalable, redundant
- Images can be distributed easily


## Database - BaseX
For the database BaseX](https://basex.org/) is chosen on following arguments:

**Pros**
- Native XML database
- Fully Open Source
- BSD license
- Easy to setup using available Docker image
- Cross-platform available
- Active community
- Multiple API's, like REST(ful) and HTTP
- [ACID guarantees](https://docs.basex.org/wiki/Transaction_Management)
- Many [usage examples](https://docs.basex.org/wiki/Clients) available in different programming languages

**Cons**
- No clear use cases using BaseX
- Versioning is not out-of-the-box available. Need to use a second database to create 'versioning', which creates an archive database and a current database. And by using RESTXQ is relatively easy to create a versioning mechanism. BaseX gave [SirixDB](https://sirix.io/) as a good alternative in case we want a NoSQL database with versioning mechanism.

## XML Processing - Mainly JAXB for processing XML, RDF4J for IEC CIM configuration files

**Pros JAXB**
- Java library for processing XML
- Memory efficient (for more information, take a look at the comparison in [CIM - 61850 Mapping technologies](./CIM_61850_MAPPING_MVP.md))
- JAXB has the XJC tool for creating Java classes from XSD schemas (validation). This way, a XML file can be easily build by inserting data into the models.

**Cons JAXB**
- JAXB was part of the Java language, but has been removed from the language since Java version 11. To use it, you have to add an extra dependency.

**Pros RDF4J**
- Java library for querying RDF(XML) files
- Well known in the Java community
- Not having to re invent the wheel of processing incoming IEC CIM configuration files

**Cons RDF4J**
- If you don't have experience with triples, it might take a while before understanding it all.

## Java framework - Quarkus
For the framework to be used with Java we choose [Quarkus](https://quarkus.io/).

**Pros**
- Java stack, and working experience is avaiable in the community
- Open Source
- Hot reload for quick development
- Less verbose code when developing REST API's, compared to for example Java Spring
- Tailored for GraalVM (universal VM), which is also very interesting for us (usage of resources)
- Huge decrease of memory huge compared to traditional cloud-native stacks like Java Spring.
- Huge decrease in response times compared to traditional cloud-native stacks like Java Spring.
- Backed by RedHat
- Quickly settings up microservices with REST APIs

When looking at the memory usage (and response times) of Quarkus, it's definitely interesting for us. Also take a look at this [comparison with Java Spring](https://simply-how.com/quarkus-vs-spring-boot-production-performance)

Because CoMPAS is an application which also should run locally, memory usage is an important aspect. Together with being a modern microservice framework, backed by RedHat and being a Java framework (which we are having experience with) it's the best choice for now!

**Cons**
- Doesn't support full set of some EE standards, like Enterprise JavaBeans. Expected is that it's not a game breaker for us.
- Relatively new technology, framework could contain some "rookie mistakes". On the other hand, multiple researches are stating the maturity of the framework it achieved in this short time.
- Not much developers are acquainted with Quarkus compared to e.g. the [Spring framework](https://spring.io/).

## Source control - Github
We choose github for source control. This is good practice for open source development. 
The CoMPAS repositories can be found at [https://github.com/com-pas/](https://github.com/com-pas/) 

## CI/CD - Github actions
We choose [Github Actions](https://github.com/features/actions) as mechanism for CI/CD. 

**Pros**
- Upcoming tool, really active in developing
- Free tool for public Github repositories (which CoMPAS is)
- Integrates perfectly with Github repositories

**Cons**
- Software is proprietary
- Adoption is growing within Alliander



# Tool advise
This section lists the development tooling that is *advised*. Of course developers are free to use their own developement tooling

## SDE - Microsoft Visual Studio Code
[Microsoft Visual Studio Code](https://code.visualstudio.com/) is a versatile develpment environment supporting many languages. 

