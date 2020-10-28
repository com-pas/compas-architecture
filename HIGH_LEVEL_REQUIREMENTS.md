## High Level Requirements

For the CoMPAS project, high-level requirements are set up.
Together with the Technical Architecture, it should be possible to make the correct technology choices related to the requirements.

### System configuration
 - “System Specification Description (SSD)” to “Substation Configuration Description (SCD)” conversion
 - PACS policy registry 
 - API to vendor specific IED configurators
 - Provenance (W3c PROV)
 - Audit trail

### IEC61850 profile management
 - logical device/function builder
 - library of common profiles for usual functions
 - versioning of IEC-61850 formats, like ICDs, SCL's and NSD's.
 - definition of reusable user profile of IEC 61850 data model (potentially continue/restart ENTSO-E profiling tool)

### IEC-61850 SCL verification
 - Conformity verification of System Configuration description Language (SCL) files

### System specitifcation
 - profile to “System Specification Description (SSD)” conversion
 - PACS policy registry (scripts?)
 - API to vendor specific “IED Capability Description (ICD)” tools (not in direct scope, Nice To)
 - ICD conformity check
 - ICD compatibility management
 - ICD versioning / repository

### PACS Availability
 - Availability of Substation PACS data at enterprise level (Functions & settings, operational process data)

### Mapping functions between CIM and IEC 61850
 - ...

### Compare functions
 - Compare configurations (ICDs for example)

### Non-functional Requirements

 - User Manual
 - System Documentation
 - How do we handle event failures?
 - Response times (output)
 - Processing times (input)
 - Timeouts for processing
 - Access levels / Role based access
 - Access permissions for certain application parts
 - Scalability of the application (use case: size of the SCL files)
 - How to handle log files (rotating?)
 - Deployment models
 - Cross platform compatibility
 
 ## 61850 Requirements
Requirements based on IEC 61850-6 10.2 System configurator

-	The SSD describes the one-line diagram and the automation functions
  -	Essential – make corrections = CRUD operations on any item, or sets of items, preserving referential integrity
  -	Nice to have :  visualize this on a diagram  = requires extensions for graphics plus pan/zoom/layering features

-	The SSD will describe the communications devices
  -	Essential – import ICD, CID, IID files of various versions and compile composite DataTypeTemplates for the client(s)
  -	Delete devices and all associated relationships
  -	Edit IP addresses
  -	Nice to have :  visualize this on a diagram  = requires pan/zoom/layering features

-	The SCD describes the binding (mapping) between the required LNs per equipment/function
  -	Assign / unassign / reassign LNs from IEDs to equipment
  -	Per IED, show/ edit data set definitions
  -	Per IED, show / edit report control block definitions

- 	Export functions
  -	Export SCD in appropriate version for clients
  -	Nice-to-have: export subset per IED in appropriate version (i.e. ICD + goose subscription information)/(IEC 61850-6 says this is an IED configurator function)

IEC 61850-6 Table G.2 – System configurator conformance statement  has three pages of function headings some of which are complex


#### Sources for non-function requirements:
- https://iso25000.com/
- https://dalbanger.wordpress.com/2014/01/08/a-basic-non-functional-requirements-checklist/
- http://www.it-checklists.com/Examples_nonfunctional_Requirements.html
