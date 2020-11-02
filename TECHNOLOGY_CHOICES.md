# Technology Choices
# Database
## Checks for determining database
- Database should be able to store XML data
- Database should be relational, because we need relations between files/pieces of files/models
- Database must be provided with the solutions, for example part of a Docker image
- Support must be available, in case of trouble.
- Database must be open-source, because the whole solution must be open-source

## PostgreSQL
Homepage: https://www.postgresql.org/
### Pros
- Open Source, relational database
- PostgreSQL does have XML functions for handling XML files (XMLTABLE)
- XMLTABLE turns XML into a relational table format
- Good support available
- [Docker image](https://hub.docker.com/_/postgres) available
- Does have XML validation when using the XML type field.

### Cons
- Not a native XML database

## CouchDB
Homepage: https://couchdb.apache.org/
### Pros
- The one con we have is decisive.

### Cons
- Cannot store XML as key/property, but as blob. This makes querying a bit challanging.

## BaseX
Homepage: https://basex.org/

### Pros
- Native XML database
- Fully Open Source
- Good license! (BSD)
- Easy to setup using available Docker image
- Cross-platform
- Active community
- Multiple API's, like REST(ful) and HTTP

### Cons
- No clear use cases using BaseX

## eXist-db
Homepage: http://exist-db.org/exist/apps/homepage/index.html
### Pros
- Native XML database
- Fully Open Source
- Cross-platform
- Active community (weekly community call, Slack channels, books), so if we need support it's (almost) directly available
- Docker image available
- Multiple query languages like HTTP, REST, xQuery and xPath
- Can act like a relational database, so relations between xml fragments for example is possible.
- Includes XML validation

### Cons
- Using LGPL software is discouraged by Alliander when __modifying__ source code. So if we want to add features to eXist-db in the future, our source code needs to be released using the same license.
- No SQL available (is this needed?)
- Doesn't have all the ACID properties according to [vschart](http://vschart.com/compare/exist-db/vs/postgresql). Isolation is unknown, can't find other sources which confirm this.
- Not well known, no clear use cases in production. There are some [here](http://showcases.exist-db.org/exist/apps/Showcases/index.html)
- eXist needs JRE (Java Runtime Environment) to run

## Advice Rob
I prefer eXist-db as the database/register for our XML data (based on what we need). It's an open source, cross-platform native XML database with an active community and all the functionality we are looking for.

A second option is using PostgreSQL. A stable, open source RDBMS which can also handle XML using the XMLTABLE functionality. But because it's not the native functionality of PostgreSQL (handling XML), I prefer a native XML database like eXist-db.

My only concern is the maturity of eXist-db. I can't find good use cases of eXist-db, and I'm not sure of the stability in production for example. Let me know if someone knows some use cases, or maybe someone has experience with eXist-db.

__Edit 2__: After discussing database choices within Alliander, eXist is indeed an option, but the license could be a problem. BaseX can do the same as eXist-db (as it seems) and has a better license for our situation (BSD).
Also, because the idea is to have an abstract interface layer between CoMPAS and the database, people can also choose to use a different database in the future.