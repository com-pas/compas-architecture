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

#### Sources for non-function requirements:
https://iso25000.com/
https://dalbanger.wordpress.com/2014/01/08/a-basic-non-functional-requirements-checklist/
http://www.it-checklists.com/Examples_nonfunctional_Requirements.html