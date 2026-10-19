# How to "Run" This Repo

There's no application here to start — this repo is documentation and scaffolding. "Running" it means one of two things:

## 1. Using It as a Template (most common)
```bash
# On GitHub: click "Use this template" → "Create a new repository"
# Or, locally:
git clone <this-repo-url> my-new-project
cd my-new-project
git remote set-url origin <your-new-repo-url>
bash code-starter/scripts/setup.sh   # or scripts/setup.ps1 on Windows
```
Then follow [README.md § Quick Start](../README.md#quick-start) to replace placeholders and wire up your actual stack.

## 2. Previewing/Editing the Docs Themselves
These are plain Markdown files — any editor renders them, and GitHub renders them automatically on the web. There's no build step or static site generator required. If you want a live local preview with working relative links, any Markdown preview extension in your editor (VS Code's built-in preview, for example) is sufficient.

## 3. Validating the Starter Pipelines Locally
- GitHub Actions: use [`act`](https://github.com/nektos/act) to run `.github/workflows/*.yml` locally without pushing.
- GitLab CI: use `gitlab-ci-local` or GitLab's own `glab ci lint`/pipeline simulation tools to validate `.gitlab-ci.yml` syntax before pushing.

Neither is required — pushing a branch and letting the real CI run is simpler for most changes.
