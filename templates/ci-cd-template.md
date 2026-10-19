# CI/CD Template

Unlike the other files in this folder, there's no separate fill-in-the-blank template here — the **runnable** starters are already at the repo root and are what you actually copy:

- [`.github/workflows/ci.yml`](../.github/workflows/ci.yml) — lint → test → build (GitHub Actions)
- [`.github/workflows/build.yml`](../.github/workflows/build.yml) — multi-OS build matrix
- [`.github/workflows/security.yml`](../.github/workflows/security.yml) — secret + dependency scanning
- [`.github/workflows/dependency-review.yml`](../.github/workflows/dependency-review.yml) — blocks vulnerable dependency PRs
- [`.github/workflows/conventional-commits.yml`](../.github/workflows/conventional-commits.yml) — commit/PR title linting
- [`.github/dependabot.yml`](../.github/dependabot.yml) — automated dependency updates
- [`.gitlab-ci.yml`](../.gitlab-ci.yml) — the same pipeline shape, for GitLab

**To bootstrap a new project**: copy whichever of the files above matches your platform (GitHub vs. GitLab), then uncomment/fill in the stack-specific steps inside them (search for `TODO`).

For the design principles behind these pipelines (why this stage order, cache vs. artifacts, etc.), see [standards/ci-cd-standards.md](../standards/ci-cd-standards.md). For deployment/GitOps once you have a built artifact, see [standards/gitops-standards.md](../standards/gitops-standards.md).
