# This Repo's "Architecture"

Not a software architecture (this repo ships no running code) — this explains why the *documentation* is organized the way it is, and the authoritative-source rule that keeps it from drifting out of sync.

## The One Rule

**Every piece of detailed guidance has exactly one authoritative home.** `README.md` is the entry point and gives a short summary of everything, but it links out rather than duplicating. If you need to update a standard, update it in its authoritative file — don't fork the explanation into README too, or the two will silently disagree within a few months.

| Kind of content | Authoritative home |
|---|---|
| Lifecycle phases, decision rights, risk, security program | [governance/](../governance) |
| Technical/process standards (coding, branching, commits, CI/CD, Docker, GitOps) | [standards/](../standards) |
| Naming rules | [naming-conventions/](../naming-conventions) |
| PR policy | [pr-guidelines/](../pr-guidelines) |
| Fill-in-the-blank starting documents | [templates/](../templates) |
| Day-to-day process sequences | [workflows/](../workflows) |
| Copy-paste config for a new repo | [code-starter/](../code-starter) |
| What GitHub itself reads (CI, issue/PR forms, ownership) | [.github/](../.github) |

## Why Split `standards/` from `naming-conventions/` from `pr-guidelines/` Instead of One Big File?

Smaller, single-purpose files are easier to: link to precisely (deep-link to one convention instead of "see the big standards doc, scroll to section 7"), own via CODEOWNERS at finer granularity, and keep in sync (a one-line naming tweak doesn't require touching an unrelated CI doc).

## Why Does `.github/CONTRIBUTING.md` Still Have Its Own Detailed Branching/PR Walkthroughs Instead of Just Linking to `standards/` and `pr-guidelines/`?

Deliberate exception: `.github/CONTRIBUTING.md` is the **how-to** (literal commands to run), while `standards/branching-strategy.md` and `pr-guidelines/README.md` are the **policy** (what's required and why). Both link to each other; neither fully subsumes the other. See [standards/documentation-standards.md](../standards/documentation-standards.md) for this distinction applied more generally.

## Adding Something New

1. Figure out which category above it belongs to.
2. Add it there, following that folder's existing file style.
3. Add one or two sentences (and a link) to `README.md` if it's significant enough that a first-time reader should know it exists.
4. Add it to the table in [docs/overview.md](./overview.md) if it changes how someone would navigate this repo.
