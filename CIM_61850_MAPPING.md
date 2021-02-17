## Mapping CIM - IEC 61850

We got a mapping example from GE, they already created a mapping between CIM files and IEC 61850 files.
We used the IEC 623610-102 standard to compare it with the example we got from GE.

The goal is to compare a few components, to see if we are able to say: We can use this mapping!
This way, we don't have to figure it all out ourselves.

### Findings
We see the following CIM components in the mapping example:

Bay
Breaker
ConnectivityNode
Disconnector
EnergyConsumer
LoadBreakSwitch
PowerTransformer
PowerTransformerEnd
Substation
Terminal
VoltageLevel

- Substation seems to be okay, there might be some tricky situations I'm not aware of.
- PowerTransformer* looks not complete. According to the IEC 62361-102 standard, the SCL equivalent is 'TransformerWinding', this is done differently.
- Components like Terminal and Bay are looking fine!

#### Missing some SCL elements
- whole 'Process' SCL element mapping
- whole 'Line' SCL element mapping
- whole 'GeneralEquipment' SCL element mapping
- whole 'SubEquipment' SCL element mapping
- whole 'Function'/'SubFunction'/'EqFunction'/'EqSubFunction' SCL element mapping
- whole 'Tapchanger' SCL element mapping

## Questions
- the open_substation.scd file contains a SCL section. Is this considered the header? (Because it has stuff like version and revision in it)
- What to do with the Header section of an SCL file? Create a new one?

## Source

- IEC/TS 62361-102:2018