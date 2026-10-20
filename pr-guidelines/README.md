# Pull Request Guidelines

This is the **policy** layer — what must be true for a PR to be mergeable, and the SLAs around it. For the **how-to** (step-by-step commands, templates to use), see [.github/CONTRIBUTING.md § Pull Request Workflow](../.github/CONTRIBUTING.md#pull-request-workflow) and [README.md § Pull Request Workflow](../README.md#pull-request-workflow).

## Required Before Opening a PR
- [ ] Branch follows [naming-conventions/branches.md](../naming-conventions/branches.md).
- [ ] Commits follow [standards/commit-message-guidelines.md](../standards/commit-message-guidelines.md).
- [ ] Lint, format, and tests pass locally.
- [ ] `.github/pull_request_template.md` is filled out completely (not left as placeholder text).

## Size & Scope
- Prefer PRs under **~500 lines of diff**. Larger changes should be split, or clearly justified in the description (e.g., generated code, large data file, mechanical rename).
- One logical change per PR. "While I was in there, I also fixed..." belongs in a separate PR.
- This isn't an arbitrary number — see [Industry-Recognized Standards § Small CLs](#small-prs-small-cls) below for why smaller is backed by more than preference.

## Review Requirements
| Requirement | Default |
|---|---|
| Minimum reviewers | 2 (per [.github/CONTRIBUTING.md](../.github/CONTRIBUTING.md)) |
| Required reviewers | Auto-requested via [.github/CODEOWNERS](../.github/CODEOWNERS) based on paths touched |
| Required status checks | lint, test, build, security scan (see `.github/workflows/`) |
| Merge method | Squash-and-merge |
| Review SLA | First response within **1 business day** — see [Speed of Review](#speed-of-review) below |

## Review Checklist (for reviewers)
- Correctness: does it do what it claims, including edge cases?
- Tests: are there tests for new/changed behavior? (See [standards/coding-standards.md](../standards/coding-standards.md).)
- Security: any new input handling, secrets, or dependencies? (See [governance/security-practices.md](../governance/security-practices.md).)
- Documentation: does this change require a doc update? (See [standards/documentation-standards.md](../standards/documentation-standards.md).)
- Naming: does new code/files/branches follow [naming-conventions/](../naming-conventions)?
- Comments follow the [Conventional Comments](#review-comment-format-conventional-comments) format below, so the author knows what's blocking vs. optional at a glance.

## Industry-Recognized Standards

This process is built on two widely-adopted, publicly documented standards rather than invented from scratch — citing them so the "why" behind the rules above is traceable.

### The Approval Standard

From Google's [Engineering Practices documentation](https://google.github.io/eng-practices/review/reviewer/standard.html) ("The Standard of Code Review," CC BY 3.0) — the standard most of the industry's own internal review guidelines trace back to:

> In general, reviewers should favor approving a CL [change] once it is in a state where it definitely improves the overall code health of the system being worked on, even if the CL isn't perfect... There is no such thing as "perfect" code — there is only better code.

In practice: don't block a PR over nitpicks or stylistic preference once it's a net improvement and meets this repo's standards. Leave non-blocking suggestions as non-blocking (see Conventional Comments below) rather than withholding approval over them.

### Speed of Review

From the same source, [Speed of Code Reviews](https://google.github.io/eng-practices/review/reviewer/speed.html): "One business day is the maximum time it should take to respond to a code review request." Slow reviews don't just delay one PR — they compound: they discourage small, frequent PRs (see below), increase pressure to merge under-reviewed code, and are the single biggest driver of contributor frustration with the review process. This is why this repo's review SLA (above) is 1 business day, not "whenever."

### Small PRs ("Small CLs")

From [Small CLs](https://google.github.io/eng-practices/review/developer/small-cls.html): small, self-contained PRs are reviewed faster, reviewed more thoroughly, less likely to introduce bugs, less wasted work if rejected, easier to merge, easier to design well, and simpler to roll back. A reviewer has standing to reject a PR for being too large on that basis alone, independent of whether the content is otherwise correct.

### Review Comment Format (Conventional Comments)

Pairs with [standards/commit-message-guidelines.md](../standards/commit-message-guidelines.md) (which standardizes *commit* messages) — [Conventional Comments](https://conventionalcomments.org/) (CC BY 3.0) standardizes *review comments* so authors can tell blocking feedback from optional feedback at a glance, and comments become greppable:

```
<label> [decorations]: <subject>
```

| Label | Meaning |
|---|---|
| `praise:` | Highlight something positive. Leave at least one per review — but don't fake it. |
| `nitpick:` (or `nit:`) | Trivial, preference-based; non-blocking by nature. |
| `suggestion:` | Propose a specific improvement; say what and why. |
| `issue:` | A specific problem with the subject; pair with a `suggestion:` where possible. |
| `question:` | You have a concern but aren't sure it's valid — ask rather than assert. |
| `thought:` | A non-blocking idea that came up while reviewing; doesn't require action. |
| `chore:` | A small required task before acceptance (e.g., "run the migration script"). |
| `note:` | Non-blocking — something worth flagging, no action required. |

Common decorations (comma-separated, in parentheses): `(blocking)`, `(non-blocking)`, `(if-minor)` — e.g. `issue (non-blocking): this will leak a connection under X, but it's pre-existing — follow-up PR is fine.`

## Escalation
If a PR is blocked (disagreement, no reviewer response, unclear requirement), see [.github/CONTRIBUTING.md § Need Help?](../.github/CONTRIBUTING.md#need-help) and [governance/governance-model.md § Exceptions](../governance/governance-model.md#exceptions). The "Resolving Conflicts" guidance in Google's [Standard of Code Review](https://google.github.io/eng-practices/review/reviewer/standard.html) applies well here too: try to reach consensus directly first, escalate to a maintainer/tech lead only if that fails — don't let a PR sit unresolved indefinitely.

## Attribution

The "Industry-Recognized Standards" section above quotes and adapts:
- Google's [Engineering Practices documentation](https://github.com/google/eng-practices) ("The Standard of Code Review," "Speed of Code Reviews," "Small CLs") — licensed [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/).
- [Conventional Comments](https://conventionalcomments.org/) — licensed [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/).

Both are attribution-only (no ShareAlike), so unlike the git-flow material in [standards/branching-strategy.md](../standards/branching-strategy.md), this section is compatible with this repo's own [CC BY 4.0 docs license](../LICENSE-DOCS) — CC BY 3.0 content may be used under the terms of a later Creative Commons BY version per CC's own license-compatibility guidance, provided attribution to the original authors (Google; Conventional Comments) is retained, as it is above.
