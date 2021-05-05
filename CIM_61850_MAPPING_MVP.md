<!--
SPDX-FileCopyrightText: 2021 Alliander N.V.

SPDX-License-Identifier: CC-BY-4.0
-->

## Architecture for CIM - IEC 61850 mapping.

To do the mapping, we need some kind of XML processing tool for processing incoming / outgoing XML files.

### What it should do
- Manipulate XML files
- Can be used within the Java programming language
- Not using an extra library is a pro
- Memory efficient is a pro (because of the running locally or in the cloud requirement)
- Handle RDF formats (because the assumption can be made that all incoming CIM files are using the RDF framework)

### Options found
Within Java, there are basically 4 XML support API definitions:
- SAX
- DOM
- StAX
- JAXB

Each of these has it's own pros and cons:

|                          | SAX                                 | DOM                                 | StAX                                | JAXB                                |
| :----------------------- | :---------------------------------- | :---------------------------------- | :---------------------------------- | :---------------------------------- |
| Memory efficient         | <span style="color:green">Ok</span> | <span style="color:red">No</span>   | <span style="color:green">Ok</span> | <span style="color:green">Ok</span> |
| Bidirectional navidation | <span style="color:red">No</span>   | <span style="color:green">Ok</span> | <span style="color:red">No</span>   | <span style="color:green">Ok</span> |
| XML manipulation         | <span style="color:red">No</span>   | <span style="color:green">Ok</span> | <span style="color:red">No</span>   | <span style="color:green">Ok</span> |
| Data binding             | <span style="color:red">No</span>   | <span style="color:red">No</span>   | <span style="color:red">No</span>   | <span style="color:green">Ok</span> |

Source: Baeldung.com

According to this table, we have 2 options left is we want to manipulate the XML configuration files: DOM and JAXB.
Combined with the fact that being memory efficient is a pro, JAXB would be ideal to use for XML processing!

### Incoming CIM files
Because of the assumption that all incoming CIM files are using the RDF framework, it's not smart to use JAXB for incoming CIM files.
If we would do that, we are re-inventing the wheel.
There are some other libraries to handle these kinds of RDF files.
[RDF4J](https://rdf4j.org/) and [Apache Jena](https://jena.apache.org/) are mostly used for this.
They don't differ that much in their qualities, so it's actually a matter of taste which one to use. Both are also open source, so they fit perfectly in the CoMPAS architecture.

We decided to use RDF4J, because it has plenty of examples in [PowSyBl](https://github.com/powsybl/powsybl-core) and it has a great and active [community](https://github.com/eclipse/rdf4j).

### Outgoing SCL files
For the outgoing SCL file, we already have the Java models to fill in. We generate these Java models based on the IEC-61859-6 XSD schemas by using the JAXB XJC tool. This way, the only thing we have to do is adding the data from the RDF4J model to the IEC 61850-6 SCL model. And the final step is to 'marshal' this Java model to a XML file.

### Mapping of RDF4J data to SCL Java classes
The mapping itself is being done with [Orika](https://orika-mapper.github.io/orika-docs/). Orika is a Java bean for mapping data between two classes and makes it more simple.

Mapping is done between a RDF4J model (statement) and a SCL class.

### Architecture overview
![mapping architecture overview](./images/CIM_61850_mapping_architecture_overview.svg)

### References
IEC 61970-301: Common Information Model

IEC 61970-552: Specification of CIMXML
