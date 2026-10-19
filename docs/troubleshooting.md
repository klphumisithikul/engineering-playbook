# Troubleshooting

Common issues when using this repo as a template or playbook.

## "I used 'Use this template' but CI is failing immediately"
Expected — the starter workflows (`.github/workflows/ci.yml`, `build.yml`) ship with `echo "TODO..."` placeholders instead of real lint/test/build commands. Uncomment and fill in the block matching your stack (see [templates/ci-cd-template.md](../templates/ci-cd-template.md)), or the jobs will "pass" trivially without doing anything.

## "CODEOWNERS review requests aren't working"
`.github/CODEOWNERS` ships with placeholder teams (`@your-org/maintainers`, etc.). GitHub silently ignores CODEOWNERS entries that reference a team/user without access to the repo — replace the placeholders with real usernames/teams that actually have repo access.

## "Which branching model should I actually use?"
See [standards/branching-strategy.md](../standards/branching-strategy.md): the default `develop`-based model (git-flow-inspired) for versioned software, or trunk-based/GitHub-flow for continuously-delivered software. Don't mix the two within one repo.

## "The GitLab pipeline and GitHub Actions workflows seem to duplicate each other"
That's intentional — `.gitlab-ci.yml` and `.github/workflows/*.yml` are platform-specific equivalents of the same pipeline, documented together in [standards/ci-cd-standards.md](../standards/ci-cd-standards.md). Use whichever matches your actual Git host; delete the other.

## "Where do I put [X]?"
See the table in [docs/architecture.md](./architecture.md) — every kind of content has one designated home.

## "A link in these docs is broken"
Open a PR fixing it (small, obviously-correct fixes like this don't need an issue first) — see [.github/CONTRIBUTING.md](../.github/CONTRIBUTING.md).
