# Project Setup Template (Folder Structure)

A generic starting folder structure for a new codebase (as opposed to a new *playbook*, which is what this repo itself is). Adapt names to your stack's convention (e.g., `src/` vs. `lib/` vs. `app/`).

```
my-project/
├── .github/                 # CI workflows, issue/PR templates, CODEOWNERS (copy from this repo's .github/)
├── docs/                    # Project-specific docs (architecture, how-to-run)
├── src/                     # Application source code
│   ├── <module-1>/
│   └── <module-2>/
├── tests/                   # Mirrors src/ structure
├── scripts/                 # One-off/maintenance scripts (see code-starter/scripts/)
├── .editorconfig            # Copy from this repo's root
├── .gitignore                # Copy from this repo's root, trim to your stack
├── .env.example              # Copy from code-starter/.env.example
├── CHANGELOG.md
├── CONTRIBUTING.md           # Or .github/CONTRIBUTING.md
├── LICENSE
├── README.md                 # Start from templates/readme-template.md
└── <stack-specific manifest> # package.json / pyproject.toml / go.mod / Cargo.toml
```

## Bootstrap Steps
0. **Decide monorepo vs. polyrepo first** if this is a new multi-component system — see [standards/repository-architecture.md](../standards/repository-architecture.md). Changing your mind later is expensive.
1. Set up the actual GitHub repository per [standards/github-repo-setup.md](../standards/github-repo-setup.md) (security features, rulesets, CODEOWNERS) — or use **"Use this template"** on GitHub to get this repo's scaffolding at once (see [README.md Quick Start](../README.md#quick-start)), then copy `.editorconfig`, `.gitignore`, `LICENSE`, `CODE_OF_CONDUCT.md`, `SECURITY.md` into the new repo if starting manually.
2. Create `src/` (or your stack's equivalent) and `tests/` mirroring it.
3. Fill in `README.md` from [readme-template.md](./readme-template.md).
4. Wire up `.github/workflows/ci.yml` for your actual stack (see [templates/ci-cd-template.md](./ci-cd-template.md)).
5. Set naming per [naming-conventions/](../naming-conventions) from day one — renaming later is disruptive.
