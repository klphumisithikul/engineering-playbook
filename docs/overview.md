# Docs Index
The "wiki inside the repo." Start here: then follow links out to the authoritative source for whatever topic you need. This is a living document, so if you see something missing or out-of-date, please submit a PR.

## By Purpose
| I want to... | Go to |
| --- | --- |
| Understand the lifecycle phases of this repo is organized around | [governance/SDLC.md](./governance/SDLC.md) |
| Know who approve what | [governance/governance-model.md](/governance/governance-model.md) |
| Find a coding/naming/branching/commit standard | [standards/](./standards), [naming-conventions/](./naming-conventions) |
| Start a new project from this template | [README.md & Quick Start](./README.md#quick-start), [templates/project](./templates/project-setup-template.md) |
| Set up a brand-new GitHub repository to follow industry standards | [standards/github-repo-setup.md](./standards/github-repo-setup.md) |
| Decide monorepo vs. polyrepo | [standards/repository-architecture.md](./standards/repository-architecture.md) |
| Fill out a PR, issue, or ADR | [.github/pull_request_template.md](./.github/pull_request_template.md), [.github/ISSUE_TEMPLATE/](./.github/ISSUE_TEMPLATE/), [governance/architecture-decision-records/](./governance/architecture-decision-records) |
| Know how CI/CD and deployment works | [standards/ci-cd-standards.md](./standards/ci-cd-standards.md), [standards/gitops-standards.md](./standards/gitops-standards.md) |
| Copy ready-to-use config into a new repo | [code-starter/](./code-starter) |
| Follow a day-to-day workflow (review, release, incident, etc.) | [workflows/](./workflows) |
| Report a security vulnerability | [SECURITY.md](./SECURITY.md) |
| Onboard to **this repo** specifically | [docs/onboarding.md](./docs/onboarding.md) |
| Troubleshoot a problem using this template | [docs/troubleshooting.md](./docs/troubleshooting.md) |
| "Run" this repo (it has no app - here's what that means) | [docs/how-to-run-repo.md](./docs/how-to-run-repo.md) |

## Repository Map
```
engineering-playbook/
├── .github/                Automation GitHub reads directly (workflows, issue/PR templates, CODEOWNERS)
├── governance/             SDLC phases, decision rights, risks, security programs, ADRs
├── standards/              Coding/branching/commit/CI-CD/docker/gitops/GitHub-setup standards
├── naming-conventions/     Files, branches, variables, infra naming rules
├── pr-guidelines/          PR policy (size, review SLAs, checklists, industry standards)
├── templates/              Fill-in-the-blank docs for new projects (README, architecture, API design, testing, onboarding, etc.)
├── workflows/              Human process docs (code review, release, incident response)
├── code-starter/           Copy-paste config for a brand-new repo (.env.example, pre-commit, setup scripts)
├── docs/                   You are here ── the index/wiki
└── README.md               Entry point: links to all of the above
```

See [docs/architecture.md](./docs/architecture.md) for why the docs are organized this way (one authoritative home per topic).