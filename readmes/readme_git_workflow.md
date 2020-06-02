# Git Workflow
This README defines the current Git workflow to follow for this repository.

All issues/tickets should be associated with the GodotPlatformer project to be placed on the board, containing four main phases of development: To Do, In Progress, In Review, and Done.

## To Do
To start with an issue in the "To Do" column, create a new issue in the GodotPlatformer project.

### Creating an issue
Issues can be created through one of two ways:
1. Through Projects:
   * Go to the Projects tab on GitHub.
   * Access the "GodotPlatformer" project.
   * Add a note in the "To Do" column with the issue title.
   * Press the ellipsis at the top-right of the new note and click "Convert to issue".
   * Add a description to the newly created issue.
   * Assign someone relevant to work on it.
2. Through Issues:
   * Go to the Issues tab on GitHub.
   * Create a "New Issue".
   * **link the Project to GodotPlatformer**.
   * Add a description to the newly created issue.
   * Assign someone relevant to work on it.

## In Progress
When you decide to pick up an issue to actively work on, **move the issue card from the "To Do" column to the "In Progress" column** within the GodotPlatformer project board. This indicates to the team that the issue is being actively worked on.

### Creating a branch
To keep branch names relatively consistent, **follow the formats below**:

* For a feature with issue number #xxx, create a branch named
  * `feature/#xxx-description-of-issue`

* For a bug with issue number #xxx, create a branch named
  * `bug/#xxx-description-of-issue`

* For an integration branch meant to capture multiple related issues/PRs (e.g. an epic) with issue number #xxx, create a branch named
  * `integration/#xxx-description-of-issue`

## In Review
When you have completed the issue, create a PR for the issue and **move the issue card from the "In Progress" column to the "In Review" column** within the GodotPlatformer project board. This indicates to the team that a PR is up for the issue and that it is ready for review by another member.

### Creating a Pull Request (PR)
When creating a pull request, **make sure the description (_not_ the title) contains the following phrase on the first line**:

`close #xxx`

This ensures that the newly opened pull request will link with the issue you have been working on, and will close said issue upon merging and closing the pull request.

All regular pull requests should use the `develop` branch as the base, where the `master` branch will only be merged from `develop` when a stable release is made.

Request a review from someone on the team. Each pull request requires at least one additional member to approve it.

