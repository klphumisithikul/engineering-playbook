# Setting Up a GitHub Repository to Industry Standard

A concrete, step-by-step checklist for standing up a *new* GitHub repository correctly from day one — not after a security incident forces the issue. Built from GitHub's own official guidance (CC BY 4.0) plus the California Department of Technology's published GitHub standard, which aggregates the same GitHub docs for government engineering teams.

**Sources**: [GitHub Docs: Best practices for repositories](https://docs.github.com/en/repositories/creating-and-managing-repositories/best-practices-for-repositories) (CC BY 4.0) · [GitHub Docs: About rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets) (CC BY 4.0) · [California ODS/CDT: GitHub Best Practices](https://webstandards.ca.gov/2023/04/19/github-best-practices/) · GitHub's official YouTube channel: [*How to create your first GitHub repository*](https://www.youtube.com/watch?v=-RZ03WHqkaY) and [*Repository Rules: Code Compliance at Scale*](https://www.youtube.com/watch?v=BYajh38HhCs).

## 1. Create the Repository
- Pick a name per [naming-conventions/files-and-folders.md](../naming-conventions/files-and-folders.md).
- Decide **monorepo vs. polyrepo** first if this is a new system, not an afterthought — see [standards/repository-architecture.md](./repository-architecture.md).
- Add a **README** immediately. Per GitHub's own guidance: "To make it easier for people to understand and navigate your work, we recommend that you create a README file for every repository" — paired with a license, contribution guidelines, and a code of conduct, it "communicates expectations for your project and helps you manage contributions." Use [templates/readme-template.md](../templates/readme-template.md).
- Confirm repository **visibility** (public/private/internal) matches intent — set at creation, revisited later in **Settings → General → Danger Zone** if it ever needs to change.
- In **Settings → General → Features**, enable **Issues** (and **Discussions** if you want a public Q&A space instead of email/Slack); leave **Wikis** off unless you specifically need it — most teams keep docs in-repo instead.
- Grant repo access via **Settings → Collaborators and teams** — see step 4 below for the Teams walkthrough (create/add teams, assign roles).

## 2. Add the Baseline Files
Per both GitHub's and California's recommendations, add at minimum:
- `README.md`, `LICENSE`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md` — this template ships all five (see root of this repo). GitHub recognizes these in three locations — repo root, `docs/`, or `.github/` (lookup is case-insensitive) — pick one convention per repo and stick to it; this template keeps `CONTRIBUTING.md` in `.github/` and the other four at root.
- `.gitignore` to "keep sensitive files out of your repository" — see [.gitignore](../.gitignore).
- `.github/CODEOWNERS` to "define individuals or teams that are responsible for code in a repository" — see [.github/CODEOWNERS](../.github/CODEOWNERS).
- `.github/ISSUE_TEMPLATE/` (plus `config.yml`) and `.github/pull_request_template.md` (or a `.github/PULL_REQUEST_TEMPLATE/` folder if you need multiple, selectable templates) to standardize issue/PR intake — see [.github/ISSUE_TEMPLATE/](../.github/ISSUE_TEMPLATE) and [.github/pull_request_template.md](../.github/pull_request_template.md); full detail on which pattern to pick (and why this template ships both as a reference) in [standards/github-standards.md § Issue & PR Templates](./github-standards.md#issue--pr-templates).
- `.github/workflows/` for CI (lint/test/build), security scanning, and PR hygiene checks — see [templates/ci-cd-template.md](../templates/ci-cd-template.md) for the full list of starter workflows to copy and adapt (fill in the stack-specific `TODO`s). See step 5 below for a gotcha this creates for required status checks.

**At scale, across many repos in one GitHub Organization**: create a special `<org>/.github` repository. GitHub treats it as an org-wide fallback — any repo in the org that doesn't define its own `CONTRIBUTING.md`, `SECURITY.md`, issue/PR templates, etc. inherits the org's version automatically (a repo's own files always take precedence when present), and it also supplies the org's public profile README. This is the standard way platform/DevEx teams keep contribution workflows consistent org-wide without copy-pasting these files into every repo — see [governance/governance-model.md § GitHub Organization & Enterprise Governance](../governance/governance-model.md#github-organization--enterprise-governance) for the org-level settings this pairs with.

## 3. Secure the Repository (Minimum Bar)
GitHub's own guidance is explicit that these should be enabled **at minimum**, and they're free for public repositories:
- **Dependabot alerts** — flags vulnerable dependencies. See [.github/dependabot.yml](../.github/dependabot.yml).
- **Secret scanning** — detects committed secrets (API keys, tokens).
- **Push protection** — blocks a push *before* a secret lands in history, rather than just alerting after the fact.
- **Code scanning** — static analysis (e.g., CodeQL) to catch vulnerabilities/errors early.
- Additionally: a `SECURITY.md` (see [SECURITY.md](../SECURITY.md)) and **private vulnerability reporting** enabled, so researchers can disclose responsibly instead of filing a public issue.

**In the UI**: go to **Settings → Code security** and enable, top to bottom: **Dependabot alerts**, **Dependabot security updates** (auto-opens PRs for vulnerable deps — optionally also **Grouped security updates** to cut down PR noise), **Secret scanning**, **Push protection**, **Code scanning** (click "Set up" → "Default" for a quick CodeQL start, or "Advanced" for a custom workflow), and **Private vulnerability reporting**. All of this can also be configured at the organization level — see step 8. Full detail and the broader security program this plugs into: [governance/security-practices.md](../governance/security-practices.md).

## 4. Favor Branching Over Forking (for Regular Collaborators)
GitHub's guidance: "regular collaborators work from a single repository, creating pull requests between branches instead of between repositories. Forking is best suited for accepting contributions from people that are unaffiliated with a project." Internal team members get push access + branch workflow (see [standards/branching-strategy.md](./branching-strategy.md)); external open-source contributors fork.

**Granting that access in the UI**: per [governance/governance-model.md](../governance/governance-model.md)'s "use teams, not individual permissions" guidance, grant access via GitHub Teams rather than per-person:
1. Teams are an **organization-level** construct — if this repo lives under a personal account rather than an Organization, skip to the "Add people" fallback below.
2. In the org: **github.com/orgs/\<org\>/teams → New team** → name it, set **Visibility** to Visible (default), add members under its **Members** tab.
3. Back in this repo: **Settings → Collaborators and teams → Add teams**, select the team, and set its role — **Write** for regular contributors, **Triage** for people managing issues/PRs without push access, **Maintain**/**Admin** sparingly.
4. Reference the team in [.github/CODEOWNERS](../.github/CODEOWNERS) as `@org-name/team-slug` instead of individual usernames, so review assignment stays correct as membership changes.
5. Fallback for personal-account repos (no Teams available): **Settings → Collaborators and teams → Add people**, and add each contributor individually.

## 5. Protect Branches — Prefer Rulesets Over Classic Branch Protection

Both work, but GitHub now recommends **rulesets** as the more capable mechanism:

| | Classic Branch Protection | Rulesets |
|---|---|---|
| Rules per branch | One rule set applies | Multiple rulesets can apply simultaneously (merged/aggregated — most restrictive version of any conflicting rule wins) |
| Scope | Per-repository only | Per-repository, or **organization-wide** targeting many repos at once (GitHub Enterprise) |
| Visibility | Admin-only | Anyone with read access can view active rulesets — useful for audits |
| Toggling | Delete to disable | Can be set to "Disabled" without deleting (keeps config for later) |
| Bypass control | Admin bypass is implicit | Explicit, auditable bypass list (specific teams/apps/roles) |

Minimum ruleset for `main`/`develop`, matching [standards/branching-strategy.md § Merge Policy](./branching-strategy.md#merge-policy): require pull request review (≥2 approvals), require status checks to pass (lint/test/build/security — see `.github/workflows/`), block force pushes, require linear history or signed commits if your team has adopted that, and require conversation resolution before merging so review comments can't be silently ignored.

**In the UI**: go to **Settings → Rules → Rulesets → New ruleset → New branch ruleset**. Name it (e.g. `main-protection`), set **Enforcement status** to Active, add `main` (and `develop`) under **Target branches**, leave the **Bypass list** empty unless a specific break-glass role/app needs one, then under **Branch rules** check: **Require a pull request before merging** (set required approvals to 2; check "Dismiss stale pull request approvals when new commits are pushed" and "Require conversation resolution before merging"), **Require status checks to pass** (add each CI job name from `.github/workflows/`, and check "Require branches to be up to date before merging"), and **Block force pushes**. At scale, create the same ruleset at the **organization** level instead (`Settings → Rules` for the org) to target many repos at once.

A workflow only becomes selectable as a required status check above after it has reported at least one run — GitHub has nothing to list until a workflow has actually executed once. So after adding `.github/workflows/` (step 2), open a real PR against the new repo first so each workflow runs at least once, *then* come back and configure this ruleset.

Also set these complementary settings under **Settings → General → Pull Requests** (not part of a ruleset, but just as standard): uncheck "Allow merge commits" and "Allow rebase merging", leaving only **"Allow squash merging"** checked to keep history clean (matches the Merge Policy linked above); check **"Always suggest updating pull request branches"**; check **"Allow auto-merge"** so a reviewer can approve and walk away, with the merge firing automatically once the ruleset's required status checks pass (safe precisely because it's still gated by that ruleset — not a bypass of it); and check **"Automatically delete head branches"** after merge so stale branches don't pile up.

## 6. Set Up Git LFS if You Have Large Files
GitHub limits file sizes in regular Git. If the project needs binaries (datasets, media, compiled artifacts that must be versioned), use [Git LFS](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage) rather than committing them raw. Prefer not committing build artifacts at all — see [.gitignore](../.gitignore) — and keep spreadsheets/presentations in a tool built for them, not Git.

## 7. Harden GitHub Actions
See [governance/security-practices.md § GitHub Actions Hardening](../governance/security-practices.md#github-actions-hardening) for the full checklist (pinning third-party actions to a commit SHA, restricting `GITHUB_TOKEN` permissions, OIDC instead of long-lived cloud credentials, etc.).

**In the UI**: in **Settings → Actions → General**, set **Actions permissions** to "Allow select actions and reusable workflows" and explicitly allow-list the actions you use (forces pinning to vetted actions instead of "Allow all actions"); set **Workflow permissions** to **"Read repository contents permission"** as the default `GITHUB_TOKEN` scope, granting write only per-workflow via a `permissions:` block when actually needed; and uncheck **"Allow GitHub Actions to create and approve pull requests"** unless a specific workflow needs it. For secrets, prefer **Settings → Secrets and variables → Actions** scoped at the organization level (rather than duplicating per repo) and OIDC over long-lived cloud credentials wherever the provider supports it.

## 8. Set Organization-Level Governance (if applicable)
If this repo lives inside a GitHub Organization/Enterprise rather than a personal account, see [governance/governance-model.md § GitHub Organization & Enterprise Governance](../governance/governance-model.md#github-organization--enterprise-governance) for owners, teams, SSO, and 2FA requirements — these are set once per organization, not per repository, but they determine how safely *every* repository in the org can operate.

## Hands-On Practice
- GitHub's own [Introduction to Repository Management](https://github.com/skills/introduction-to-repository-management/) Skills exercise.
- GitHub's official video walkthroughs: [*How to create your first GitHub repository: A beginner's guide*](https://www.youtube.com/watch?v=-RZ03WHqkaY) and [*Repository Rules: Code Compliance at Scale*](https://www.youtube.com/watch?v=BYajh38HhCs) (the ruleset enforcement model summarized in step 5).

## Related
- [standards/github-standards.md](./github-standards.md) — ongoing hygiene once the repo exists.
- [standards/repository-architecture.md](./repository-architecture.md) — the monorepo/polyrepo decision to make before step 1.
- [templates/project-setup-template.md](../templates/project-setup-template.md) — folder structure to put inside the repo once it exists.
