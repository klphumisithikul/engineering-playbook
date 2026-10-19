# Onboarding to This Repo

For onboarding to a project *built from* this template, use [templates/onboarding-template.md](../templates/onboarding-template.md) instead — this page is specifically about contributing to the playbook/template itself.

## 15-Minute Orientation

1. Read [README.md](../README.md) top to bottom once — it's the map.
2. Skim [docs/overview.md](./overview.md) for the repository map and the "one authoritative home per topic" rule.
3. Read [governance/SDLC.md](../governance/SDLC.md) to understand the phase structure everything else hangs off of.
4. Skim [.github/CONTRIBUTING.md](../.github/CONTRIBUTING.md) for the actual mechanics of branching, committing, and PRs.

## Making Your First Change

1. Pick the single authoritative file for whatever you're changing (see the table in [docs/architecture.md](./architecture.md)).
2. Branch per [naming-conventions/branches.md](../naming-conventions/branches.md) (typically `feature/<name>` or `bugfix/<name>` off `develop`).
3. Make the change *there*, and add a one-line cross-link from `README.md` if it's significant.
4. Open a PR using [.github/pull_request_template.md](../.github/pull_request_template.md); see [pr-guidelines/](../pr-guidelines) for what reviewers will check.

## Common First Contributions
- Fix a broken link or stale example.
- Add a missing stack-specific example to a `TODO` in `.github/workflows/ci.yml`, `.gitlab-ci.yml`, or `standards/coding-standards.md`.
- Add an ADR for a decision that was made informally but never written down (see [governance/architecture-decision-records/](../governance/architecture-decision-records)).

If you get stuck, see [.github/CONTRIBUTING.md § Need Help?](../.github/CONTRIBUTING.md#need-help).
