<!--
SPDX-FileCopyrightText: 2021 Alliander N.V.

SPDX-License-Identifier: CC-BY-4.0
-->

## XSD Extensions
For generating the SCL classes, we use the official IEC SCL XSD schemas. These are stored in the [XSD repository](https://github.com/com-pas/compas-scl-xsd). Every week, different Github Actions check for newer version of these XSD schemas. In case newer versions are available, the Github Actions fail and people will get notifications.

In case organizations need some specific information in their SCL files, so called "XSD extensions" can be used. These are separate XSD files containing additional fields or other information that can be used.

### Using your own XSD extensions
Because the SCL XSD schemas are stored in a separate repository and are available as a separate [library](https://github.com/com-pas/compas-scl-xsd/packages/817016), every project that wants to use it needs to include the dependency and unpack the schemas. When doing this, a project is free of how to use them.

XSD schema extensions can be included in the base SCL XSD schemas by using the [xsd:import](https://www.w3.org/TR/xmlschema-1/#composition-schemaImport) (different namespace) or the [xsd:include](https://www.w3.org/TR/xmlschema-1/#compound-schema) (same or no namespace) statement.

#### Project specific XSD extensions
Project specific XSD schemas can be defined within the project itself. By using the previous import and include statements, they can be included and used. **This means that during unpacking the base SCL XSD library, this include/import/use process should be added before generating classes**.

#### CoMPAS-broad XSD extensions
If we need CoMPAS-broad specific XSD schemas, these can be added to the [XSD repository](https://github.com/com-pas/compas-scl-xsd). **This means that during the build of the SCL XSD library, this include/import/use process should be done**.

### Example
Upon the base SCL XSD schemas, we have a schema named `extension.xsd` containing the following:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>

<xs:schema version="1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xs:element name="Extension" type="reqExtension" />

<xs:complexType name="reqExtension">
    <xs:sequence>
        <xs:element name="MsgId" type="xs:string" minOccurs="0" />
        <xs:element name="MsgDesc" type="xs:string" minOccurs="0" />
    </xs:sequence>
</xs:complexType>
```

Let's say you want to use this `Extension` named element inside your own XSD (in our case one of the base SCL XSD schemas). This can be done quite easily by doing:

```xml
<xs:schema attributeFormDefault="unqualified"
elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">

<!-- #(1) -->
<xs:include schemaLocation="header.xsd" /> 

<xs:element name="Substation">
    <xs:complexType>
        <xs:sequence>
            ...

            <!-- #(2) -->
            <xs:element name="Extension" type="reqExtension" />

            ...
        </xs:sequence>
    </xs:complexType>
</xs:element>
```

Few points to remember:
- (1): Include other XSD schemas. (If the namespace is different, use the xsd:import element as stated above).
- (2): Use the element where you want in the XSD schema.