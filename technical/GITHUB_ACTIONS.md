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
      env: 
        GITHUB_USERNAME: "OWNER" #(3)
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} #(4)
```

A few points to remember:
- (1): By default, all actions are triggered on a push action.
- (2): This is a default for building a Gradle project. It may differ in some cases, please feel free to adjust it.
- (3): Only applicable if your repository is depending on our [Github Package](https://github.com/orgs/com-pas/packages). The GITHUB_TOKEN needs to be set with something (value doesn't matter) to give your access to the Github Packages during build.
- (4): Again, only applicable if your repository is depending on our Github Packages. The GITHUB_TOKEN gives you access to the Github Packages during build.

### REUSE check
For keeping our copyright and licensing information up to date and correct, we use [REUSE](https://reuse.software/) to check this. This is also configured for every separate repository in an easy manner: just create a `reuse.yml` file in the `.github/workflows` directory containing the following source code:

```yaml
name: REUSE Compliance Check

on: push #(1)

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: REUSE Compliance Check
      uses: fsfe/reuse-action@v1
```

A few points to remember:
- (1): By default, all actions are triggered on a push action.

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
For static code analysis, CoMPAS is using [SonarCloud](https://sonarcloud.io/). To configure this, there are several steps that needs to be done.

1. Go to the [CoMPAS Github organization settings](https://github.com/organizations/com-pas/settings/profile), and click on "Installed Github Apps". SonarCloud is listed here already (because we are already using it). Click on the 'configure' button next to it.
2. In the "Repository access" section, select the repository you want to add. By default, not every repository is added as an extra check.
3. Create a new project in [SonarCloud](https://sonarcloud.io/projects/create).
4. Select the repository to be analyzed, click Set Up.
5. Choose the Analysis Method "With Github Actions".
6. It first tells you to create a SONAR_TOKEN secret in your repo. Go to your repository -> Settings - Secrets -> New repository secret -> Name: SONAR_TOKEN. Value: Copy the value from the SonarCloud website into here. Then save the secret
7. Select Gradle as the option that best describes our build and **remember the projectKey**. and create a `sonarcloud_analysis.yml` file in the `.github/workflows` directory containing the following source code running.

```yaml
name: SonarCloud Analysis

on: push #(1)

jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Set up JDK 11
        uses: actions/setup-java@v1
        with:
          java-version: 1.11
      - name: Cache SonarCloud packages
        uses: actions/cache@v1
        with:
          path: ~/.sonar/cache
          key: ${{ runner.os }}-sonar
          restore-keys: ${{ runner.os }}-sonar
      - name: Cache Gradle packages
        uses: actions/cache@v1
        with:
          path: ~/.gradle/caches
          key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle') }}
          restore-keys: ${{ runner.os }}-gradle
      - name: Build and analyze
        env:
          GITHUB_USERNAME: "OWNER" #(2)
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} #(3)
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
        run: ./gradlew build jacocoTestReport sonarqube -Dsonar.projectKey=<insert project key> -Dsonar.organization=com-pas -Dsonar.host.url=https://sonarcloud.io --info #(4)
```

A few points to remember:
- (1): By default, all actions are triggered on a push action.
- (2): Only applicable if your repository is depending on our [Github Package](https://github.com/orgs/com-pas/packages). The GITHUB_TOKEN needs to be set with something (value doesn't matter) to give your access to the Github Packages during build.
- (3): Again, only applicable if your repository is depending on our Github Packages. The GITHUB_TOKEN gives you access to the Github Packages during build.
- (4): Replace the `<insert project key>` with the project key you copied.

Once this is set, it's all done!