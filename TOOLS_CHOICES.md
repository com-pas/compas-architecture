<!--
SPDX-FileCopyrightText: 2021 Alliander N.V.

SPDX-License-Identifier: Apache-2.0
-->

# Tools Choices
The right tool choices are key to a good project.
# CI/CD tool
These build tools are evaluated:
- Github Actions
- Travis CI
- Jenkins

## Checks for determining CI/CD tool
- Must be available to the community
- No/less maintenance
- Integratable with Github (because that's where our repositories are)

## Github Actions
### Pros
- Upcoming tool, really active in developing
- Free tool for public Github repositories (which CoMPAS is)
- Integrates perfectly with Github repositories

### Cons
- Software is proprietary
- Adoption is growing within Alliander

## Travis CI
### Pros
- Very much used CI/CD tool for Open Source projects

### Cons
- Not used within Alliander, so no experience or know-how
- No advantages compared to the other evaluated tools

## Jenkins
### Pros
- Lots of experience within Alliander
- Well known in the industry of Software automation

### Cons
- Not easy to make public (which is what we want)
- Security of Jenkins often has security leaks
- Jenkins is being replaced within Alliander

## Advice
Github Actions is the way to go for us.

Because we host our repositories in Github, Github Actions is easily integratable, free and very flexible.
We can use it in combination with SonarCloud for example for static code analysis.
And above all, everyone can access it.