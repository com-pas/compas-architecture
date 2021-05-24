<!--
SPDX-FileCopyrightText: 2021 Alliander N.V.

SPDX-License-Identifier: CC-BY-4.0
-->

## Github Actions
Every repository within the CoMPAS Github organization need a default set of Github Actions.
[Github Actions](https://github.com/features/actions) are CI/CD steps within a Github Repository that you can configure. This way, you can ensure that certain steps (like building) are always triggered on for example a commit push.

Within CoMPAS, we define the following 'must have' Github Actions:
  - [Building](#building)
  - [REUSE check](#reuse-check)
  - [SonarCloud](#sonarcloud)

More to follow.

Github Actions are configured using YAML files. These files are stored in the `.github/workflows` directory of a specific repository.

### Building
All source code repositories need some kind of building step.
By default, all source code repositories use Gradle as the build tool.

This building step is pretty easy to configure. Just create a `gradle_build.yml` file in the `.github/workflows` directory containing the following source code:

```yaml
name: Gradle Build

on: push #(1)

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up JDK 1.11
      uses: actions/setup-java@v1
      with:
        java-version: 1.11
    - name: Grant execute permission for gradlew
      run: chmod +x gradlew
    - name: Build with Gradle
      run: ./gradlew clean build #(2)
      env: #(3)
        GITHUB_USERNAME: "OWNER"
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

A few points to remember:
- (1): By default, all actions are triggered on a push action.
- (2): This is a default for building a Gradle project. It may differ in some cases, please feel free to adjust it.
- (3): If the Gradle project is depending on a CoMPAS specific[Github Package](https://github.com/orgs/com-pas/packages), you have to add some environment variables. For more information, check the [Github Packages]() page (this is still a [TODO](https://github.com/com-pas/compas-architecture/issues/98)).

### REUSE check
For keeping our copyright and licensing information up to date and correct, we use [REUSE](https://reuse.software/) to check this. This is also configured for every separate repository in an easy manner: just create a `reuse.yml` file in the `.github/workflows` directory containing the following source code:

```yaml
name: REUSE Compliance Check

on: push

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: REUSE Compliance Check
      uses: fsfe/reuse-action@v1
```

This is the only thing that has to be done. After this, it will be checked on every push.

#### REUSE badge
For transparancy, CoMPAS repositories also include a REUSE badge in their README for fast checking the REUSE compliance.

Two steps are needed to get a REUSE badge to work:

1. Register the Repository at the [REUSE website](https://api.reuse.software/register). For name and email, check the [Slack channel](https://app.slack.com/client/TLU68MTML/C01926K9D39).
2. Add the following code to the README:
   
```md
[![REUSE status](https://api.reuse.software/badge/github.com/com-pas/repoName)](https://api.reuse.software/info/github.com/com-pas/repoName)
```

There is one steps left: Replace `repoName` with the name of the specific repository (as stated in the URL).

After doing all these steps, everything is set up for the REUSE check.

### SonarCloud