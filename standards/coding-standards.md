# Coding Standards

Language-agnostic baseline. For this template's current Python-flavored specifics (`black`, `flake8`, `pytest`, 80% coverage target), see [.github/CONTRIBUTING.md § Code, Git, and Testing Standards](../.github/CONTRIBUTING.md#code-git-and-testing-standards) — swap those tool names for your stack's equivalents (see table below) and keep the underlying principles.

## Principles (apply regardless of language)
- **Readability over cleverness.** Code is read far more often than it's written.
- **Small units.** Prefer small functions/modules with a single responsibility over large ones with many branches.
- **Low cyclomatic complexity.** If a function needs a paragraph to explain its branching, split it.
- **Fail loudly in development, gracefully in production.** Don't swallow errors silently; don't crash on recoverable input.
- **No dead code.** Delete unused code rather than commenting it out — git history remembers it for you.

## Formatting & Linting by Stack

| Stack | Formatter | Linter | Test runner |
|---|---|---|---|
| Python | `black` | `flake8` / `ruff` | `pytest` |
| Node/TypeScript | `prettier` | `eslint` | `jest` / `vitest` |
| Go | `gofmt` | `golangci-lint` | `go test` |
| Rust | `rustfmt` | `clippy` | `cargo test` |

Whichever you use, wire it into:
- Pre-commit hooks (see [code-starter/.pre-commit-config.yaml](../code-starter/.pre-commit-config.yaml))
- CI (`.github/workflows/ci.yml`'s `lint`/`test` jobs — uncomment the relevant stack block)

## Testing Standards
- Add tests for any significant change; validate edge cases, not just the happy path.
- Target meaningful coverage (this template's default guidance: **≥80%**) — but treat coverage as a floor/signal, not a goal in itself. 100% coverage with no assertions on behavior is worse than 70% coverage that actually tests behavior.
- Categorize tests (unit / integration / end-to-end) and keep the fast ones (unit) running on every commit; slower ones (integration/e2e) can run less frequently if needed.

## Naming

See [naming-conventions/variables-and-code.md](../naming-conventions/variables-and-code.md) for identifier naming; [naming-conventions/files-and-folders.md](../naming-conventions/files-and-folders.md) for file/folder naming.
