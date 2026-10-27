# Workflows (Process Docs)

> **Not to be confused with [`.github/workflows/`](../.github/workflows)**, which holds the *automated* GitHub Actions pipeline definitions (YAML that actually runs on GitHub's servers). This `/workflows` folder holds **human process** documentation — the steps people follow, not code that executes. GitHub only ever reads `.github/workflows/*.yml`; this folder is purely for people.

| Doc | Covers |
|---|---|
| [code-review-workflow.md](./code-review-workflow.md) | How a PR moves from "opened" to "merged" |
| [release-workflow.md](./release-workflow.md) | How a version gets cut, tagged, and shipped |
| [incident-response-workflow.md](./incident-response-workflow.md) | What happens when production breaks |

These map onto the "Deployment" and "Maintenance" phases of [governance/SDLC.md](../governance/SDLC.md).
