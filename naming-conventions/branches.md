# Branch Naming

Pairs with [standards/branching-strategy.md](../standards/branching-strategy.md) (the policy for *when* to use each branch type) — this file covers *how to name* them.

## Pattern
```
<type>/<short-kebab-case-description>
```

| Type | Example |
|---|---|
| `feature/` | `feature/add-logging`, `feature/api-integration` |
| `bugfix/` | `bugfix/fix-off-by-one`, `bugfix/fix-regression-error` |
| `experiment/` | `experiment/improve-performance` |
| `hotfix/` | `hotfix/fix-crash-bug`, `hotfix/db-connection-fail` |
| `release/` *(optional, see below)* | `release/1.2`, `release/2.0` |

### `release/<version>` (optional)

Only needed if you've adopted the full git-flow release-branch pattern described in [standards/branching-strategy.md § Optional: Release Branches](../standards/branching-strategy.md#optional-release-branches-full-git-flow-pattern), originally from Vincent Driessen's [*A successful Git branching model*](https://nvie.com/posts/a-successful-git-branching-model/) (nvie.com, 2010; CC BY-SA). Name it after the version it's stabilizing — not a description — since the whole point of the branch is "becoming version X.Y":
```
release/1.2
release/2.0
```

## Rules
- Lowercase, hyphen-separated — never spaces, underscores, or camelCase.
- Keep it short but specific: `fix/bug` tells you nothing; `bugfix/fix-off-by-one` does.
- Include a ticket/issue number if your team tracks one: `feature/PROJ-456-api-integration`.
- Don't reuse a branch name after deletion for an unrelated change — it makes old PR links/discussions confusing.

