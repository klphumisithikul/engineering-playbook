# Architecture Decision Records (ADRs)

An ADR captures a single significant architecture/design decision, why it was made, and what alternatives were rejected — so future contributors don't have to re-derive (or accidentally re-litigate) it.

## When to Write One

Write an ADR for decisions that are costly to reverse, such as: choice of database/datastore, public API contract shape, authentication approach, major dependency/framework adoption, or a deviation from a standard in this repo (see [governance/governance-model.md § Exceptions](../governance-model.md#exceptions)).

Don't write one for routine implementation details — that's just code + commit message.

## Process

1. Copy [`0000-adr-template.md`](./0000-adr-template.md) to `NNNN-short-title.md` (next sequential number, zero-padded 4 digits).
2. Fill it out and open a PR.
3. Discuss in the PR; update the ADR based on feedback.
4. Once merged, the decision's status becomes `Accepted`. If later reversed, don't delete the old ADR — add a new one and mark the old one `Superseded by NNNN`.

## Index

| ADR | Title | Status |
|---|---|---|
| [0000](./0000-adr-template.md) | Template (not a real decision) | n/a |

Add a row here each time you merge a new ADR.
