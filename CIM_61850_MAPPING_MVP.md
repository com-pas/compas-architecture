## Architecture for CIM - IEC 61850 mapping.

To do the mapping, we need some kind of XML processing tool for processing incoming / outgoing XML files.

### What it should do
- Manipulate XML files
- Can be used within the Java programming language
- Not using an extra library is a pro
- Memory efficient is a pro (because of the running locally or in the cloud requirement)

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
Combined with the fact that being memory efficient is a pro, JAXB would be ideal to use!