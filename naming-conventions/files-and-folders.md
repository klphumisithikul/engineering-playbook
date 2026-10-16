# Files & Folder Naming

## Rules

- **Repositories**: `kebab-case`, descriptive, no abbreviations unless universally understood (e.g. `payment-service`, not `paysvc` or `PaymentService`).
- **Folders**: `kebab-case`, plural for collections (`templates/`, `workflows/`), singular for a single concept's home (`governance`/).
- **Documentation Files**: `kebab-case.md`, except files GitHub/tooling specfically recognizes in a fixed casing: `README.md`, `LICENSE`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `CHANGELOG.md`, `CODEOWNERS` - keep those exact names/casing so GitHub renders/links them automatically.
- **Files-in-the-blank Templates are Never Literally named `README.md`** (or any other fixed name from the rule above), even when the item they produce *is* a `README.md` once copied. Use `<topic>-folder-name.md` (e.g., [templates/readme-templates.md](../templates/readme-templates.md)) instead of [templates/README.md] to avoid problems (1) GitHub auto-rendering it as if i described the folder it lives in, and a reader mistakens "a template for X" for "X itself", and (2) a folder's own `README.md` (e.g., [templates/README.md]) is distinguishable from the main repo's `README.md`. See [docs/architecture.md](./docs/architecture.md) for why the docs are organized this way (one authoritative home per topic).