<!--
SPDX-FileCopyrightText: 2021 Alliander N.V.

SPDX-License-Identifier: CC-BY-4.0
-->

## Issue Management
For issue management we are using the issue tracker in GitHub. Issues are created in the repository where there are related to.<br/>
Issues that concern the whole CoMPAS project are added as issue in the repository "compas-architecture". Later these maybe be move to the correct repository.  

To get an overview of all the issues we are using the project board in GitHub.
There are two overview board on organisation level to monitor all the issues and pull request in the different repositories.
One for the issues, CoMPAS Issues Overview Board and one for the pull requests, CoMPAS Pull Request Overview Board.
Every repository that can contain issues and pull request are linked to these two project boards.

To manage this ecosystem of issues in the different repositories some automation is added to make life better.

### Configure (new) repository
When a new repository is created (or existing needs to be configured) some settings need to be made for the automation to work.

Go to the new repository and select the tab "Settings". Under settings select the item "Options". 
Under features make sure that the option "Issues" and "Projects" are selected. 
There should now be two new tabs "Issues" and "Projects" available to the left of "Settings".

Next go to the tab "Projects" and create a new project board (right top button).
Give the project board a new name like "CoMPAS \<Project\> Board", give it a description if desired, use the template "Basic kanban".
Now create the project board. This project board will be used to have an overview on repository level with all issues and pull requests.<br/>
Next the project board is shown. Delete the notes that are automatically created.<br/> 
Now for each column select "Manage automation" under the "...". Change the automation according to the table below and update the settings.

| To Do                        | In Progress                                 | Done                                               |
| ---------------------------- |:-------------------------------------------:| --------------------------------------------------:|
| Issue: Newly added, Reopened |Issue: _None_                                | Issue: Closed                                      |
| Pull Request: Newly added    |Pull Request: Reopened, Approved by reviewer,| Pull Request: Merged, Closed with unmerged commits |
|                              | Pending approval by reviewer                |                                                    |

Next go the organisation overview of CoMPAS and go to the tab "Projects".<br/> 
Now we need to link the new repository to both Project Boards. Repeat the following part for both the project boards "CoMPAS Issues Overview Board" and "CoMPAS Pull Request Overview Board".<br/>
Don't open the board, but under "..." (end of row) select "Settings". Next go to "Linked repositories" and link the new repository using the button "Link a repository".
the repository is now shown in the list of linked repositories.Now it's possible to also added issues and pull request to the board.

### Add GitHub Action 
To automatically adding issues and pull request to a project board we add a GitHub action for that. 
In the repository create a file "automate_projects.yml" in the directory ".github/workflows" containing the following source code: 

```yaml
name: Add issues and pull request to project boards

on: [ issues, pull_request ]

jobs:
  github-actions-automate-projects:
    runs-on: ubuntu-latest
    steps:
      - name: add-new-issues-to-repository-based-project-column #(Step 1)
        uses: docker://takanabe/github-actions-automate-projects:v0.0.1
        if: github.event_name == 'issues' && github.event.action == 'opened'
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GITHUB_PROJECT_URL: https://github.com/com-pas/compas-architecture/projects/2 #(1)
          GITHUB_PROJECT_COLUMN_NAME: To do
      - name: add-new-pull-request-to-repository-based-project-column #(Step 2)
        uses: docker://takanabe/github-actions-automate-projects:v0.0.1
        if: github.event_name == 'pull_request' && github.event.action == 'opened'
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GITHUB_PROJECT_URL: https://github.com/com-pas/compas-architecture/projects/2 #(1)
          GITHUB_PROJECT_COLUMN_NAME: To do
      - name: add-new-issues-to-organization-based-project-column #(Step 3)
        uses: docker://takanabe/github-actions-automate-projects:v0.0.1
        if: github.event_name == 'issues' && github.event.action == 'opened'
        env:
          GITHUB_TOKEN: ${{ secrets.ORG_GITHUB_ACTION_SECRET }}
          GITHUB_PROJECT_URL: https://github.com/orgs/com-pas/projects/1 #(2)
          GITHUB_PROJECT_COLUMN_NAME: To do
      - name: add-new-pull-request-to-organization-based-project-column #(Step 4)
        uses: docker://takanabe/github-actions-automate-projects:v0.0.1
        if: github.event_name == 'pull_request' && github.event.action == 'opened'
        env:
          GITHUB_TOKEN: ${{ secrets.ORG_GITHUB_ACTION_SECRET }}
          GITHUB_PROJECT_URL: https://github.com/orgs/com-pas/projects/2 #(3)
          GITHUB_PROJECT_COLUMN_NAME: To do
```
The GitHub action exists of 4 steps. 
- (Step 1): Add new issues to the project board of the repository.
- (Step 2): Add new pull requests to the project board of the repository.
- (Step 3): Add new issues to the organisation project board "CoMPAS Issues Overview Board".
- (Step 4): Add new pull requests to the organisation project board "CoMPAS Pull Request Overview Board".

A few points:
- (1): The URL to the project board of the repository.
- (2): The URL to the organisation project board "CoMPAS Issues Overview Board".
- (3): The URL to the organisation project board "CoMPAS Pull Request Overview Board".

### Configuration Organisation Project Board
As mentioned already there are two project boards on organisation level, namely "CoMPAS Issues Overview Board" 
and "CoMPAS Pull Request Overview Board". To automate more we changed some settings on the two boards.<br/> 
Open the two boards and change the automation settings of the columns (On the column select "Manage automation" 
under the "...") according to the tables below.

Project board "CoMPAS Issues Overview Board":

| To Do                        | In Progress                                 | Done                                               |
| ---------------------------- |:-------------------------------------------:| --------------------------------------------------:|
| Issue: Newly added, Reopened |Issue: _None_                                | Issue: Closed                                      |
| Pull Request: _None_         |Pull Request: _None_                         | Pull Request: _None_                               |


Project board "CoMPAS Pull Request Overview Board":

| To Do                        | In Progress                                 | Done                                               |
| ---------------------------- |:-------------------------------------------:| --------------------------------------------------:|
| Issue: _None_                |Issue: _None_                                | Issue: _None_                                      |
| Pull Request: Newly added    |Pull Request: Reopened, Approved by reviewer,| Pull Request: Merged, Closed with unmerged commits |
|                              | Pending approval by reviewer                |                                                    |

### Adding Action Secret ORG_GITHUB_ACTION_SECRET
To access the project boards of the organization a secret ORG_GITHUB_ACTION_SECRET needs to be created.
- First create a new personal access token from https://github.com/settings/tokens. Tokens can only be created as personal tokens.
  The token also must have the right "admin:org". This will indirectly also set the right "write:org" and "read:org". 
- Next create a new organisation secret from https://github.com/organizations/com-pas/settings/secrets/actions with the value of 
  personal access token you created above. Name the secret ORG_GITHUB_ACTION_SECRET. Make it available for public repositories.

Now the action can use this secret to add the issues and pull request to the project boards of the organization.
