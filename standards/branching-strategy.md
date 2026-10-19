# Branching Strategy

Authoritative policy behind [README.md § Branching Strategy](../README.md#branching-strategy). For the actual step-by-step git commands per branch type, see [.github/CONTRIBUTING.md § Branching Strategy](../.github/CONTRIBUTING.md#branching-strategy) — this file is the policy; CONTRIBUTING.md is the how-to.

## Default Model: `develop`-based

| Branch pattern | Purpose | Branches from | Merges to |
|---|---|---|---|
| `main` | Production-ready, deployable code | — | — |
| `develop` | Integration branch for active development | `main` | — |
| `feature/<name>` | New features or enhancements | `develop` | `develop` |
| `bugfix/<name>` | Small, non-urgent fixes | `develop` | `develop` |
| `experiment/<name>` | Exploratory/spike work that may be discarded | `develop` | `develop` (if validated) or discarded |
| `hotfix/<name>` | Urgent production fixes | `main` | `main` **and** `develop` |

Naming details (casing, separators) are specified in [naming-conventions/branches.md](../naming-conventions/branches.md).

## Origin & Attribution: git-flow

The default model above is a simplified variant of **git-flow**, the branching model originally described by Vincent Driessen in [*A successful Git branching model*](https://nvie.com/posts/a-successful-git-branching-model/) (nvie.com, January 5, 2010; licensed [CC BY-SA](https://creativecommons.org/licenses/by-sa/4.0/)). The two permanent branches (`master`/`main` = always production-ready, `develop` = integration branch for the next release) and the general shape of feature/hotfix branches come directly from that model. The deviations in this repo's default model vs. the original git-flow are:
- We use `main` (GitHub's modern default branch name) where the original post uses `master`.
- We add a `bugfix/<name>` branch type (git-flow itself doesn't distinguish bug fixes from features — both just happen on feature or release branches).
- We don't include a dedicated **release branch** by default; see the next section for that as an opt-in.

> **The original author's own 2020 reflection, worth reading before adopting this wholesale:**
> "If your team is doing continuous delivery of software, I would suggest to adopt a much simpler workflow (like [GitHub flow](https://guides.github.com/introduction/flow/)) instead of trying to shoehorn git-flow into your team. If, however, you are building software that is explicitly versioned, or if you need to support multiple versions of your software in the wild, then git-flow may still be as good of a fit to your team as it has been... To conclude, always remember that panaceas don't exist. Consider your own context." — Vincent Driessen

In other words: if you ship continuously and never support old versions in the wild, prefer the [Trunk-Based Development](#alternative-trunk-based-development) model below over the full `develop`-based model. If you explicitly version releases (e.g., a library, a CLI tool, on-prem/installed software), the full model — including release branches — fits better.

## Optional: Release Branches (full git-flow pattern)

For projects that explicitly version releases or must support multiple versions in the wild, add a third branch type on top of the default model:

| Branch pattern | Purpose | Branches from | Merges to |
|---|---|---|---|
| `release/<version>` | Final stabilization (version bump, last-minute fixes, release metadata) before shipping | `develop` | `main` **and** `develop` |

Rules (per the original git-flow model):
- No new features land on a release branch — only bug fixes, docs, and release-oriented tasks (version bumps, changelog finalization).
- The version number is decided **at the moment the release branch is cut**, not before — up until then `develop` just reflects "the next release," of unknown number.
- When done, merge into `main`, tag it, then merge back into `develop` so the fixes aren't lost.

```bash
# Create a release branch once develop is feature-complete for this release
git checkout -b release/1.2 develop
# bump version metadata, commit it
git commit -am "chore(release): bump version to 1.2"

# ...fix any last-minute bugs directly on this branch...

# Finish: merge to main and tag
git checkout main
git merge --no-ff release/1.2
git tag -a v1.2 -m "Release 1.2"

# Merge back into develop so the release-branch fixes aren't lost
git checkout develop
git merge --no-ff release/1.2
git branch -d release/1.2
```

This is exactly the flow formalized in [workflows/release-workflow.md](../workflows/release-workflow.md) — that document is the practical, repo-specific version of this pattern, using [standards/commit-message-guidelines.md](./commit-message-guidelines.md) to help decide the version bump itself (SemVer `MAJOR.MINOR.PATCH` rather than git-flow's less-prescriptive numbering).

Add `release/<version>` to [naming-conventions/branches.md](../naming-conventions/branches.md) if you adopt this pattern.

## Merge Policy
- Always submit branches via Pull Requests — no direct pushes to `main`/`develop` (enforced via branch protection or, preferably, [rulesets](./github-standards.md#rulesets-preferred-over-classic-branch-protection)).
- Use **squash-and-merge** to keep a clean, readable commit history on `main`/`develop`. (Note: the original git-flow model instead recommends `--no-ff` merges precisely so a feature's full commit history, and the fact that it *was* a feature branch, is preserved — squash-and-merge trades that history away for a simpler log. Pick whichever your team values more; both are documented here deliberately.)
- `hotfix/<name>` branches merge to **both** `main` (immediate production patch) and `develop` (so the fix isn't lost on the next release) — **or** into an in-progress `release/<version>` branch instead of `develop` directly, if one currently exists (per the original git-flow model), since it will reach `develop` anyway once that release branch finishes.

## Alternative: Trunk-Based Development

If your team ships frequently with strong CI and feature flags, consider trunk-based development instead — this is what git-flow's own author now recommends for continuously-delivered software (see the reflection quoted above):
- Short-lived branches (hours to a couple of days) merged directly to `main`.
- Incomplete work ships behind feature flags rather than staying on a long-lived branch.
- Reduces merge conflicts and integration debt; pairs well with elite [DORA metrics](https://dora.dev/) targets (see [standards/engineering-standards.md](./engineering-standards.md)).
- Trade-off: requires disciplined CI (every commit to `main` must be deployable) and feature-flag infrastructure.
- No `develop` branch, no release branches — every commit on `main` is potentially shippable. This is close to [GitHub flow](https://guides.github.com/introduction/flow/), the simpler model nvie's reflection points to.

Pick one model per repository and apply it consistently — mixing models within a single repo defeats the purpose of having a convention.

## Attribution Note

The "Origin & Attribution" and "Optional: Release Branches" sections above quote and adapt material from Vincent Driessen's [*A successful Git branching model*](https://nvie.com/posts/a-successful-git-branching-model/), licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) — **not** this repository's blanket [CC BY 4.0 docs license](../LICENSE-DOCS). Per CC BY-SA's ShareAlike clause, if you adapt *this specific section* further, your adaptation of it must likewise be shared under CC BY-SA 4.0 (or later); the rest of this repository's documentation remains under CC BY 4.0 as stated in [LICENSE-DOCS](../LICENSE-DOCS).
