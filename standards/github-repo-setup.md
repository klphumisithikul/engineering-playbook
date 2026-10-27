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
GitHub's own guidance is explicit that these should be enabled **at minimum**, and most are free for public repositories. The [OpenSSF Scorecard](https://github.com/ossf/scorecard) — the closest thing the industry has to a standardized rubric for "is this repo secured" — independently scores several of these same toggles (`Security-Policy`, `SAST`, `Dependency-Update-Tool`, `Vulnerabilities`, `Branch-Protection`, `Token-Permissions`), so treat a clean Scorecard run as external validation that this section was done correctly.

Below is every control on **Settings → Code security and analysis**, in the same top-to-bottom order the page itself renders them, with the recommended setting and why.

### 3.1 Private vulnerability reporting
**Recommendation: on, unconditionally, on every repository.** This toggle lets an outside researcher who finds a vulnerability open a private report (backed by a draft Security Advisory) directly against the repo, instead of their only option being a public issue that tips off attackers before a fix ships. It's free on every plan and every visibility level, has no operational cost, and is the mechanism [SECURITY.md](../SECURITY.md)'s "report it privately" instruction actually depends on — without this toggle, the "Report a vulnerability" button in the Security tab doesn't exist. Enable it even on repos with no external audience today: it costs nothing and is defense in depth if the repo's visibility ever changes.

### 3.2 Dependency graph
**Recommendation: on, unconditionally — treat this as a prerequisite, not a judgment call.** It's the inventory GitHub builds from your manifests/lockfiles that every other control in this section reads from: Dependabot alerts, Dependabot security updates, and the Dependency Review API that [.github/workflows/dependency-review.yml](../.github/workflows/dependency-review.yml) calls on every PR all depend on it. It's on by default (and can't be turned off) for public repositories; for private/internal repositories it must be explicitly enabled here first. If this is off on a private repo, `dependency-review.yml` will fail outright — check this before debugging that workflow.

### 3.3 Dependabot
- **Dependabot alerts** — **on.** Matches dependency-graph contents against the GitHub Advisory Database and surfaces known CVEs per dependency. Free for every repo, public or private (not gated behind GitHub Advanced Security). This is the detection half of the lifecycle documented in [governance/security-practices.md § Resolving Dependabot Alerts](../governance/security-practices.md#resolving-dependabot-alerts).
- **Dependabot security updates** — **on.** The moment an alert fires, this auto-opens a PR bumping *only* to the minimum patched version. This is distinct from the scheduled, version-wide bumps [.github/dependabot.yml](../.github/dependabot.yml) already runs weekly for the `github-actions` ecosystem — security updates fire on-demand per vulnerability and take priority over waiting for the next scheduled run. Also enable **Grouped security updates** alongside it once you're tracking more than a couple of ecosystems, to collapse multiple same-severity alerts into one PR instead of a flood of single-bump PRs.
- **Dependabot on Actions runners** — **off by default; turn on only when you have a concrete reason.** This setting moves *version-update* runs (the scheduled `dependabot.yml` jobs, not security updates) off GitHub's isolated Dependabot compute and onto your own Actions runners instead. Turn it on when either becomes true: (a) you need Dependabot to reach a *private* package registry or internal proxy that's only reachable from your runners/VPN/self-hosted runners — Dependabot's own sandboxed compute can't reach it — or (b) you want update-run logs visible in the Actions tab for debugging a failing scheduled bump, instead of the separate, more limited Dependabot UI. Nothing in this repo's current `dependabot.yml` (public `github-actions` ecosystem only) needs either, so leave it off until a private ecosystem is added — flip it then, not preemptively.

### 3.4 Code scanning
- **CodeQL analysis** — **add it; it's additive, not redundant, with what's already here.** [.github/workflows/security.yml](../.github/workflows/security.yml) already runs Trivy (known-CVE and misconfiguration scanning against dependencies/filesystem) and gitleaks (committed secrets); neither performs semantic source-code analysis. CodeQL is GitHub's SAST engine — it traces actual data flow through your code to catch injection, insecure deserialization, SSRF, and similar classes Trivy/gitleaks structurally cannot see, because they don't parse your code's logic at all. Together, gitleaks (secrets) + Trivy (known vulnerable deps/images) + CodeQL (code-level vulnerabilities) is the standard three-layer coverage model — don't treat any one as a substitute for the other two.
  - **Default setup** (click "Set up" → "Default"): GitHub auto-detects languages, generates and *maintains* the workflow itself (including CodeQL version bumps), and requires no YAML of your own. **Start here** for any supported language — it's a one-click action with near-zero maintenance burden.
  - **Advanced setup**: you own a `codeql.yml` workflow in `.github/workflows/`, trading that convenience for control — custom query packs (e.g., `security-extended` or `security-and-quality`, which add checks beyond CodeQL's default query suite), non-standard build steps for compiled languages, or merging CodeQL's SARIF output into the same workflow run as your other scanners for a single audit trail. **Graduate to Advanced** only once Default setup's lack of customization actually blocks something concrete — don't start there by default.

### 3.5 Secret scanning
- **Secret scanning alerts** — **on, unconditionally.** Scans existing history and every new push for recognizable secret formats (cloud provider keys, API tokens, etc.) against GitHub's and partners' published patterns. Free and on by default for public repos; for private/internal repos it requires a **GitHub Advanced Security (GHAS)** license, billed per active committer. If GHAS isn't budgeted yet for a private repo, the gitleaks job already in [.github/workflows/security.yml](../.github/workflows/security.yml) is the explicit stopgap this repo ships — it covers the same detection class (committed secrets) without the license, just as a CI check after the fact rather than a platform-native, continuously-running scan.
- **Push protection** — **on, unconditionally, wherever secret scanning is on.** This is the control that actually matters most of the two: it blocks the `git push` outright *before* a detected secret ever lands in history, rather than alerting after the leak already happened and needs a history rewrite to fully remediate. Free and default-on for public repos; GHAS-gated for private repos same as alerts above. Restrict who can bypass a push-protection block to a small, auditable set of people/teams (**Settings → Code security and analysis → Push protection → bypass list**, or org-wide) and require a documented reason for every bypass — treat a bypass event itself as something to review, not something to allow silently.
- **Validity checks** and **non-provider patterns** — **on, if you're already on GHAS; both are refinements, not gap-fillers.** Validity checks ask the issuing provider whether a detected token is still active, letting you triage "confirmed live credential" ahead of "pattern matched but likely already rotated/dead" — this cuts triage noise rather than adding coverage. Non-provider patterns extend detection to generic secret shapes (private keys, generic password assignments) beyond known-vendor token formats — this *adds* coverage, at the cost of more false positives, so pair it with push protection's custom-pattern allowlisting if noise becomes a problem. Both are part of the GHAS entitlement already required for secret scanning on a private repo, so there's no separate cost to turning them on once you're paying for GHAS at all.

**In the UI**: go to **Settings → Code security and analysis** and, top to bottom, enable: **Private vulnerability reporting**, **Dependency graph**, **Dependabot alerts**, **Dependabot security updates** (and **Grouped security updates**), **Dependabot on Actions runners** (only if you have the concrete reason above), **Code scanning → CodeQL analysis → Set up → Default**, **Secret scanning → Enable**, **Push protection → Enable**, and — if on GHAS — **Validity checks** and **Non-provider patterns**. All of this can also be configured at the organization level — see step 8. Full detail and the broader security program this plugs into: [governance/security-practices.md](../governance/security-practices.md).

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

## Appendix: Full Settings Walkthrough (Visual Order)

Steps 1–8 above are organized by *task*. This appendix instead walks the **Settings sidebar top-to-bottom as it renders on github.com**, so you can sanity-check a repo tab-by-tab (e.g. during an audit) without re-deriving which task each tab belongs to. GitHub reshuffles this layout occasionally — verify against your own repo if a tab has moved.

### Part 1: Settings page, section by section

**General** (top-level, no group header)
- **Repository name / default branch / template repository toggle** — rename carries redirects, but update any hardcoded clone URLs in CI or docs after renaming; default branch is `main` per [naming-conventions](../naming-conventions/files-and-folders.md) convention.
- **Features**: Issues, Discussions on if you want them; Wikis off (keep docs in-repo, see step 1 above); Projects/Sponsorships as needed.
- **Pull Requests**: see step 5's "complementary settings" above (squash-only merge, auto-delete head branches, auto-merge, suggest updating branches).
- **Danger Zone** (bottom): visibility change, transfer, archive, delete — all irreversible or high-blast-radius; require explicit sign-off from a maintainer (see [governance/governance-model.md](../governance/governance-model.md)) before touching anything here.

**Access**
- **Collaborators and teams** — see step 4 above ("Favor Branching Over Forking") for the full teams-not-individuals walkthrough.

**Code and automation**
- **Branches** and **Tags → Rules → Rulesets** — see step 5 above. One addition not covered there: **tag protection rules** (`Settings → Tags → Rules`, or a tag-scoped ruleset) — protect version tags (`v*`) from deletion or being moved to a different commit after a release ships, the same way branch rules protect `main`.
- **Actions → General** — see step 7 above ("Harden GitHub Actions").
- **Actions → Runners** — leave empty (use GitHub-hosted runners) unless you have a specific need (e.g. GPU hardware, on-prem network access). If you do add self-hosted runners, never attach them to a public repository (see [governance/security-practices.md § GitHub Actions Hardening](../governance/security-practices.md#github-actions-hardening)) and scope them to a single repo rather than org-wide where the workload allows it, to limit blast radius if a runner is compromised.
- **Webhooks** — only add what's actually consumed downstream (e.g. a Slack/CI integration); for each one, require HTTPS, set a secret so the receiver can verify the payload signature, and subscribe only to the events actually used (full detail: [standards/github-standards.md § GitHub Apps & Integrations](./github-standards.md#github-apps--integrations)).
- **Environments** — if you deploy from Actions, define `staging`/`production` environments (naming per [naming-conventions/infrastructure-resources.md § Environments](../naming-conventions/infrastructure-resources.md#environments)) and attach **required reviewers** and a **wait timer** to `production` so a deploy job pauses for human approval instead of running unattended the moment CI goes green; scope environment secrets (cloud credentials) to the environment that needs them rather than the whole repo.
- **Codespaces** — leave default unless the team standardizes on Codespaces for dev environments; if you do, commit a `.devcontainer/` config so everyone gets the same environment rather than relying on individually-configured machine images.
- **Pages** — only relevant if this repo publishes a GitHub Pages site; if enabled, keep the source restricted to a dedicated branch/folder (e.g. `gh-pages` or `/docs`) so a Pages deploy can't accidentally publish from an arbitrary branch.

**Security**
- **Code security and analysis** — the single most important tab in this list; see Part 2 below for the full visual-order breakdown.

**Integrations**
- **GitHub Apps** — prefer installing a GitHub App over an OAuth App or personal-access-token-based integration where the provider supports it: Apps authenticate as themselves with fine-grained, repo-scoped permissions rather than inheriting a human's full account access (see [standards/github-standards.md § GitHub Apps & Integrations](./github-standards.md#github-apps--integrations)). Review the installed list periodically and uninstall anything unused.
- **Deploy keys** — prefer a GitHub App or Actions' built-in `GITHUB_TOKEN`/OIDC over a deploy key where possible; if a deploy key is genuinely needed (e.g. a third-party CI system pulling this one repo), add it **read-only** unless write access is specifically required, and treat it as a credential to rotate, not a set-and-forget config.

### Part 2: Security tab, visual order (`Settings → Code security and analysis`)

This page is where step 3 above ("Secure the Repository") is actually configured. In the order the page renders:

1. **Private vulnerability reporting** — enable so a researcher can file a report privately instead of a public issue; this is what makes [SECURITY.md](../SECURITY.md)'s disclosure process actually usable.
2. **Security advisories** — not a toggle; this is where advisories you've published or drafted live. Draft one as soon as a reported vulnerability is confirmed, even before a fix ships, to track it (GitHub can keep it unpublished until you're ready to disclose).
3. **Dependency graph** — enable first, before the items below: it's the data source Dependabot alerts and the `dependency-review.yml` workflow both depend on. Without it, those features silently have nothing to scan.
4. **Dependabot alerts** — enable; flags known-vulnerable dependencies against the dependency graph above. See [.github/dependabot.yml](../.github/dependabot.yml).
5. **Dependabot security updates** — enable; auto-opens a PR bumping specifically to the patched version once an alert fires, rather than waiting for a routine version-update PR. Full triage lifecycle: [governance/security-practices.md § Resolving Dependabot Alerts](../governance/security-practices.md#resolving-dependabot-alerts).
6. **Grouped security updates** — enable once the repo has enough dependencies that individual security-update PRs become noisy; groups multiple patches into one PR to cut down review load.
7. **Code scanning** — click "Set up" → **Default** for a quick CodeQL start (GitHub picks the config for your detected languages), or **Advanced** if you need a custom query suite or non-default build steps; either way this is static analysis catching vulnerabilities/bugs before merge, not just at release. Enable **Copilot Autofix** (surfaces alongside Default/Advanced setup) if available on your plan — it suggests a fix directly on the alert.
8. **Secret scanning** — enable; detects committed secrets (API keys, tokens) against GitHub's known provider patterns.
9. **Push protection** — enable immediately after secret scanning (it depends on it being on); blocks a push *before* a secret lands in history, rather than only alerting after the fact — meaningfully higher bar than alerting, since a secret already in history must be treated as compromised and rotated even after removal.
10. **Validity checks** — enable if available; pings the relevant provider to confirm whether a detected secret is still active, so you can triage a live credential ahead of a long-expired test token.
11. **Non-provider patterns** (GitHub Advanced Security) — enable if your plan includes it and the repo handles custom/internal secret formats (e.g. an internal API token format) that GitHub's built-in provider patterns wouldn't catch.

All of this can also be set once at the **organization** level (`Settings → Code security` for the org) so new repos inherit these defaults instead of starting unconfigured — see [governance/governance-model.md § GitHub Organization & Enterprise Governance](../governance/governance-model.md#github-organization--enterprise-governance).

## Hands-On Practice
- GitHub's own [Introduction to Repository Management](https://github.com/skills/introduction-to-repository-management/) Skills exercise.
- GitHub's official video walkthroughs: [*How to create your first GitHub repository: A beginner's guide*](https://www.youtube.com/watch?v=-RZ03WHqkaY) and [*Repository Rules: Code Compliance at Scale*](https://www.youtube.com/watch?v=BYajh38HhCs) (the ruleset enforcement model summarized in step 5).

## Related
- [standards/github-standards.md](./github-standards.md) — ongoing hygiene once the repo exists.
- [standards/repository-architecture.md](./repository-architecture.md) — the monorepo/polyrepo decision to make before step 1.
- [templates/project-setup-template.md](../templates/project-setup-template.md) — folder structure to put inside the repo once it exists.
