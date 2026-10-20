# Commit Message Guidelines

Authoritative detail behind the commit-style mention in [README.md § GitHub Standards](../README.md#github-standards) and [.github/CONTRIBUTING.md § Git Standards](../.github/CONTRIBUTING.md#git-standards).

## Format: Conventional Commits

```
<type>(<scope>): <short imperative summary, ≤ 50 chars>

<body, wrapped at ~72 chars, explaining WHY the change was made>

<footer: Closes #123, BREAKING CHANGE: ...>
```

Follow [Conventional Commits 1.0.0](https://www.conventionalcommits.org/).

### Types
| Type | Use for | SemVer effect |
|---|---|---|
| `feat` | A new feature | Minor bump |
| `fix` | A bug fix | Patch bump |
| `docs` | Documentation only | None |
| `style` | Formatting, whitespace (no logic change) | None |
| `refactor` | Code change that neither fixes a bug nor adds a feature | None |
| `perf` | Performance improvement | Patch bump (usually) |
| `test` | Adding/correcting tests | None |
| `build` | Build system or external dependencies | None |
| `ci` | CI configuration/scripts | None |
| `chore` | Other changes that don't modify src/test files | None |
| `BREAKING CHANGE:` footer (any type) | Backwards-incompatible change | Major bump |

### Examples
```
feat(api): add endpoint for retrieving user profiles
fix(model): resolve timeout issue in data processing
docs(readme): clarify branching strategy
refactor(auth): extract token validation into its own module

BREAKING CHANGE: `GET /v1/users` now returns paginated results instead of a flat array.
```

## Why This Matters

This isn't just style — it drives automation in this template:
- **Changelog generation**: entries in [CHANGELOG.md](../CHANGELOG.md) should map cleanly from commit types.
- **Version bumps**: per [Semantic Versioning 2.0.0](https://semver.org/) — `fix` → `PATCH`, `feat` → `MINOR`, `BREAKING CHANGE` → `MAJOR`.
- **Automated enforcement**: `.github/workflows/conventional-commits.yml` lints PR titles/commits against this format.

## Enforcement

`.github/workflows/conventional-commits.yml` runs on every PR. If your commit history is messy, you can still land a clean, correctly-typed PR *title* — many teams enforce the convention at the PR-title level and squash-merge, so the messy intermediate commits never reach `main`/`develop`.
