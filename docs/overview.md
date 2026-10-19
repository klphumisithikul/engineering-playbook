# Docs Index

The "wiki inside the repo." Start here, then follow links out to the authoritative source for whatever you need.

## By Purpose

| I want to... | Go to |
|---|---|
| Understand the lifecycle phases this repo is organized around | [governance/SDLC.md](../governance/SDLC.md) |
| Know who approves what | [governance/governance-model.md](../governance/governance-model.md) |
| Find a coding/naming/branching/commit standard | [standards/](../standards), [naming-conventions/](../naming-conventions) |
| Start a new project from this template | [README.md § Quick Start](../README.md#quick-start), [templates/project-setup-template.md](../templates/project-setup-template.md) |
| Set up a brand-new GitHub repository to industry standard | [standards/github-repo-setup.md](../standards/github-repo-setup.md) |
| Decide monorepo vs. polyrepo | [standards/repository-architecture.md](../standards/repository-architecture.md) |
| Fill out a PR, issue, or ADR | [.github/pull_request_template.md](../.github/pull_request_template.md), [.github/ISSUE_TEMPLATE/](../.github/ISSUE_TEMPLATE), [governance/architecture-decision-records/](../governance/architecture-decision-records) |

| Know how CI/CD and deployment work | [standards/ci-cd-standards.md](../standards/ci-cd-standards.md), [standards/gitops-standards.md](../standards/gitops-standards.md) |
| Copy ready-to-use config into a new repo | [code-starter/](../code-starter) |
| Follow a day-to-day process (review, release, incident) | [workflows/](../workflows) |
| Report a security vulnerability | [SECURITY.md](../SECURITY.md) |
| Onboard to **this** repo specifically | [docs/onboarding.md](./onboarding.md) |
| Troubleshoot a problem using this template | [docs/troubleshooting.md](./troubleshooting.md) |
| "Run" this repo (it has no app — here's what that means) | [docs/how-to-run.md](./how-to-run.md) |

## Repository Map

```
engineering-playbook/
├── .github/            Automation GitHub reads directly (workflows, issue/PR templates, CODEOWNERS)
├── governance/          SDLC phases, decision rights, risk, security program, ADRs
├── standards/            Coding/branching/commit/CI-CD/docker/gitops standards (the detail)
├── naming-conventions/   Files, branches, variables, infra naming rules
├── pr-guidelines/        PR policy (size, review SLAs, checklists)
├── templates/            Fill-in-the-blank docs for new projects (README, architecture, API design...)
├── workflows/            Human process docs (code review, release, incident response)
├── code-starter/         Copy-paste config for a brand-new repo (.env.example, pre-commit, setup scripts)
├── docs/                 You are here — the index/wiki
└── README.md             Entry point: links to all of the above
```

See [docs/architecture.md](./architecture.md) for the reasoning behind this structure.
