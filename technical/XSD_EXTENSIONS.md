<!--
SPDX-FileCopyrightText: 2021 Alliander N.V.

SPDX-License-Identifier: CC-BY-4.0
-->

## XSD Extensions
For generating the SCL classes, we use the official IEC SCL XSD schemas. These are stored in the [XSD repository](https://github.com/com-pas/compas-scl-xsd). Every week, different Github Actions check for newer version of these XSD schemas. In case newer versions are available, the Github Actions fail and people will get notifications.

In case organizations need some specific information in their SCL files, so called "XSD extensions" can be used. These are separate XSD files containing additional fields or other information that can be used.

### Using your own XSD extensions
Because the SCL XSD schemas are stored in a separate repository and are available as a separate [library](https://github.com/com-pas/compas-scl-xsd/packages/817016), every project that wants to use it needs to include the dependency and unpack the schemas. When doing this, a project is free of how to use them.

#### CoMPAS-broad XSD extensions
In case we need CoMPAS-broad specific XSD schemas, these can be added to the [XSD repository](https://github.com/com-pas/compas-scl-xsd). Added them is enough, the project including the dependency needs to make sure it's used correctly, e.g. validation should be done by the application itself.

### Example
Let's say you want to use a `Filename` element and a `FileType` element, which has been declared in `SCL_CoMPAS.xsd` as found in the [CoMPAS XSD Repository](https://github.com/com-pas/compas-scl-xsd). We do this by adding:

```xml
<!-- #(1) -->
<SCL xmlns="http://www.iec.ch/61850/2003/SCL" xmlns:compas="https://www.lfenergy.org/compas/v1">
	<Header id="someId"/>
	<!-- #(2) -->
 	<Private type="compas_scl">
		<!-- #(3) -->
	 	<compas:Filename>MyFilename</compas:Filename>
	 	<compas:FileType>SSD</compas:FileType>
	</Private>
	<Substation name="mySubstation"/>
</SCL>
```

Few points:
- (1): Include the namespace of the XSD to include, in this case it's `https://www.lfenergy.org/compas/v1`. Give it a name like (in this case) `compas`.
- (2): Create a Private element in the SCL. We could declare the elements without surrounding it with a Private, but the advantage of using private elements is that the data content is preserved at data exchange between tools. For more information, see section 8.3.6 in the IEC-61850-6 standard.
- (3): Declare the elements inside the Private element, in this case the `Filename` and the `FileType` elements.

**Make sure validation is done correctly by project's own validation!**
