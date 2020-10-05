# Technology Choices

## Databases
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

### Cons
- Using LGPL software is discouraged by Alliander when __modifying__ source code. So if we want to add features to eXist-db in the future, we might have a problem.
- No SQL available (is this needed?)
- Doesn't have all the ACID properties according to [vschart](http://vschart.com/compare/exist-db/vs/postgresql). Isolation is unknown, can't find other sources which confirm this.
- Not well known, no clear use cases in production. There are some [here](http://showcases.exist-db.org/exist/apps/Showcases/index.html)
- eXist needs JRE (Java Runtime Environment) to run