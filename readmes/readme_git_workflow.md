# Git Workflow
This README defines the current Git workflow to follow for this repository.

All issues/tickets should be associated with the StudyClicker project to be placed on the board, containing four main phases of development: To do, In progress, In review, and Done.

## To do
To start with an issue in the "To do" column, create a new issue in the StudyClicker project.

### Creating an issue
When creating a new issue, **link the Project to StudyClicker**. This will allow the issue to appear in the project's board as a card under the "To do" column. Assign someone appropriate to work on the issue (this can be yourself).

## In progress
When you decide to pick up an issue to actively work on, **move the issue card from the "To do" column to the "In progress" column** within the StudyClicker project board. This indicates to the team that the issue is being actively worked on.

### Creating a branch
To keep branch names relatively consistent, **follow the formats below**:

* For a feature with issue number #xxx, create a branch named

`feature/#xxx/description-of-issue`

* For a bug with issue number #xxx, create a branch named

`bug/#xxx/description-of-issue`

* For an integration branch meant to capture multiple related issues/PRs (e.g. an epic) with issue number #xxx, create a branch named

`integration/#xxx/description-of-issue`

## In review
When you have completed the issue, create a PR for the issue and **move the issue card from the "In progress" column to the "In review" column** within the StudyClicker project board. This indicates to the team that a PR is up for the issue and that it is ready for review by another member.

### Creating a Pull Request (PR)
When creating a pull request, **make sure the description (_not_ the title) contains the following phrase on the first line**:

`close #xxx`

This ensures that the newly opened pull request will link with the issue you have been working on, and will close said issue upon merging and closing the pull request.

All regular pull requests should use the `develop` branch as the base, where the `master` branch will only be merged from `develop` when a stable release is made.

Request a review from someone on the team. Each pull request requires at least one additional member to approve it.
