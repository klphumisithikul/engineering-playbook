# File & Folder Naming

## Rules
- **Repositories**: `kebab-case`, descriptive, no abbreviations unless universally understood. e.g. `payment-service`, not `paysvc` or `PaymentService`.
- **Folders**: `kebab-case`, plural for collections (`templates/`, `workflows/`), singular for a single concept's home (`governance/`).
- **Documentation files**: `kebab-case.md`, except files GitHub/tooling specifically recognizes in a fixed casing: `README.md`, `LICENSE`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `CHANGELOG.md`, `CODEOWNERS` — keep those exact names/casing so GitHub renders/links them automatically. These aren't just a style choice: GitHub's platform looks for these exact filenames (e.g. in the repo's Insights → Community Standards checklist and the "Add file" template picker) to detect and link the corresponding doc, so renaming `CODE_OF_CONDUCT.md` to `CODE-OF-CONDUCT.md` would silently break that detection even though the content is unchanged.
- **Fill-in-the-blank templates are never literally named `README.md`** (or any other fixed name from the rule above), even when the thing they produce *is* a `README.md` once copied. Use `<topic>-template.md` instead — e.g. [templates/readme-template.md](../templates/readme-template.md) is the fill-in-the-blank doc that *becomes* a new project's `README.md`; it isn't one itself. This avoids two problems: GitHub auto-rendering it as if it described the folder it lives in, and a reader mistaking "a template for X" for "X itself." A folder's own `README.md` (e.g. [templates/README.md](../templates/README.md)) is a different thing again — a real, in-place index describing that folder, not a copy-and-rename artifact. See [docs/architecture.md](../docs/architecture.md) for this same "one authoritative home per topic" principle applied more broadly.
- **Source files**: follow the language/ecosystem convention rather than this doc's default, since tooling often depends on it:
  - Python modules: `snake_case.py`
  - JS/TS: `camelCase.ts` for utilities, `PascalCase.tsx` for React components
  - Go: `snake_case.go` (idiomatic Go is actually lowercase, no underscores for most names: `handlers.go`)
- **Test files**: mirror the file under test with a suffix/prefix per ecosystem convention: `test_*.py`, `*.test.ts`, `*_test.go`.
- **Config files**: use the exact name the tool expects (`.eslintrc.json`, `.editorconfig`, `pyproject.toml`) — these are dictated by the tool, not this convention.

## Avoid
- Spaces in file/folder names (breaks shell scripting without quoting).
- Mixed casing inconsistently within the same directory level.
- Dates or version numbers baked into filenames (`report_final_v2_FINAL.md`) — use git history and tags/[CHANGELOG.md](../CHANGELOG.md) instead.
