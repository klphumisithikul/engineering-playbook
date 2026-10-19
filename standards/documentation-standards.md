# Documentation Standards

Authoritative detail behind [README.md § Documentation Standards](../README.md#documentation-standards).

## What to Update, and When

| Change type | Update |
|---|---|
| New feature or behavior change | `README.md` (if user-facing), relevant docstrings/inline comments, [CHANGELOG.md](../CHANGELOG.md) |
| New architecture/design decision | New ADR in [governance/architecture-decision-records/](../governance/architecture-decision-records) |
| New or changed workflow/process | [.github/CONTRIBUTING.md](../.github/CONTRIBUTING.md), and the relevant file in [workflows/](../workflows) |
| New standard or convention | The relevant file under [standards/](.) or [naming-conventions/](../naming-conventions), summarized back into `README.md` |
| Bug fix | Inline comment if the fix isn't self-evident; test coverage counts as documentation of expected behavior |

## Writing Guidelines

- **Lead with why, then what, then how.** Reviewers and future readers care more about intent than mechanics.
- **Keep README.md as the entry point, not the encyclopedia.** Detailed standards live in dedicated files (this repo's own `/governance`, `/standards`, `/naming-conventions`) and README links out — this keeps README skimmable while the detail stays discoverable.
- **Prefer tables and checklists over prose** for anything prescriptive (standards, checklists, comparisons).
- **Code comments explain "why," not "what.**" If a comment just restates the code, delete it; if it's non-obvious, keep it (see global code style guidance — don't add comments that merely narrate the next line).
- **Keep examples runnable.** A code block that can't actually be copy-pasted and run erodes trust in the whole document.

## Markdown Conventions

- One `#` H1 per file, matching the file's purpose.
- Relative links between repo files (so they work both on GitHub and when cloned locally).
- Use GitHub's [alert syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts) (`> [!NOTE]`, `> [!WARNING]`, etc.) sparingly, for things that genuinely need to stand out.

## Keeping Docs in Sync

For multi-team repos, treat `.github/CONTRIBUTING.md` as the source of truth for contributor-facing process, and summarize into `README.md` for visibility — see the "Maintaining Documentation" workflow already defined in [.github/CONTRIBUTING.md](../.github/CONTRIBUTING.md#maintaining-documentation) for the full sync protocol (including, optionally, syncing to Confluence/wikis for non-technical stakeholders).
