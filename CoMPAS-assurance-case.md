<!--
SPDX-FileCopyrightText: 2026 Alliander N.V.
SPDX-FileCopyrightText: 2026 Schielder IT.
SPDX-License-Identifier: CC-BY-4.0
-->

# CoMPAS basic Assurance Case

In June 2026, a basic Threat Model Assessment of CoMPAS OpenSCD was conducted by Shielder IT. CoMPAS OpenSCD is a browser-based editor for IEC 61850-6 System Configuration Language (SCL) files, used to design and configure substation automation systems in the electrical power industry.

SCL is an XML-based format that describes which Intelligent Electronic Devices (IEDs) are present in a substation, how they are connected, and what data they exchange. SCL files (`.icd`, `.iid`, `.scd`, `.ssd`, `.sed`, `.cid`) are widely used among vendors and integrators. Since these files are frequently produced or edited by multiple, mutually untrusting parties before being imported into a tool such as CoMPAS OpenSCD, an SCL document itself represents a realistic attacker-controlled input.

CoMPAS OpenSCD is built with TypeScript and Lit web components and is deployed as a static single-page application served by NGINX. It communicates with the CoMPAS backend over REST and WebSocket interfaces. In the reference CoMPAS deployment, the microservices sit behind a single reverse proxy alongside Keycloak-issued session cookies. From the browser's perspective, all of these services are therefore reachable through the same origin.


## Attack Surface and Threat Scenarios

The threat model identified the following primary attack scenarios:

### 1. Malicious or Tampered SCL/SCD Files

An attacker who can author or modify an SCL/SCD file may cause the victim's authenticated browser session to perform unintended requests against the CoMPAS backend or other same-origin services accessible through the reverse proxy.

### 2. Manipulation of Client-Side Data or Plugins

An attacker who can influence data rendered or interpreted by the client, such as:

- Poisoned application settings
- A malicious or compromised plugin
- A Man-in-the-Middle (MitM) position

may be able to redirect application traffic, SCL document contents, or backend credentials to attacker-controlled infrastructure.

### 3. Software Supply Chain Compromise

An attacker who is able to:

- Submit a malicious pull request
- Compromise a CI/CD dependency
- Tamper with an unpinned build or release action

may introduce malicious code into the build pipeline or Docker image. Such code could then be distributed to all users of the published `lfenergy/compas-open-scd` container image.

## Countermeasures

The CoMPAS project complies with the OpenSSF best pratices guide in order stay secure:

- [CoMPAS OpenSSF best practices security measures](https://www.bestpractices.dev/en/projects/5925/silver)
