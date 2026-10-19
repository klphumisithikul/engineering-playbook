# GitHub Standards

Authoritative detail behavind [README.md & GitHub Standards](/README.md#github-standards). This file cover **ongoing hygiene** for a repository that already exists - issue/PR intake, rulset, and GitHub Apps/Integrations. For the one-time checklist to standard up a *new* repo, see [standards/github-repo-setup.md](/standards/github-repo-setup.md), which this file complements and is cross-referenced from.

## Issue & PR Templates

GitHub recognizes templates in `.github/`, the repo root, or `docs/` (lookup is case-insensitive) - this repo keeps them all in `.github/`:
- **Issues**: [.github/ISSUE_TEMPLATE/](/.github/PULL_REQUEST_TEMPLATE/), which can disable blank issues and add `contact_links` that redirect to Discussions or a private security-advisory report instead.
- **Pull Requests**: GitHub support two mutally-exclusive patterns - 
    - A single [.github/pull_request_template.md](/.github/pull_request_template.md), applied to every PR automatically.
    - A [.github/PULL_REQUEST_TEMPLATE/](/.github/PULL_REQUEST_TEMPLATE/) folder with multiple named templates when different PR types (bugfix, feature, hotfix, experiment) need different checklists; contributors pick one from a dropdown when opening the PR, or via `?template=<name>.md` in the compare URL.

Pick **one** of these two patterns per repo - maintaining both invites drift between the generic template and the specific ones. This template currently shipes both ([pull_request_template.md](/.github/pull_request_template.md) and a [PULL_REQUEST_TEMPLATE/](/.github/PULL_REQUEST_TEMPLATE/) folder with `bugfix_template.md`, `experiement_template.md`, `feature_template.md`, `hotfix_template.md`) as a reference for both approaches; when adopting this repo as a template, delete whicever pattern you don't use.

## Rulsets Preferred Over Classic Branch Protection

See [standards/github-repo-setup.md & 5. Protect Branches](/standards/github-repo-setup.md#5-protect-branches--prefer-rulesets-over-classic-branch-protection) for the full classic-vs-rulesets comparison table and the minimum ruleset configuration (required reviews, status checks, no force pushes, conversation resolution. Revisit that ruleset periodically as part of ongoing hygiene - not just at repo creation - especially after adding new CI jobs that should become required status checks, or new teams that need an explicit bypass entry).

## Repository Hygiene

- Periodically re-retun the [Secure the Repository](/standards/github-repo-setup.md#3-secure-the-repository-minimum-bar) checklist - Dependabot, secret scanning, and push protection can be enabled org-wide by default for new repos, but existing repos predating that default won't pick it up automatically.
- Review [CODEOWNERS](/.github/CODEOWNERS.md) whenever teams or ownership boundaries change; stales entries silently stop requesting review from the right people.
- Archive or clearly mark repositories that are not longer maintained, so contributors don't open PRs against dead code.
- Keep **automatically delete head branches** (Settings -> General -> Pull Requests) enabled so merged branches don't pile up; prune any that predate the setting.

## GitHub Apps & Integration

- Grant GitHub Apps and OAuth Apps the minimum repository/organization permissions they need - review the installed-Apps list (Settings -> Integration) periodically and remove anything unused.
- Prefer GitHub Apps over personal-access-token-based integrations where possible: Apps are scoped per-repository and don't inherit a human's full account permissions.
- At the organization level, restrict which OAuth Apps members may approve without admin sign-off — see [governance/governance-model.md § GitHub Organization & Enterprise Governance](../governance/governance-model.md#github-organization--enterprise-governance).

## Related
- [standards/github-repo-setup.md](./github-repo-setup.md) — one-time checklist for a brand-new repository.
- [standards/branching-strategy.md](./branching-strategy.md) — the merge policy that rulesets enforce.
- [standards/commit-message-guidelines.md](./commit-message-guidelines.md) — commit style, enforced alongside the above.