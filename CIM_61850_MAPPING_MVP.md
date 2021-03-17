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

### Architecture overview
![mapping architecture overview](./images/CIM_61850_mapping_architecture_overview.svg)
The plan is to convert incoming CIM files to a RDF4J model. Because the assumption can be made that all incoming CIM files are using the RDF framework, RDF4J can be used to create a model of this file so you can easily query it.

Based on this model, a mapping can be made to a SCL file which is based on the IEC 62361-102 standard. A SCL (XML) file can be created with JAXB.