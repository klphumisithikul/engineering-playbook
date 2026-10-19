<!-- Optional Recommendation for large/multi-team repos and for onboarding new members and ensuring standards scaling over time. This file reduces the need for recurring training and documentation by providing a central reference for contribution standards. It can be customized to fit the specific needs of your project/team.
-->
# Contributing Guidelines: Code Review Standards & GitHub Expectations
Thank you for considering contributing to this repository! This document provides detailed instructions for contributing to ensure quality, consistency, and maintainable workflows across the development team.

---

## Goals
- **Streamline Contributions**: Provide clear coding expectations and workflows to ensure effective collaboration.  
- **Preserve Quality**: Maintain high standards for code readability, tests, and documentation.  
- **Standardize Processes**: Enforce consistent development strategies, branching workflows, and standardized Pull Request templates.

---

## Who Should Read This Document?  
This guide is intended for:  
1. **Developers and Contributors**: To understand and follow repository guidelines, including branching strategies, testing workflows, and code review processes.  
2. **Team Members Reviewing PRs**: To evaluate pull requests against coding and process expectations.  
3. **New Team Members**: To quickly onboard with the project’s development standards.  

---

## Project Resources  

The repository includes the following key resources to guide contributors:  

- **[README.md](../README.md)**: Provides a high-level overview of the project, including goals, setup instructions, and links to contributor resources.  
- **[CONTRIBUTING.md](./CONTRIBUTING.md)**: Supplies detailed contributions workflows, branching strategies, and testing instructions (this document).  
- **[pull_request_template](./pull_request_template.md)**: A standardized template to streamline and ensure consistent Pull Request submissions.  
- **[ISSUE_TEMPLATE/](./ISSUE_TEMPLATE)**: Structured bug report and feature request forms for new issues.
- **[CODEOWNERS](./CODEOWNERS)**: Automatically requests reviews from the right people/teams based on which files a PR touches.
- **[dependabot.yml](./dependabot.yml)** and **[workflows/](./workflows)**: Automated dependency updates and starter CI/security-scanning pipelines.
- **[SECURITY.md](../SECURITY.md)**: Private vulnerability-reporting process — do **not** file a public issue for security bugs.
- **Branch Protections**: Enforces rules and best practices to maintain code quality, prevent unauthorized changes, and ensure consistent development workflows. It helps safeguard important branches, such as the `main` or `release` branches, from accidental deletion or direct, unreviewed commits.
  - To enable branch protections visit GitHub's official documentation on [Configuring branch protection rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule).

---

## Quick Start  
Follow these steps to set up this repository locally on your machine:  

### **1. Prerequisites**  
Ensure the following tools are installed:
- Git
- Whatever runtime/toolchain this project uses (Node, Python, Go, etc.) — see the project README for stack-specific setup.

### **2. Clone the Repository**  
Run the following commands to download the repository to your local machine and navigate to the project directory:  
```bash
git clone <your-repo-url>
cd <your-repo-directory>
```

#### Install dependencies:  
Install whatever dependencies your project's stack requires, e.g.:
```bash  
pip install -r requirements.txt   # Python
npm ci                            # Node
```

---

## Branching Strategy

To maintain consistency and quality throughout the development process, follow the branching strategy outlined below. This is a simplified variant of git-flow — see [standards/branching-strategy.md](../standards/branching-strategy.md) for the full attribution to Vincent Driessen's [*A successful Git branching model*](https://nvie.com/posts/a-successful-git-branching-model/) and the optional release-branch pattern from that original model.

- **Base Branch (`develop`)**:

    - The `develop` branch serves as the default branch for active development.
    - All feature, experimental, and bugfix branches are created from the `develop` branch.

- **Feature Branches**:

    - Use `feature/<name>` to add new features or enhancements to the project.
    - Examples:  
        - `feature/add-logging`  
        - `feature/api-integration`

        **Workflow for Feature Branches:**
        1. **Create a Feature Branch** from `develop` branch:  
            ```bash
            git checkout develop
            git pull origin develop
            git checkout -b feature/add-logging
            ```
        2. Apply changes to add new feature/enhancement.
        3. **Push Changes**:  
            ```bash
            git add .
            git commit -m "feat(api): implement new API integration"
            git push origin feature/api-integration
            ``` 
        4. **Submit a Pull Request** for merging back into `develop`.

- **Experimental Branches**:
    - Use `experiment/<name>` for exploratory or temporary work that may not immediately integrate into active development.
    - Examples:
        - `experiment/improve-performance`
        - `experiment/additional-eda`

    - **Workflow for Experimental Branches**:
        1. An experimental branch can transition to a `feature/<name>` branch upon validation by the contributor or team. **Create an Experimental Branch** from `develop` branch:  
            ```bash
            git checkout develop
            git pull origin develop
            git checkout -b experiment/improve-performance
            ```
        2. Apply changes necessary for the experiment.
        3. **Push Changes**:  
            ```bash
            git add .
            git commit -m "experiment: enhance performance with new algorithm"
            git push origin feature/improve-performance
            ```  
        4. **Submit a Pull Request**:  
            - If the experiment is validated:
Open a Pull Request to merge directly into the `develop` branch for immediate deployment.
            - If the experiment is not validated:
The branch can be discarded without submitting a Pull Request or merging.

- **Bugfix Branches**:
    - Use `bugfix/<name>` to fix small, non-urgent coding issues.
    - Examples:
        - `bugfix/fix-regression-error`
        - `bugfix/fix-off-by-one`

    - **Workflow for Bugfix Branches**:
        1. **Create a Bugfix Branch** from `develop`:
            ```bash
            git checkout develop
            git pull origin develop
            git checkout -b bugfix/fix-regression-error
            ```
        2. Apply changes to fix the bug.
        3. **Push Changes**:  
            ```bash
            git add .
            git commit -m "fix(regression): resolve regression error in data fetch"
            git push origin bugfix/fix-regression-error
            ```
        4. **Submit a Pull Request** for merging back into `develop`.

- **Hotfix Branches**:
    - Use `hotfix/<name>` for urgent issues in production and require immediate application to the `main` branch.  
    - Examples:
        - `hotfix/fix-crash-bug`
        - `hotfix/db-connection-fail`
    - **Workflow for Bugfix Branches**:
        1. **Create a Hotfix Branch** from `main`:  
            ```bash
            git checkout main
            git pull origin main
            git checkout -b hotfix/db-connection-fail
            ```
        2. Apply changes to fix the issue.  
        3. **Push Changes**:  
            ```bash
            git add .
            git commit -m "fix(db): resolve connection pool timeout"
            git push origin hotfix/db-connection-fail
            ```  
        4.  **Submit a Pull Request** for merging back into both:
            - `main` for immediate production patching.
            - `develop` for syncing the fix with the current development branch.

<!-- TODO - Review with team -->
- **Merging**: 
    -  Always submit branches via Pull Requests (PRs):
        - `feature/<name>` and `bugfix/<name>` branches merge into the `develop` branch.
        - `hotfix/<name>` branches merge into both branches, `main` (for production) and `develop`.
    -  **Squash-and-Merge**: Use squash-and-merge when merging PRs to maintain a clean and readable commit history.  Squash-and-merge combines all commits from a branch into a single commit, making debugging and reviewing commit histories easier.

---

## Pull Request Workflow

To ensure a smooth development process, follow these guidelines before submitting a Pull Request (PR).

### Pre-Submission Checklist

Before opening a PR, verify that the following steps are complete:

1. **Code Quality**:
    -  Run linting tools (`black`, `flake8`) and fix any errors or warnings:
        ```bash
        black .
        flake8 .
        ```
    - Refactor code if necessary for readability, maintainability, or scalability.

2. **Testing**:
    - Run tests locally and ensure all tests pass functionality:
         ```bash
          pytest
        ```
   - Add relevant **unit, integration, and regression tests** for new features or bug fixes.  
   - Validate edge cases and unexpected input scenarios.  
   - Ensure all automated CI pipelines pass successfully after pushing the code.

3. **Commit Messages**:
    - Squash commits into **small, meaningful commits** before merging.
    - Use clear, descriptive commit messages such as:
         - `feat(auth): add login endpoint`
         - `fix(database): resolve null pointer exception`

4. **Documentation Updates**:
    - Add or update relevant documentation (e.g., README, notebooks, docstrings, templates).
    - Highlight any changes that reviewers need to know.

### Submission Guidelines

When opening a Pull Request, follow these steps:

1. **Use the Pull Request Template**  
    - All PRs must use the standardized template provided in `.github/pull_request_template.md` that is automatically applied by GitHub. 
   - Fill out all sections of the template (e.g., Description, Related Issues, Test Instructions).  
   - **Delete the "Usage Instructions" section** of the PR template before submitting.  

2. **Assign Reviewers**  
    - Assign at least **2 reviewers** for all pull requests.
    - Optional: Add stakeholders as reviewers for cross-functional changes affecting other teams.
    - Ensure assigned reviewers have sufficient context about the branch being worked on.

3. **Determine PR Scope**  
    - Limit PRs as small and focused when possible (ideally **less than 500 lines of changes**).
     - **For larger changes**: Provide a clear explanation in the “Key Changes” section of the PR template.

4. **Link Issues/Tickets**  
     - Reference any related GitHub issues, Jira tickets, etc. in the PR description to maintain a clear traceable history.
        ```plaintext
        Closes #123  
        Related to [PROJ-456](https://jira.example.com/browse/PROJ-456) 
        ```

<!-- TODO - Review with team -->
5. **Monitor Continuous Integration (CI) Pipelines**  
    - Ensure that all CI/CD checks pass (e.g., unit tests, style checks, and coverage reports).
    - Address any failures before requesting a review.

### Tips for Effective Pull Requests
- **Write Clear Descriptions**:
    - Provide a plain-language summary of what the PR does and why it’s necessary.
    - Example:
        - "*This PR adds an endpoint for churn predictions using a pretrained ML model.*"
    - Address one task at a time. 
    - Aim for small, focused PRs.
    - Be reviewed, tested, and deployed incrementally.

- **Provide Context for Reviewers**:
  - Highlight any areas of concern or important changes (e.g., edge cases or tricky logic) in  the "Additional Notes" section.
  - Example:
    ``` bash
    # New dependencies have been added. 
    # Run 
    pip install -r requirements.txt 
    #to test locally
    ```

- **Be Collaborative**:
  - Engage with reviewers by responding to comments and questions promptly.
  - Be open to feedback and willing to make necessary changes.

### Final Checks Before Merge
Before merging the PR, confirm:

- [ ] All tests pass successfully, both locally and in CI pipelines.
- [ ] Required reviewers have approved the PR.
- [ ] Commits are squashed into a **single meaningful commit** or logical groups.
- [ ] Documentation is updated to reflect the latest changes.
- [ ] The branch has no unresolved merge conflicts.

When merging, use **Squash-and-Merge** to maintain a clean commit history.

---

<!-- TODO to review with team and determine if examples would be helpful -->

## Documentation Standards
- Ensure that:
  - Code includes meaningful inline comments.
  - Major features are documented in the [README.md](../README.md).

### Code, Git, and Testing Standards
#### Code Standards:
- Use `black` for formatting and `flake8` for linting in Python.
- Write concise, descriptive commit messages:
  - Format: `type(scope): message`.
  - Example: `feat(model): add churn prediction pipeline`.
  - Follow PEP-8 guidelines for Python code: https://www.python.org/dev/peps/pep-0008/

#### Git Standards:
- Write concise conventional commit messages in the format:
  ```plaintext
  type(scope): description
  Example: feat(api): add endpoint for model training 
  ```

#### Testing Standards:
- Add tests for any significant changes.
- Validate your contributions by running all tests locally before pushing using `pytest`.
- Validate key scenarios, including edge cases.
- Aim for high test coverage:
  - Target at least 80% code coverage.

#### Templates
GitHub supports two kinds of PR template, and this repo uses both: a single **default template** (`pull_request_template.md`) that auto-fills every new PR with no extra steps, and a `PULL_REQUEST_TEMPLATE/` **folder** of named templates that contributors pick from GitHub's "Preview" dropdown (or a `?template=<name>.md` URL param) when opening a PR. The default covers generic PRs; the folder holds branch-type-specific ones below.

- [Pull Request Template](./pull_request_template.md)
- [Feature Branch Template](./PULL_REQUEST_TEMPLATE/feature_template.md)
- [Experimental Branch Template](./PULL_REQUEST_TEMPLATE/experiment_template.md)
- [Bugfix Branch Template](./PULL_REQUEST_TEMPLATE/bugfix_template.md)
- [Hotfix Branch Template](./PULL_REQUEST_TEMPLATE/hotfix_template.md)

---

## Need Help?
Contributing to a project can sometimes be challenging—but don't worry, we're here to help! Below is a list of resources and guidelines to assist you throughout the process.

### **1. Contribution Guidelines**
Start with this document's instructions for branching workflows, pull requests, testing, and maintaining documentation. If you're unsure of any process while contributing, refer to these sections:
- **[Branching Strategy](#branching-strategy)**: Learn how to create feature, bugfix, experimental, and hotfix branches.  
- **[Pull Request Workflow](#pull-request-workflow)**: Follow step-by-step guidelines for submitting a pull request, including pre-submission checklists.  
- **[Documentation Standards](#documentation-standards)**: Ensure your code includes inline comments and updates relevant documentation like [README.md](../README.md).

Still confused? Check the rest of this file for more detailed examples.

### **2. Use Our [Templates](#templates)**

We’ve created standardized templates to make contributing efficient and consistent. Use these templates for Pull Requests and specific branch types:  
- [Pull Request Template](./pull_request_template.md): Guide your PR submission with a structured format.  
- [Feature Branch Template](./PULL_REQUEST_TEMPLATE/feature_template.md): Format for creating new features.  
- [Experimental Branch Template](./PULL_REQUEST_TEMPLATE/experiment_template.md): Use for exploratory work.
- [Bugfix Branch Template](./PULL_REQUEST_TEMPLATE/bugfix_template.md): Format for fixing non-urgent issues.  
- [Hotfix Branch Template](./PULL_REQUEST_TEMPLATE/hotfix_template.md): Use for production-related urgent fixes.  

> **Tip**: Templates are automatically applied in GitHub when you create a PR or branch. Delete instructional sections (like "Usage Instructions") before submission as specified in the template.

### **3. Where Else to Look**  

If you're stuck, the following points will guide you further:
- **GitHub Documentation**: Learn about features like [Branch Protection Rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule) to safeguard critical branches.
- **Confluence Resources**: If your organization uses Confluence, check the linked documentation summary for non-technical explanations of branch management or workflows.

### **4. Contact a Maintainer/Contributor**
Sometimes you’re blocked and need to escalate the issue. If that happens, reach out to one of the [Maintainers and Contributors](#maintainers-and-contributors)

> **Important**: Before contacting a maintainer, ensure that you’ve reviewed this [CONTRIBUTING.md](./CONTRIBUTING.md) file and checked key resources like templates or linked documentation.

### **5. File an Issue or Bug Report**  

If your contribution is blocked due to a bug or unclear process documented here, you can:  
1. Open a GitHub issue using the [bug report](./ISSUE_TEMPLATE/bug_report.md) or [feature request](./ISSUE_TEMPLATE/feature_request.md) template.
   - **Security vulnerability?** Do not open a public issue — follow [SECURITY.md](../SECURITY.md) instead.
2. Tag the relevant maintainer/author for clarification:
   - Use `@Name 1` for backend issues.
   - Use `@Name 2` for build/CI-related problems.
   - Use `@Name 3` for anything UI/UX-focused.  

### **6. Slack Channels** _(Optional Depending on Your Team)_  

If your team uses Slack for collaboration:  
- Use the **#dev-support** channel for technical questions.  
- Use the **#ci-cd-help** channel for pipeline or branch-related issues.  
- Announce significant changes in the **#general** or project-specific channels for visibility.

### In Summary  
If you encounter any difficulties:  
1. Refer to this [CONTRIBUTING.md](./CONTRIBUTING.md)  file and templates.  
2. Use GitHub documentation or Confluence for additional guidance.  
3. Escalate to a maintainer if the issue persists.  
4. Contribute constructively by filing issues or making clear bug reports when necessary.

---

## Maintainers and Contributors
Thank you for contributing to this repository! Below are the maintainers responsible for overseeing this project and ensuring smooth collaboration.  

---

### **Maintainers**  

The following team members are responsible for the maintenance of this repository, including reviewing pull requests, resolving technical issues, and ensuring the repository’s overall health:  

| **Name**           | **Role**                      | **Contact Information**        |
|---------------------|-------------------------------|---------------------------------|
| **[Name 1]**        | Backend Specialist            | backend-team@example.com       |
| **[Name 2]**        | DevOps Engineer/Team Lead     | devops-team@example.com        |
| **[Name 3]**        | Frontend Specialist           | frontend-team@example.com      |

#### **Responsibilities of Maintainers**:
1. **Review Pull Requests (PRs)** for code quality, contributions to workflows, and adherence to repository guidelines.  
2. Respond to issues filed in GitHub, including bug reports or feature requests.  
3. Assist contributors by clarifying workflows or resolving technical roadblocks.  
4. Keep documentation up to date, especially [CONTRIBUTING.md](./CONTRIBUTING.md) and high-level workflows in [README.md](../README.md).

If you're blocked on contributing, please don’t hesitate to reach out to one of the maintainers listed above.

### **Contributors**  

We are grateful to all the contributors who help maintain and improve this project!  

- **Contributor List**:  
  You can view the full list of contributors [here](https://github.com/your-org/your-repo/graphs/contributors).  

#### **How to Become a Contributor**:
1. Submit a meaningful Pull Request (PR) adhering to project guidelines.  
2. Participate in code reviews, bug reports, or feature discussions.  
3. Collaborate with maintainers to improve project quality and coverage.  

### **Special Thanks**  

A special thank you to contributors for their continued efforts and to our maintainers for ensuring this project stays organized, scalable, and impactful!  

---

## Maintaining Documentation  

Keeping documentation up-to-date is critical to ensure a smooth and collaborative development process. This section outlines the steps to maintain and synchronize key project resources like **[CONTRIBUTING.md](./CONTRIBUTING.md)**, **[README.md](../README.md)**, and **Confluence pages**. All contributors share responsibility for maintaining documentation as part of the contribution process.

### **1. Centralizing Updates in [CONTRIBUTING.md](./CONTRIBUTING.md)**  

The **[CONTRIBUTING.md](./CONTRIBUTING.md)** file is the **source of truth** for all contributor-facing workflows, processes, and coding standards. When introducing new workflows, guidelines, or process changes:  

1. **Make Updates in [CONTRIBUTING.md](./CONTRIBUTING.md) First**:  
   - Locate relevant sections of the [CONTRIBUTING.md](./CONTRIBUTING.md)
 file that need updating (e.g., branching strategy, pull request guidelines, or testing standards).  
   - Add detailed instructions with examples to ensure clarity for contributors.  

    - **Examples of Changes**:  
      - Updating a branching strategy:
        ```markdown
        ### Updated Branching Strategy (2023):
        Bugfix branches should now branch off the `develop` branch instead of `main`.  
        ```
      - Adding new pre-submission requirements for a Pull Request:
        ```markdown
        Ensure all strings externalized for localization pass validation using `localization-validator`.
        ```

2. **Submit a Pull Request for Review**:  
   - After making updates, open a **Pull Request** to modify [CONTRIBUTING.md](./CONTRIBUTING.md).  
   - Assign team reviewers and ensure consensus on the changes to ensure accuracy and alignment.  

### **2. Summarizing Key Updates in [README.md](../README.md)**  

Once updates to [CONTRIBUTING.md](./CONTRIBUTING.md) are merged, **summarize key process changes in [README.md](../README.md)** for high-level visibility to all users (including non-developers).  

1. **Simplify the Content**:
   - Extract key points from [CONTRIBUTING.md](./CONTRIBUTING.md) and update applicable sections of the   [README.md](../README.md).  
   - Only include summaries or high-level overviews, with links back to [CONTRIBUTING.md](./CONTRIBUTING.md)  for deeper detail.

    - **Examples**:  
      - Updating a workflow summary in   [README.md](../README.md):
        ```markdown
        ## Branching Strategy  

        - **Bugfix Branches**: Used for fixing small, non-urgent coding issues. Branch off from `develop`.  
          Detailed workflow: See [CONTRIBUTING.md](./CONTRIBUTING.md).  
        ```

2. **Open a Pull Request for Review**:  
   - Submit a Pull Request (PR) for updating the   [README.md](../README.md). Ensure the PR description highlights high-level changes so that reviewers understand what has been simplified or summarized.

### **3. Updating Confluence Documentation**  

Confluence pages serve as a centralized resource for **non-technical users, managers, and cross-functional teams**. After updating [CONTRIBUTING.md](./CONTRIBUTING.md)
 and   [README.md](../README.md), synchronize those updates in Confluence.  

1. **Identify Relevant Changes**:  
   - Review recent updates in GitHub [CONTRIBUTING.md](./CONTRIBUTING.md) or [README.md](../README.md).
   - Determine which updates are relevant for the Confluence audience (e.g., high-level summaries, workflow overviews, or key decisions).  

2. **Maintain Alignment with GitHub**:  
   - Summarize the updated processes in Confluence **using plain language** for non-technical audiences.  
   - Provide links back to the authoritative GitHub resources for detailed explanations:
     ```plaintext
     For technical details on branching workflows, see the [CONTRIBUTING.md](./CONTRIBUTING.md).
     ```

3. **Maintain Version Control**:  
   - Update the "Last Updated" timestamp in Confluence to reflect the latest changes.  
   - Example:
     ```plaintext
     **Last Updated**: October 2023  
     Recent changes:
     - Updated branching workflows for bugfix and hotfix branches.
     - Added PR checklist requirements for localization validation.
     ```

4. **Notify the Team**:  
   - Post an announcement in Slack, Teams, or email to inform stakeholders of the changes. Highlight what is new and where to find the updated documentation.

### **4. Workflow for Harmonizing Updates**  

Use this workflow to keep documentation synchronized across all resources:  

```plaintext
1. Update -> [CONTRIBUTING.md](./CONTRIBUTING.md)
 (source of truth for workflows, coding standards, and contributor information)
       |
       V
2. Summarize ->  [README.md](../README.md) (extract simplified, high-level summaries for general visibility)
       |
       V
3. Communicate -> Confluence (non-technical summaries for project managers, stakeholders, or team members outside GitHub)
```

### 5. **Best Practices for Document Updates**
To ensure documentation remains consistent and accurate:

- **Make Documentation Part of Every Contribution**:
  - Every Pull Request (PR) introducing new features, workflows, or fixes must include relevant documentation updates in either the [CONTRIBUTING.md](./CONTRIBUTING.md)
,  [README.md](../README.md), or both.

- **Test Updates for Clarity**:
  - When updating [CONTRIBUTING.md](./CONTRIBUTING.md)
, include examples, commands, or workflows to make the steps actionable and easy to follow.
  - Use concise and precise language in  [README.md](../README.md) for broader audiences.

- **Review Documentation as Part of Code Reviews**:
  - PR reviewers should validate that documentation is updated wherever changes impact contributors or workflows.

- **Coordinate with Maintainers**:
  - Notify maintainers or documentation owners when significant changes impact the repository's documentation ecosystem (e.g., large workflow updates or new tool integrations).

- **Update Workflow Example**
  - Scenario: Updating Branching Workflow
    1. Update in [CONTRIBUTING.md](./CONTRIBUTING.md)
 (Source of Truth):
        ```markdown
        ### Bugfix Branch Workflow (2023 Update):
        - Bugfix branches now branch off `develop` instead of `main`.  
        - Updated Workflow:
          ```bash
          git checkout develop
          git pull origin develop
          git checkout -b bugfix/fix-connection-issue
          ```
    2. Summarize in  [README.md](../README.md):
        ```markdown
        ## Branching Strategy  
        - **Bugfix Branches**: Use `bugfix/<name>` for correcting non-urgent issues.  
        - Branch off from `develop` branch.  
        - For detailed workflow, see [CONTRIBUTING.md](./CONTRIBUTING.md).  
        ```
    3. Confluence Update:
        ```plaintext
        ### Updated Bugfix Branch Workflow (October 2023)
        - Bugfix branches should now branch off `develop` instead of `main`.  
        - For detailed Git commands and examples, refer to [CONTRIBUTING.md](./CONTRIBUTING.md).
        ```
    4. Communicate via Slack:
        - Post in the team's Slack channel:
          ```plaintext
          🚨 Branch Workflow Update 🚨  
          Team, we've updated the branching strategy for bugfix branches.  
          - Bugfix branches must now originate from `develop`.  
          - See the full workflow update here: [GitHub CONTRIBUTING.md](https://github.com/your-org/your-repo/blob/main/CONTRIBUTING.md).   
          ```

### 6. Syncing Documentation
Make it a habit to follow this update protocol:

- All workflow/auth guideline changes start in [CONTRIBUTING.md](./CONTRIBUTING.md).
- Simplify and summarize into  [README.md](../README.md) for a general audience.
- Share further summaries tailored for stakeholders in Confluence via non-technical language and direct GitHub links when needed.

By following these steps, we ensure tightly synchronized, consistent, and accessible documentation across platforms.

---

## Final Notes
Maintaining up-to-date documentation is a shared responsibility among contributors, maintainers, and reviewers. It ensures efficient collaboration, minimizes confusion, and keeps the project organized as it evolves. Let's work together to maintain accurate and reliable documentation!

Thank you for contributing to this project! Your expertise and feedback are critical to our success.  Please reach out to the team leads if you have any questions regarding the contribution process or workflows.
