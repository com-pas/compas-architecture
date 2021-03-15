# Technology Choices
The right technology choices are key to a good project.

# Current Technology Choices
![Current technology choices](./images/Current_Technology_Choices_Overview.svg)

# XML Processing
## Checks for determining XML processing
- Can manipulate/check XML configuration files by using rules
- Can be embedded in our solution
- Tool must be open source

## RiseClipse
### Pros
- Main use is validating IEC 61850/IEC CIM configuration files, exactly what we need.
- Usage experience within Alliander
- [Docker image](https://hub.docker.com/r/riseclipse/riseclipse-validator-scl) available
- Add own validation rules (in Object Constraint Language)

### Cons
- Development doesn't seem very active
- Community is limited / not very active ( See [GitLab](https://gitlab-research.centralesupelec.fr/groups/RiseClipseGroup/-/activity) and [GitHub](https://github.com/riseclipse) )

## Schematron
### Pros
- There is a XQuery library module for eXist-db (https://github.com/Schematron/schematron-exist)
- Rule-based approach. If assertion fails, a message is being supplied
- Based on XSLT and xPath, so very flexible in manipulating/processing XML
- Suggesting XML fixes
- Referencing other XML documents as constraint validation
- XSL Processor like [Saxon-HE](http://saxon.sourceforge.net/) is easy to use

### Cons
- Not an application itself, needs a XSLT processor like [Saxon-HE](http://saxon.sourceforge.net/) which is also open-source

## Advice Rob
My advice would be to use Schematron (in combination with an XSLT processor) as the XML processing tool.
It can do what RiseClipse can do, and more (like suggesting XML fixes and it's more flexible because it works with native XML technologies). Plus, it works in combination with eXist-db. 

Examples:
https://en.wikibooks.org/wiki/XQuery/Validation_with_Schematron#Setup_in_eXist-db

https://exist-db.org/exist/apps/doc/validation

https://github.com/Schematron/schematron-exist

RiseClipse is also a good candidate, because it's dedicated on IEC 61850/CIM validation.
Only thing is, it's not as flexible as using Schematron. But I really do like the combination Schematron and eXist-db/BaseX.

# Microservice technology
A good technology is key to a good microservice.

But be aware: it's not a definitive technology.
Multiple microservices can have multiple technologies, that's the cool thing about microservices.
Just create them and put them in a microservice which lives next to the other ones. By using a REST API, it can communicate with the other ones for example.
## Checks for determining microservice technology
- Technology should be accepted by the open source community
- Technology should not be completely new to the community, so we can make some quick progression
- Components should be independent deployable (for example the CIM conversion component, in case it needs an update)
- Components should be highly observable (monitoring)

## Quarkus
https://quarkus.io/
### Pros
- Java stack, and working experience is avaiable in the community
- Open Source
- Hot reload for quick development
- Less verbose code when developing REST API's, compared to for example Java Spring
- Tailored for GraalVM (universal VM), which is also very interesting for us (usage of resources)
- Huge decrease of memory huge compared to traditional cloud-native stacks like Java Spring.
- Huge decrease in response times compared to traditional cloud-native stacks like Java Spring.
- Backed by RedHat
- Quickly settings up microservices with REST APIs

### Cons
- Doesn't support full set of some EE standards, like Enterprise JavaBeans. Expected is that it's not a game breaker for us.
- Relatively new technology, framework could contain some "rookie mistakes". On the other hand, multiple researches are stating the maturity of the framework it achieved in this short time.

## Java Spring
https://github.com/spring-projects/spring-framework
### Pros
- Preferred language for Alliander
- Lots of experience within CoMPAS community
- Using Spring (Boot), it's very easy to quickly setup a microservice
- Massive community
- Java uses annotation syntax, which makes Java a great language for developing microservices in terms of readability
- It's more mature compared to for example Spark Java, which is also an option
- Contains great logging functionality using Logback or SLF4J for example
- CLI available

### Cons
- Pretty complex if you never worked with Java Spring
- Java is pretty slow compared to the other ones

## Go Micro
https://github.com/micro/micro
### Pros
- Great concurrency possibilities
- Quick issue fixing by the maintainer
- Lots of examples usages in the Go Micro repository

### Cons
- Not as mature as Java Spring for example
- Documentation is mostly source code, so maybe not as easy to read for some people
- Errors are not always self-explaining

## Python Flask
https://github.com/pallets/flask
### Pros
- Python is really easy to write, quick learning curve and quick prototyping
- The Flask framework is easy to understand compared to other technologies (not much overhead or boilerplate)

### Cons
- If you never used Flask before, it needs some work to get into it
- Flask handles requests one at a time (not async). So multiple requests take more time. If CoMPAS will have a lot of users at the same time, this might be a problem

## NestJS w/ NodeJS
https://github.com/nestjs/nest
### Pros
- The main microservice platform for enterprises and startups who want to embrace microservices
- Annotation driven, so Java developers should feel great using NestJS
- Swagger documentation is automaticaly generated from API endpoints
- NestJS uses the latest Typescript version, so it keeps up with the almighty Javascript world
- CLI available
- Monitoring ad health checks are available by using NPM.

### Cons
- Lack of documentation
- Not a lot of backing power, compared to for example Go Micro (Google). So the question is how long it can live, living to huge competitors like Go Micro and Java Spring.

## Advice Rob
Python Flask en Java Spring are very close and can both be used for our purposes.

It's an advantage that there is more Java Spring experience compared to Python Flask, so the suggestion is to use Java Spring. Also based on the checks I made.
Rob also made a Minimal Viable Product of a microservice using Java Spring and BaseX, which was very quick to setup and works very well.

NestJS also looks very promising, but the lack of documentation is a game changer for me. Go Micro is also a good candidate, but the lack a maturity made me decide not to choose for Go Micro.

Edit: When looking at the memory usage (and response times) of Quarkus, it's definitely interesting for us. Also take a look at this [comparison with Java Spring](https://simply-how.com/quarkus-vs-spring-boot-production-performance)

Because CoMPAS is an application which also should run locally, memory usage is an important aspect. Together with being a modern microservice framework, backed by RedHat and being a Java framework (which we are having experience with) it's the best choice for now!
