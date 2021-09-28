<!--
SPDX-FileCopyrightText: 2021 Alliander N.V.

SPDX-License-Identifier: CC-BY-4.0
-->

## XSD Extensions
If for some reason you need extended elements/attributes next to the IEC XSD schemas, we define separate XSD schemas.
These are stored in the `scl-extension` module of the [CoMPAS Core repository](https://github.com/com-pas/compas-core).
An example is the [CoMPAS XSD](https://github.com/com-pas/compas-core/blob/develop/scl-extension/src/main/resources/xsd/SCL_CoMPAS.xsd).

Another option was using the [CoMPAS IEC XSD repository](https://github.com/com-pas/compas-scl-xsd), but we want to keep that repository dedicated to the IEC XSD schemas.

#### CoMPAS-broad XSD extensions
In case we need CoMPAS-broad specific XSD schemas, these can be added to the `scl-extension` module of the [CoMPAS Core repository](https://github.com/com-pas/compas-core) as stated above. Added them is enough, the project including the dependency needs to make sure it's used correctly, e.g. validation should be done by the application itself.

### Example
Let's say you want to use a `Filename` element and a `FileType` element, which has been declared in `SCL_CoMPAS.xsd` as found in the `scl-extension` module in the [CoMPAS Core Repository](https://github.com/com-pas/compas-core). We do this by adding:

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
- (1): Include the namespace of the included XSD elements and/or attributes, in this case it's `https://www.lfenergy.org/compas/v1`. Give it a prefix name like (in this case) `compas`.
- (2): Create a Private element in the SCL. 
  We could declare the elements without surrounding it with a Private, but the advantage of using private elements is that the data content is preserved at data exchange between tools. For more information, see section 8.3.6 in the IEC-61850-6 standard.
  Also, the type is an important aspect of a Private elements (also because it's required). For CoMPAS Private elements, we used the `"compas_scl"` type to distinguish it from other Private elements.
- (3): Declare the elements inside the Private element, in this case the `Filename` and the `FileType` elements.

**Make sure validation is done correctly by project's own validation!**
