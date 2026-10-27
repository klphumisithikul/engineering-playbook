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

### PR Labels

This repo's automation (`.github/labeler.yml`, `.github/workflows/auto-label.yml`, `.github/workflows/stale.yml`) currently applies six labels: `documentation`, `ci-cd`, `dependencies`, `security` (path-based, auto-applied on every PR open/sync) and `stale`, `pinned` (lifecycle, from the stale bot). There's no broader taxonomy defined beyond that today — if you add more labels, follow the practices below rather than improvising ad hoc ones.

GitHub's own [Managing labels](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels) guidance (CC BY 4.0) is the baseline: keep the label set small, give each one a clear and specific name/description, and use color consistently (e.g., one hue per category) so the set stays scannable instead of sprawling — label sprawl (dozens of overlapping, undocumented labels) is a common anti-pattern it explicitly warns against.

Common categories used across engineering orgs, layered on top of what's already automated here:

| Category | Examples | Notes |
|---|---|---|
| Type | `bug`, `feature`, `chore`, `refactor` | Mirrors this repo's own branch-prefix convention in [naming-conventions/branches.md](../naming-conventions/branches.md) (`feature/`, `bugfix/`, `experiment/`, `hotfix/`) — keep the two in sync if you add these. |
| Status | `needs-review`, `blocked`, `do-not-merge`, `work-in-progress` | Signals where a PR stands beyond CI's pass/fail; useful for draft PRs or ones blocked on an external dependency. |
| Priority/Severity | `priority:high`, `severity:critical` | More common on issue trackers than PRs; only worth adding if triage volume justifies the overhead. |
| Size | `size/XS` ... `size/XL` | Auto-computed from diff size (e.g. via a GitHub Action like `pascalgn/size-label-action`). Reinforces the [Size & Scope](#size--scope) policy above by making oversized PRs visible at a glance instead of relying on reviewers to notice. |

None of these are implemented in this repo today — adding them means extending `.github/labeler.yml` (or repo label settings), not just writing about them. Whatever subset you adopt, document the label → meaning mapping here so it doesn't live only in someone's head.

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
- GitHub's [Managing labels](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels) documentation (PR Labels section) — [docs.github.com content is licensed CC BY 4.0](https://github.com/github/docs/blob/main/LICENSE-DOCS).

All three are attribution-only (no ShareAlike), so unlike the git-flow material in [standards/branching-strategy.md](../standards/branching-strategy.md), this section is compatible with this repo's own [CC BY 4.0 docs license](../LICENSE-DOCS) — CC BY 3.0 content may be used under the terms of a later Creative Commons BY version per CC's own license-compatibility guidance, provided attribution to the original authors (Google; Conventional Comments; GitHub) is retained, as it is above.
