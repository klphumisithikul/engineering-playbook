# CI/CD Template

Unlike the other files in this folder, there's no separate fill-in-the-blank template here — the **runnable** starters are already at the repo root and are what you actually copy:

- [`.github/workflows/ci.yml`](../.github/workflows/ci.yml) — lint → test → build (GitHub Actions)
- [`.github/workflows/build.yml`](../.github/workflows/build.yml) — multi-OS build matrix
- [`.github/workflows/security.yml`](../.github/workflows/security.yml) — secret + dependency scanning
- [`.github/workflows/dependency-review.yml`](../.github/workflows/dependency-review.yml) — blocks vulnerable dependency PRs
- [`.github/workflows/conventional-commits.yml`](../.github/workflows/conventional-commits.yml) — commit/PR title linting
- [`.github/workflows/template-enforcer.yml`](../.github/workflows/template-enforcer.yml) — enforces that PRs use the right issue/PR template
- [`.github/workflows/stale.yml`](../.github/workflows/stale.yml) — auto-flags inactive issues/PRs
- [`.github/workflows/auto-label.yml`](../.github/workflows/auto-label.yml) — labels PRs by which files they touch, using [`.github/labeler.yml`](../.github/labeler.yml) (copy both together — the workflow fails without its config)
- [`.github/dependabot.yml`](../.github/dependabot.yml) — automated dependency updates
- [`.gitlab-ci.yml`](../.gitlab-ci.yml) — the same pipeline shape, for GitLab

**To bootstrap a new project**: copy whichever of the files above matches your platform (GitHub vs. GitLab), then uncomment/fill in the stack-specific steps inside them (search for `TODO`). Two gotchas worth knowing before you copy-paste blindly:
- `template-enforcer.yml` has this repo's specific PR-template hidden IDs (`FEATURE_TEMPLATE_v1`, etc.) and branch-prefix mapping hard-coded into it — if the target repo's PR templates differ (or it doesn't use the `feature/`, `bugfix/`, `experiment/`, `hotfix/` branch prefixes from [standards/branching-strategy.md](../standards/branching-strategy.md)), edit the `rules` array to match, or every PR will fail this check.
- See [standards/github-repo-setup.md § 5](../standards/github-repo-setup.md#5-protect-branches--prefer-rulesets-over-classic-branch-protection) for a gotcha with making a copied workflow a required status check in a branch ruleset.

For the design principles behind these pipelines (why this stage order, cache vs. artifacts, etc.), see [standards/ci-cd-standards.md](../standards/ci-cd-standards.md). For deployment/GitOps once you have a built artifact, see [standards/gitops-standards.md](../standards/gitops-standards.md).
