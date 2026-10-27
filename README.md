# Software Dev Playbook

A cross-platform, technology-agnostic engineering playbook and reusable project template. Includes governance standards, naming conventions, PR templates, GitHub workflows, and starter config for bootstrapping future software engineering projects.

This repository is both:
1. **A playbook** — this README codifies modern engineering standards (performance, security, accessibility, maintainability, CI/CD) and tool-specific best practices for GitHub, GitLab CI/CD, Argo CD (GitOps), and Docker.
2. **A reusable template** — click **"Use this template"** on GitHub (or `git clone` it) to bootstrap a new project with real scaffolding already in place: `.github/` issue/PR templates and workflows, `CODEOWNERS`, `LICENSE`/`LICENSE-DOCS`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `.gitignore`, `.editorconfig`, `CHANGELOG.md`, and starter `.gitlab-ci.yml` / GitHub Actions pipelines.

The engineering standards below are intentionally stack-agnostic — adapt the stack-specific examples (Node, Python, Docker, etc.) to whatever your new project actually uses, then delete the examples you didn't need.

---

## Table of Contents
- [Goals](#goals)
- [Who Should Read This Document?](#who-should-read-this-document)
- [Project Resources](#project-resources)
  - [Repository Structure](#repository-structure)
- [Quick Start](#quick-start)
  - [Suggested Reading Order](#suggested-reading-order)
- [Branching Strategy](#branching-strategy)
- [Pull Request Workflow](#pull-request-workflow)
- [Engineering Standards](#engineering-standards)
  - [Performance](#performance)
  - [Security](#security)
  - [Accessibility](#accessibility)
  - [Maintainability](#maintainability)
  - [CI/CD & Observability](#cicd--observability)
- [GitHub Standards](#github-standards)
- [GitLab CI/CD Standards](#gitlab-cicd-standards)
- [Argo CD (GitOps) Standards](#argo-cd-gitops-standards)
- [Docker Standards](#docker-standards)
- [Documentation Standards](#documentation-standards)
- [Licensing](#licensing)
- [Curated Resources](#curated-resources)
- [Final Notes](#final-notes)

---

## Goals
- **Streamline Contributions**: Provide clear coding expectations and workflows to ensure effective collaboration.
- **Preserve Quality**: Maintain high standards for code readability, tests, documentation, and secure supply chains.
- **Standardize Processes**: Enforce consistent development strategies, branching workflows, CI/CD, GitOps, and container practices across teams.

> Industry context: modern web applications emphasize Core Web Vitals performance, OWASP Top 10 security, WCAG accessibility, TypeScript-driven maintainability, and elite DORA metrics for CI/CD.

---

## Who Should Read This Document?
This guide is intended for:
1. **Developers and Contributors**: To understand and follow repository guidelines, including branching strategies, testing workflows, and code review processes.
2. **Team Members Reviewing PRs**: To evaluate pull requests against coding and process expectations.
3. **New Team Members**: To quickly onboard with the project's development standards.

---

## Project Resources

The repository includes the following key resources to guide contributors:
- **[README.md](./README.md)**: Provides a high-level overview of the project, including goals, setup instructions, engineering standards, and links to contributor resources.
- **[CONTRIBUTING.md](./.github/CONTRIBUTING.md)**: Supplies detailed contribution workflows, branching strategies, and testing instructions.
- **[pull_request_template.md](./.github/pull_request_template.md)**: A standardized template to streamline and ensure consistent Pull Request submissions.
- **[ISSUE_TEMPLATE/](./.github/ISSUE_TEMPLATE)**: Structured bug report and feature request forms.
- **[CODEOWNERS](./.github/CODEOWNERS)**: Automatically requests reviews from the right people/teams based on which files changed.
- **[workflows/](./.github/workflows)**: Starter GitHub Actions pipelines — `ci.yml` (lint/test/build), `security.yml` (secret + dependency scanning), `dependency-review.yml`.
- **[dependabot.yml](./.github/dependabot.yml)**: Automated dependency update PRs.
- **[.gitlab-ci.yml](./.gitlab-ci.yml)**: A standalone GitLab CI/CD pipeline mirroring the stages documented in [GitLab CI/CD Standards](#gitlab-cicd-standards).
- **[CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md)** and **[SECURITY.md](./SECURITY.md)**: Community expectations and the private vulnerability-reporting process.
- **[CHANGELOG.md](./CHANGELOG.md)**: Keep a Changelog + SemVer-formatted release history.
- **[LICENSE](./LICENSE)** / **[LICENSE-DOCS](./LICENSE-DOCS)**: See [Licensing](#licensing) below.
- **[.gitignore](./.gitignore)** / **[.editorconfig](./.editorconfig)**: Baseline ignore rules and editor formatting defaults.
- **[governance/](./governance)**, **[standards/](./standards)**, **[naming-conventions/](./naming-conventions)**, **[pr-guidelines/](./pr-guidelines)**: The detailed, authoritative standards this README summarizes — see [Repository Structure](#repository-structure) below.
- **[templates/](./templates)**, **[workflows/](./workflows)**, **[code-starter/](./code-starter)**, **[docs/](./docs)**: Fill-in-the-blank templates, day-to-day process docs, copy-paste starter config, and the docs index — see [docs/overview.md](./docs/overview.md).
- **Branch Protections**: Enforces rules and best practices to maintain code quality, prevent unauthorized changes, and ensure consistent development workflows. It helps safeguard important branches, such as the `main` or `release` branches, from accidental deletion or direct, unreviewed commits.
  - To enable branch protections, see GitHub's official documentation on [Configuring branch protection rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-branch-protection-rules), or prefer [rulesets](./standards/github-standards.md#rulesets-preferred-over-classic-branch-protection).

### Repository Structure

```
engineering-playbook/
├── .github/              Automation GitHub reads directly (workflows, issue/PR templates, CODEOWNERS)
├── governance/            SDLC phases, decision rights, risk, security program, ADRs
├── standards/              Coding/branching/commit/CI-CD/docker/gitops/GitHub-setup standards
├── naming-conventions/     Files, branches, variables, infra naming rules
├── pr-guidelines/          PR policy (size, review SLAs, checklists, industry standards)
├── templates/              Fill-in-the-blank docs for new projects (README, architecture, API design...)
├── workflows/              Human process docs (code review, release, incident response)
├── code-starter/           Copy-paste config for a brand-new repo (.env.example, pre-commit, setup scripts)
├── docs/                   The docs index/wiki — start at docs/overview.md
└── README.md               You are here — entry point linking to all of the above
```

See [docs/architecture.md](./docs/architecture.md) for why the docs are organized this way (one authoritative home per topic).

---

## Quick Start

### Suggested Reading Order

If you're adopting this repo as a template/playbook for a new project, don't read everything front-to-back — most of it is reference material you'll come back to. Three tiers:

**Tier 1 — read once, before touching anything:**
1. This README (you're here).
2. [docs/overview.md](./docs/overview.md) — the index/wiki.
3. [governance/SDLC.md](./governance/SDLC.md) — the lifecycle phases everything else maps onto.
4. [standards/repository-architecture.md](./standards/repository-architecture.md) — monorepo vs. polyrepo; decide this before step 5 below, since it's expensive to reverse.

**Tier 2 — decide/configure once, at project setup:**

5. [standards/github-repo-setup.md](./standards/github-repo-setup.md) — create and secure the actual GitHub repo (security features, rulesets, CODEOWNERS).
6. [governance/governance-model.md](./governance/governance-model.md) — roles, approval gates, and org/enterprise settings (owners, teams, SSO/2FA) if applicable.
7. [standards/branching-strategy.md](./standards/branching-strategy.md) + [naming-conventions/branches.md](./naming-conventions/branches.md) — pick a branching model.
8. [.github/CONTRIBUTING.md](./.github/CONTRIBUTING.md) — the concrete day-to-day commands.
9. [pr-guidelines/README.md](./pr-guidelines/README.md) — PR size/review policy and the Conventional Comments format.
10. [governance/security-practices.md](./governance/security-practices.md) + [SECURITY.md](./SECURITY.md) — security program and vulnerability reporting.
11. [code-starter/](./code-starter) (`README.md` → `.env.example` → `.pre-commit-config.yaml` → `scripts/setup.sh`/`.ps1`) — copy into the new repo.
12. [naming-conventions/](./naming-conventions) (the rest) and whichever [standards/](./standards) files match your actual stack (`coding-standards.md`, `commit-message-guidelines.md`, `ci-cd-standards.md`, `docker-standards.md`, `gitops-standards.md`, `github-standards.md`).
13. [templates/](./templates), starting with `project-setup-template.md` (folder structure), then `readme-template.md` for the new repo's own README.

**Tier 3 — reference only when the moment actually arises:**
- [workflows/](./workflows) (`code-review-workflow.md`, `release-workflow.md`, `incident-response-workflow.md`) — pull up when you're actually reviewing a PR, cutting a release, or firefighting.
- [templates/architecture-template.md](./templates/architecture-template.md), `api-design-template.md`, `testing-template.md`, `onboarding-template.md` — only when that specific artifact needs writing.
- [governance/architecture-decision-records/](./governance/architecture-decision-records) — when you make your first hard-to-reverse decision.
- `CHANGELOG.md`, `LICENSE`, `LICENSE-DOCS`, `NOTICE`, `CODE_OF_CONDUCT.md` — skim once, revisit at release time.

### Starting a new project from this template
1. On GitHub, click **"Use this template" → "Create a new repository"** (or `git clone` this repo and re-point its remote).
2. Replace placeholders throughout the scaffolding: `@your-org/*` in [CODEOWNERS](./.github/CODEOWNERS), contact emails in [SECURITY.md](./SECURITY.md), the copyright line in [LICENSE](./LICENSE)/[LICENSE-DOCS](./LICENSE-DOCS), and repo URLs in [ISSUE_TEMPLATE/config.yml](./.github/ISSUE_TEMPLATE/config.yml).
3. Uncomment and adapt the stack-specific steps in [`.github/workflows/ci.yml`](./.github/workflows/ci.yml), [`.github/dependabot.yml`](./.github/dependabot.yml), and/or [`.gitlab-ci.yml`](./.gitlab-ci.yml) for your language/toolchain; delete the examples you don't need.
4. Enable branch protection on `main`/`develop` (see [Project Resources](#project-resources)) and confirm required status checks match the workflow job names above.
5. Update this README's title, Goals, and stack-specific sections to describe your actual project.

### Working in an existing clone
```bash
git clone <your-repo-url>
cd <your-repo-directory>
```
Install whatever dependencies your project's stack requires (e.g., `npm ci`, `pip install -r requirements.txt`, `go mod download`) — see your project's stack-specific docs since this template is language-agnostic.

---

## Branching Strategy

To maintain consistency and quality throughout the development process, follow the branching strategy outlined below. This model is a simplified variant of **git-flow**, originally described in Vincent Driessen's [*A successful Git branching model*](https://nvie.com/posts/a-successful-git-branching-model/) — see [standards/branching-strategy.md](./standards/branching-strategy.md) for the full attribution, the optional release-branch pattern from that original model, and the author's own guidance on when a simpler trunk-based/GitHub-flow model fits better.

- **Base Branch (`develop`)**:
    - The `develop` branch serves as the default branch for active development.
    - All feature, experimental, and bugfix branches are created from the `develop` branch.

- **Feature Branches**:
    - Use `feature/<name>` to add new features or enhancements to the project.
    - Examples:
        - `feature/add-logging`
        - `feature/api-integration`

- **Experimental Branches**:
    - Use `experiment/<name>` for exploratory or temporary work that may not immediately integrate into active development.
    - Examples:
        - `experiment/improve-performance`
        - `experiment/additional-eda`

- **Bugfix Branches**:
    - Use `bugfix/<name>` to fix small, non-urgent coding issues.
    - Examples:
        - `bugfix/fix-regression-error`
        - `bugfix/fix-off-by-one`

- **Hotfix Branches**:
    - Use `hotfix/<name>` for urgent issues in production that require immediate application to the `main` branch.
    - Examples:
        - `hotfix/fix-crash-bug`
        - `hotfix/db-connection-fail`

> **Note**: Elite performers achieve faster delivery with small batch sizes and trunk-based principles (paired with feature flags) that reduce integration debt. If release cadence increases, consider migrating toward trunk-based development while preserving release governance.

For a more detailed description of branch workflows, see the [CONTRIBUTING.md](./.github/CONTRIBUTING.md) file.

---

## Pull Request Workflow

To ensure a smooth development process, follow these guidelines before submitting a Pull Request (PR). This process is grounded in two widely-adopted, publicly documented industry standards — Google's [Engineering Practices](https://github.com/google/eng-practices) code review guidelines and [Conventional Comments](https://conventionalcomments.org/) — see [pr-guidelines/README.md § Industry-Recognized Standards](./pr-guidelines/README.md#industry-recognized-standards) for the full detail and attribution.

### Pre-Submission Checklist

Before opening a PR, verify that the following steps are complete:

1. Code passes your stack's linting/formatting checks and automated tests (e.g. `black`/`flake8` + `pytest` for Python, `eslint`/`prettier` + `npm test` for Node).
2. Commit messages follow conventional, imperative style (subject ≤ 50 chars, body wrapped ≤ 72 chars, explains *why*):
    ```plaintext
    feat(api): add endpoint for retrieving user profiles
    fix(model): resolve timeout issue in data processing
    ```
3. Documentation is updated for any major changes (e.g., `README.md`, notebooks, docstrings).

### Submission Guidelines

When opening a Pull Request, follow these steps:

1. Use the Pull Request Template located at `.github/PULL_REQUEST_TEMPLATE.md`.
   - Fill out all sections of the template (e.g., Description, Related Issues, Test Instructions).
   - **Delete the "Usage Instructions" section** of the PR template before submitting.
2. Assign at least **2 reviewers** to the PR.
3. Reference any related GitHub issues, Jira tickets, etc. in the PR description to maintain a clear, traceable history:
    ```plaintext
    Closes #123
    Related to [PROJ-456](https://jira.example.com/browse/PROJ-456)
    ```
4. Ensure `main`/`develop` branch protections (required reviews, status checks, signed commits, no direct pushes) are respected. See GitHub's [branch protection documentation](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-branch-protection-rules) for configuration.

For detailed Pull Request instructions, consult the [CONTRIBUTING.md](./.github/CONTRIBUTING.md) file.

---

## Engineering Standards

Full detail lives in [standards/engineering-standards.md](./standards/engineering-standards.md) (performance, accessibility, maintainability, CI/CD & observability) and [governance/security-practices.md](./governance/security-practices.md) (security program). Summary:

- **Performance**: Core Web Vitals targets (INP ≤ 200ms, LCP ≤ 2.5s, CLS ≤ 0.1), server-first architectures, RUM + performance budgets in CI.
- **Security**: OWASP Top 10 baseline, SAST/DAST + dependency scanning blocking on critical findings, SBOMs/signed artifacts — see [governance/security-practices.md](./governance/security-practices.md).
- **Accessibility**: WCAG 2.2 AA (semantic HTML, keyboard operability, contrast, focus states, 24×24px tap targets).
- **Maintainability**: typed languages where practical, enforced lint/format, low cyclomatic complexity.
- **CI/CD & Observability**: optimize for [DORA metrics](https://dora.dev/) (deploy frequency, lead time, MTTR); tracing/metrics/error monitoring.

---

## GitHub Standards

Setting up a brand-new repository from scratch? See [standards/github-repo-setup.md](./standards/github-repo-setup.md) for the full step-by-step checklist (security features, rulesets, Git LFS, Actions hardening) and [standards/repository-architecture.md](./standards/repository-architecture.md) for the monorepo-vs-polyrepo decision that should come first. Ongoing-hygiene detail (repo hygiene, GitHub Apps/integrations, rulesets) lives in [standards/github-standards.md](./standards/github-standards.md); commit message style has its own file: [standards/commit-message-guidelines.md](./standards/commit-message-guidelines.md).

- Keep `README.md`, `LICENSE`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md` current; grant GitHub Apps/integrations minimum required permissions.
- Use descriptive, imperative commit subjects (≤ 50 chars) that explain *why*, not just *what*.

---

## GitLab CI/CD Standards

Treat CI/CD as a platform product: shared templates, explicit control flow, immutable artifacts, and strong environment governance. Full principles and a runnable `.gitlab-ci.yml` example (central-template version) live in [standards/ci-cd-standards.md](./standards/ci-cd-standards.md); the actual starter pipeline for this repo is at [`.gitlab-ci.yml`](./.gitlab-ci.yml).

- **Fail fast and cheaply**: stage order `lint` → `unit` → `build` → `integration` → `security` → `staging` → `production`.
- `include`/`extends` for central templates; keep per-service files thin; model dependencies with a DAG (`needs:`).
- Differentiate `cache` (restores deps between jobs) from `artifacts` (immutable outputs passed between stages).
- Protected environments, masked/protected CI/CD variables, blocking security scans on critical findings.

---

## Argo CD (GitOps) Standards

Full detail and a runnable `Application` manifest example live in [standards/gitops-standards.md](./standards/gitops-standards.md).

- **Repository separation**: Kubernetes manifests/config live in a separate Git repo from application source, for clean audit trails and to avoid CI loops.
- **Immutability**: pin to tags/commit SHAs — never `HEAD` or floating refs in Helm/Kustomize sources.
- **Secrets**: Git/Helm credentials via Kubernetes secrets referenced in Argo CD repo config, never inline in manifests.
- **Patterns**: App-of-Apps, SyncWaves, and ApplicationSets for multi-service deployments and PR preview environments.

---

## Docker Standards

Full detail plus a runnable multi-stage `Dockerfile` and `.dockerignore` example live in [standards/docker-standards.md](./standards/docker-standards.md).

- **Image building**: multi-stage builds; minimal base images (slim/Alpine/distroless); pin versions (never `latest`); order layers by change frequency.
- **Security & runtime**: non-root user, resource limits, a `HEALTHCHECK`; secrets via Docker/Kubernetes secrets or a vault, never environment variables baked into the image.

---

## Documentation Standards
When contributing, ensure any relevant documentation is updated as part of the contribution process. Full detail (what to update when, writing guidelines, Markdown conventions) lives in [standards/documentation-standards.md](./standards/documentation-standards.md):

- **README.md**: Add setup instructions or high-level details for major features.
- **Inline Comments**: Add meaningful inline comments for complex or critical logic.
- **Templates or Test Benchmarks**: Update templates, tests, or markdown files if the contribution changes workflows.

---

## Licensing

This repository uses a split license, matching the two kinds of content it contains:

| Content | License | File |
|---|---|---|
| Source code, scripts, CI/CD workflow and config files | [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0) | [LICENSE](./LICENSE) |
| Narrative documentation (this README, `/docs`, playbook text) | [Creative Commons Attribution 4.0 (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/) | [LICENSE-DOCS](./LICENSE-DOCS) |

- **Apache-2.0** gives downstream users strong, court-tested legal protection to use/modify/distribute code, with an explicit patent grant, while requiring that modified files and the [NOTICE](./NOTICE) file be preserved.
- **CC BY 4.0** requires attribution when the documentation/playbook content is reused or adapted elsewhere — see [LICENSE-DOCS](./LICENSE-DOCS) for the exact attribution format.

If you fork this template for your own project, update the copyright line in `LICENSE`, `LICENSE-DOCS`, and `NOTICE`, and choose whichever license(s) fit your project (the split isn't required if your new repo is code-only or docs-only).

---

## Curated Resources

### Books
- *Clean Code* — Robert C. Martin (code quality)
- *The Pragmatic Programmer* — Hunt & Thomas (craftsmanship)
- *Design Patterns* — Gamma et al. (OO design)
- *Refactoring* — Martin Fowler (improving legacy code)
- *Code Complete* — Steve McConnell (software construction)
- *Continuous Delivery* — Humble & Farley (build/test/deploy)
- *Domain-Driven Design* — Eric Evans (modeling complexity)

### Websites
- [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/) — Vincent Driessen's original git-flow post (2010, CC BY-SA); the inspiration for this repo's default branching model — see [standards/branching-strategy.md](./standards/branching-strategy.md) for the full attribution, including the author's own 2020 reflection on when git-flow fits (versioned software) vs. when it doesn't (continuously-delivered web apps, where he recommends GitHub flow/trunk-based instead).
- [Google Engineering Practices](https://github.com/google/eng-practices) — "The Standard of Code Review," "Speed of Code Reviews," and "Small CLs"; the industry-standard code review process this repo's [pr-guidelines/](./pr-guidelines) are built on.
- [Conventional Comments](https://conventionalcomments.org/) — a standardized, greppable format (`label: subject`) for PR review comments, used in [pr-guidelines/README.md](./pr-guidelines/README.md#review-comment-format-conventional-comments).
- [GitHub Well-Architected: Repository Architecture Strategy](https://learn.github.com/well-architected/architecture/recommendations/scaling-git-repositories/repository-architecture-strategy) — GitHub's own monorepo-vs-polyrepo guidance, adapted in [standards/repository-architecture.md](./standards/repository-architecture.md).
- [GitHub Docs: Best practices for repositories](https://docs.github.com/en/repositories/creating-and-managing-repositories/best-practices-for-repositories) and [About rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets) (both CC BY 4.0) — the basis for [standards/github-repo-setup.md](./standards/github-repo-setup.md).
- [California CDT: GitHub Best Practices](https://webstandards.ca.gov/2023/04/19/github-best-practices/) — a government engineering org's published GitHub standard, aggregating the above plus org/enterprise and Actions-hardening guidance (see [governance/governance-model.md](./governance/governance-model.md) and [governance/security-practices.md](./governance/security-practices.md)).
- [MDN Web Docs](https://developer.mozilla.org/en-US/) — authoritative docs for HTML/CSS/JS, APIs, accessibility, and performance.
- [W3C Standards](https://www.w3.org/standards/) — open web platform specs and guidelines.
- [WebStandards.org](https://www.webstandards.org/learn/index.html) — curated resources for standards-based development.

### YouTube Channels
- freeCodeCamp.org — long, structured courses; comprehensive tooling.
- Traversy Media — project-based build tutorials (JS, Docker, CI/CD).
- Net Ninja — mini-courses on React, TypeScript, Node.
- Web Dev Simplified — front-end concepts, performance, accessibility.
- [GitHub](https://www.youtube.com/@GitHub) (official channel) — e.g. [*How to create your first GitHub repository*](https://www.youtube.com/watch?v=-RZ03WHqkaY) and [*Repository Rules: Code Compliance at Scale*](https://www.youtube.com/watch?v=BYajh38HhCs), referenced in [standards/github-repo-setup.md](./standards/github-repo-setup.md).
- Kevin Powell — CSS, responsive layouts, modern techniques.
- Corey Schafer — Python, Git, tooling.

---

## Final Notes
Thank you for contributing! Please reach out to the team leads if you have any questions regarding the contribution process, workflows, or engineering standards.

To enable or adjust branch protections, see GitHub's documentation on [configuring branch protection rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-branch-protection-rules).
