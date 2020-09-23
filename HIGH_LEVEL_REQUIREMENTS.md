## High Level Requirements

### System configuration
 - “System Specification Description (SSD)” to “Substation Configuration Description (SCD)” conversion
 - PACS policy registry 
 - API to vendor specific IED configurators

### IEC61850 profile management
 - logical device/function builder
 - library of common profiles for usual functions
 - versioning
 - definition of reusable user profile of IEC 61850 data model (potentially continue/restart ENTSO-E profiling tool)

### SCL verification (?)
 - Conformity verification of System Configuration description Language (SCL) files

### System specitifcation
 - profile to “System Specification Description (SSD)” conversion
 - PACS policy registry (scripts?)
 - API to vendor specific “IED Capability Description (ICD)” tools
 - ICD conformity check
 - ICD compatibility management
 - ICD versioning / repository

### PACS Availability (?)
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
 - Access levels
 - Access permissions for certain application parts
 - Scalability of the application
 - How to handle log files (rotating?)
 - ...