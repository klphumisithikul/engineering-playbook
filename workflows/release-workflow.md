# Release Workflow

How a version gets cut, tagged, and shipped. Versioning rules themselves are defined by [Semantic Versioning 2.0.0](https://semver.org/) — summarized in [CHANGELOG.md](../CHANGELOG.md).

This workflow is the practical, SemVer-flavored version of the **release branch** pattern from Vincent Driessen's [*A successful Git branching model*](https://nvie.com/posts/a-successful-git-branching-model/) (git-flow) — see [standards/branching-strategy.md § Optional: Release Branches](../standards/branching-strategy.md#optional-release-branches-full-git-flow-pattern) for the full attribution and the original, more generic version of these steps.

## Steps

1. **Confirm `develop` is release-ready**: all intended PRs merged, CI green, `CHANGELOG.md`'s `[Unreleased]` section reflects what's shipping.
2. **Determine the version bump** using commit history since the last tag, per [standards/commit-message-guidelines.md](../standards/commit-message-guidelines.md):
   - Any `fix` commits only → bump **PATCH**
   - Any `feat` commits → bump **MINOR**
   - Any `BREAKING CHANGE:` → bump **MAJOR**
   - Pre-1.0.0 (`0.y.z`): anything may change; see [SemVer §4](https://semver.org/#spec-item-4) — treat the public API as unstable until `1.0.0`.
3. **Open a release PR** from `develop` into `main` (or, if you've adopted the optional `release/<version>` branch pattern, cut `release/X.Y.Z` from `develop` first for last-minute stabilization, then PR *that* into `main`), moving `CHANGELOG.md`'s `[Unreleased]` entries under a new `## [X.Y.Z] - YYYY-MM-DD` heading.
4. **Merge to `main`** once approved and checks pass (per [pr-guidelines/](../pr-guidelines)).
5. **Tag the release**: `git tag -a vX.Y.Z -m "Release X.Y.Z" && git push origin vX.Y.Z`. Tags are immutable — per SemVer §4, "once a versioned package has been released, the contents of that version MUST NOT be modified."
6. **Deploy**: trigger `deploy_production` in `.gitlab-ci.yml`, or the equivalent GitHub Actions release workflow, pointing at the tagged commit — see [standards/ci-cd-standards.md](../standards/ci-cd-standards.md) and [standards/gitops-standards.md](../standards/gitops-standards.md) (pin Argo CD's `targetRevision` to the new tag).
7. **Sync `develop`** back with `main` if the release PR introduced any hotfix-style changes directly on `main`.
8. **Publish release notes** (GitHub Releases, from the `CHANGELOG.md` entry).

## Rollback

If a release needs to be reverted: don't delete/retag — per SemVer, published versions are immutable. Instead, cut a new patch release that reverts the problematic change, or redeploy the previous tag while the fix is prepared. See [workflows/incident-response-workflow.md](./incident-response-workflow.md).
