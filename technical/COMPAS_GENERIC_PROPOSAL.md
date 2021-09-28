<!--
SPDX-FileCopyrightText: 2021 Alliander N.V.

SPDX-License-Identifier: CC-BY-4.0
-->

## Proposal for Generic Components

There is a discussion about which technology can be used, because not all companies are allowed to use the proposed 
technology choices Quarkus. But for some companies Quarkus is a needed technology to make the footprint smaller.

To make the code be used by as many companies as possible we can decide to set some ground-rules which libraries can 
be used in different part of the service. Below is an example out of which modules a service can be build. 

![Component Diagram](images/CoMPAS-GenericComponent-Diagram.png)

For instance the SCL Data Service has a Quarkus Rest Module, which uses the Service and Repository Module.
Every module is build and published separately. These artifacts can be used in custom implementations. 
The default runtime container will use Quarkus with a Rest Interface as implementation, but a company-specific 
implementation can be build, for instance with Spring, but still uses larger parts of the module. 

For instance Quarkus is using the standard Jakarta EE, so a lot of work is done out-of-the-box.
Quarkus will use jandex to know which beans are available to be used. But like Spring there can also be 
a configuration class to produce beans that are not indexed or even have bean annotations.

Spring is using its own annotations, so some extra configuration is always needed to create all necessary bean
in a Spring Configuration class. Below is an example how to create a bean from a standard Java class.
```
@Configuration
public class ServiceConfiguration {
  @Bean
  @Autowired
  public SomeBeanClass createSomeBean(OtherDependingBean otherBean) {
    return new SomeBeanClass(otherBean);
  }
}
```

Because we are only using standard Java and Jakarta class both implementations (Spring and Quarkus) can be 
used to run the standardized classes.
