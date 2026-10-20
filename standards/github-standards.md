# GitHub Standards

Authoritative detail behind [README.md § GitHub Standards](../README.md#github-standards). This file covers **ongoing hygiene** for a repository that already exists — issue/PR intake, rulesets, and GitHub Apps/integrations. For the one-time checklist to stand up a *new* repo, see [standards/github-repo-setup.md](./github-repo-setup.md), which this file complements and is cross-referenced from.

## Issue & PR Templates

GitHub recognizes templates in `.github/`, the repo root, or `docs/` (lookup is case-insensitive) — this repo keeps them all in `.github/`:
- **Issues**: [.github/ISSUE_TEMPLATE/](../.github/ISSUE_TEMPLATE) holds one Markdown file per form (`bug_report.md`, `feature_request.md`, ...) plus [config.yml](../.github/ISSUE_TEMPLATE/config.yml), which can disable blank issues and add `contact_links` that redirect to Discussions or a private security-advisory report instead.
- **Pull requests**: GitHub supports two mutually-exclusive patterns —
  - A single [.github/pull_request_template.md](../.github/pull_request_template.md), applied to every PR automatically.
  - A [.github/PULL_REQUEST_TEMPLATE/](../.github/PULL_REQUEST_TEMPLATE) folder with multiple named templates, when different PR types (bugfix, feature, hotfix, experiment) need different checklists; contributors pick one from a dropdown when opening the PR, or via `?template=<name>.md` in the compare URL.

  Pick **one** of these two patterns per repo — maintaining both invites drift between the generic template and the specific ones. This template currently ships both ([pull_request_template.md](../.github/pull_request_template.md) and a [PULL_REQUEST_TEMPLATE/](../.github/PULL_REQUEST_TEMPLATE) folder with `bugfix_template.md`, `experiment_template.md`, `feature_template.md`, `hotfix_template.md`) as a reference for both approaches; when adopting this repo as a template, delete whichever pattern you don't use.

## Rulesets Preferred Over Classic Branch Protection

See [standards/github-repo-setup.md § 5. Protect Branches](./github-repo-setup.md#5-protect-branches--prefer-rulesets-over-classic-branch-protection) for the full classic-vs-rulesets comparison table and the minimum ruleset configuration (required reviews, status checks, no force pushes, conversation resolution). Revisit that ruleset periodically as part of ongoing hygiene — not just at repo creation — especially after adding new CI jobs that should become required status checks, or new teams that need an explicit bypass entry.

## Repository Hygiene

- Periodically re-run the [Secure the Repository](./github-repo-setup.md#3-secure-the-repository-minimum-bar) checklist — Dependabot, secret scanning, and push protection can be enabled org-wide by default for new repos, but existing repos predating that default won't pick it up automatically.
- Review [CODEOWNERS](../.github/CODEOWNERS) whenever teams or ownership boundaries change; stale entries silently stop requesting review from the right people.
- Archive or clearly mark repositories that are no longer maintained, so contributors don't open PRs against dead code.
- Keep **automatically delete head branches** (Settings → General → Pull Requests) enabled so merged branches don't pile up; prune any that predate the setting.

## GitHub Apps & Integrations

- Grant GitHub Apps and OAuth Apps the minimum repository/organization permissions they need — review the installed-Apps list (Settings → Integrations) periodically and remove anything unused.
- Prefer GitHub Apps over personal-access-token-based integrations where possible: Apps are scoped per-repository and don't inherit a human's full account permissions.
- At the organization level, restrict which OAuth Apps members may approve without admin sign-off — see [governance/governance-model.md § GitHub Organization & Enterprise Governance](../governance/governance-model.md#github-organization--enterprise-governance).
- Review **Settings → Webhooks** periodically: confirm each webhook uses HTTPS, has a secret configured for payload signature verification, and only subscribes to the events it actually needs.

## Related
- [standards/github-repo-setup.md](./github-repo-setup.md) — one-time checklist for a brand-new repository.
- [standards/branching-strategy.md](./branching-strategy.md) — the merge policy that rulesets enforce.
- [standards/commit-message-guidelines.md](./commit-message-guidelines.md) — commit style, enforced alongside the above.
