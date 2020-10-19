# Technology Choices

# Databases
- PostgreSQL
- Neo4J
- CouchDB
- eXist-db

## Checks for determining database
- Database should be able to store XML data
- Database should be relational, because we need relations between files/pieces of files/models
- Database must be provided with the solutions, for example part of a Docker image
- Support must be available, in case of trouble.
- Database must be open-source, because the whole solution must be open-source

## PostgreSQL
Homepage: https://www.postgresql.org/

### Pros
- Open Source (not entirely, working with patches)
- Fully supports ACID

### Cons
- Does not support XML out-of-the-box

## Neo4J

## CouchDB

## eXist-db
Homepage: http://exist-db.org/exist/apps/homepage/index.html

### Pros
- Native XML database
- Fully Open Source
- Cross-platform
- Active community (weekly community call, Slack channels, books)
- Docker image available
- Multiple query languages like HTTP, REST, xQuery and xPath
- Can act like a graph database, so relations between xml fragments for example is possible.
- Supports XML validation (https://exist-db.org/exist/apps/doc/validation.xml)

### Cons
- Using LGPL software is discouraged by Alliander when __modifying__ source code. So if we want to add features to eXist-db in the future, we might have a problem.
- No SQL available (is this needed?)
- Doesn't have all the ACID properties according to [vschart](http://vschart.com/compare/exist-db/vs/postgresql). Isolation is unknown, can't find other sources which confirm this.
- Not well known, no clear use cases in production. There are some [here](http://showcases.exist-db.org/exist/apps/Showcases/index.html)
- eXist needs JRE (Java Runtime Environment) to run

# XML Processing
## RiseClipse

## Schematron
### Pros
- There is a XQuery library module for eXist-db (https://github.com/Schematron/schematron-exist)
- Rule-based approach. If assertion fails, a message is being supplied
- Based on XSLT and xPath, so very flexible in manipulating/processing XML
- Suggesting XML fixes
- Referencing other XML documents as constraint validation
- XSL Processor like [Saxon-HE](http://saxon.sourceforge.net/) is easy to use

### Cons
- Not an application itself, needs a XSL processor like [Saxon-HE](http://saxon.sourceforge.net/) which is also open-source

## BaseX
### Pros
- Fully Open Source
- Active development
- Docker image available at https://hub.docker.com/r/basex/basexhttp/. When running the docker image, REST, RESTXQ and WebDAV services can be used
- BSD-3 Clause License, so no limitations
- [Command line](https://docs.basex.org/wiki/Command-Line_Options) available

### Cons
- No out-of-the-box IEC 61850 support, so we need to implement some stuff ourselves
- Command Line / Services doesn't seem as powerful as their editor, and I don't think we want to use an editor like BaseX Editor or Eclipse
- If we don't use the Docker container, it seems that we need to use Eclipse to run it
- Seems a bit heavy with underlying XML database
- Needs Java Runtime
- All found use cases are pretty old