# Governance Model

Defines who decides what, and what needs sign-off before it ships. Pair this with [SDLC.md](./SDLC.md) (the phases) and [CODEOWNERS](../.github/CODEOWNERS) (the enforcement mechanism).

## Roles & Responsibilities

| Role | Responsibilities | Where defined |
|---|---|---|
| **Maintainer** | Owns the repo/standard long-term; approves breaking changes; triages security reports | [.github/CONTRIBUTING.md § Maintainers](../.github/CONTRIBUTING.md#maintainers-and-contributors) |
| **Code Owner** | Required reviewer for files/paths they own | [CODEOWNERS](../.github/CODEOWNERS) |
| **Contributor** | Opens PRs/issues following templates and standards | [.github/CONTRIBUTING.md](../.github/CONTRIBUTING.md) |
| **Security Contact** | Receives and triages vulnerability reports privately | [SECURITY.md](../SECURITY.md) |
| **Release Manager** | Cuts releases, tags versions, publishes changelog | [workflows/release-workflow.md](../workflows/release-workflow.md) |

## Decision Rights (RACI, abbreviated)

| Decision | Responsible | Accountable | Consulted | Informed |
|---|---|---|---|---|
| Merge a standard PR | Author | Code Owner (CODEOWNERS) | Reviewers | Team |
| Change branching strategy / core standards | Maintainer | Maintainer | Team, Code Owners | All contributors |
| Accept a breaking change (major version bump) | Maintainer | Maintainer | Affected teams | All downstream consumers |
| Approve an exception to a standard | Maintainer | Maintainer | Requesting contributor | Team |

## Approval Gates

Mapped to the SDLC phases in [SDLC.md](./SDLC.md):

1. **Planning → Design**: Issue/RFC approved by a maintainer before implementation starts (for non-trivial changes).
2. **Design → Development**: Architecture Decision Record (ADR) accepted — see [architecture-decision-records/](./architecture-decision-records) — for changes affecting public interfaces, data models, or infra.
3. **Development → Testing**: PR opened, CI (`.github/workflows/ci.yml`) green, CODEOWNERS review requested automatically.
4. **Testing → Deployment**: Required status checks pass (lint, test, build, security scan — see [standards/ci-cd-standards.md](../standards/ci-cd-standards.md)); ≥2 reviewer approvals per [.github/CONTRIBUTING.md](../.github/CONTRIBUTING.md).
5. **Deployment → Maintenance**: Deployment observed (metrics/logs per [standards/engineering-standards.md](../standards/engineering-standards.md)); rollback plan exists.

## Exceptions

Standards exist to reduce decision fatigue, not to be dogma. If a standard genuinely doesn't fit a situation:
1. Document the exception and reasoning in the PR description.
2. Get explicit maintainer sign-off (not just a passing reviewer approval).
3. If the exception recurs, propose updating the standard itself via PR, following the same approval gates above.

## GitHub Organization & Enterprise Governance

The roles/gates above apply within a single repository. If this template is used inside a GitHub Organization or Enterprise (not a personal account), set these once at the org/enterprise level — per the California Department of Technology's published [GitHub Best Practices](https://webstandards.ca.gov/2023/04/19/github-best-practices/) (itself summarizing GitHub's own [Best practices for organizations](https://docs.github.com/en/organizations/collaborating-with-groups-in-organizations/best-practices-for-organizations) and [Best practices for enterprises](https://docs.github.com/en/enterprise-cloud@latest/admin/overview/best-practices-for-enterprises) docs):

- **Assign at least two organization owners.** Owners have full administrative access; a single owner is a single point of failure if they're unreachable.
- **Use teams, not individual permissions.** Assign repo access to teams; keep teams visible by default and reserve secret teams for genuinely sensitive cases; use nested teams for sub-groups.
- **Enforce two-factor authentication (2FA)** for every account accessing the organization — non-negotiable, independent of repo-level controls.
- **Use SAML SSO** if the organization is mostly private repos, to centralize identity/access through your IdP rather than per-account GitHub credentials.
- **Enable security features org-wide by default** (Dependabot, code scanning, secret scanning) rather than opting in per-repository — see [governance/security-practices.md](./security-practices.md) for the repo-level detail.
- **Restrict default `GITHUB_TOKEN` permissions** at the org level so individual workflows must explicitly opt into elevated permissions, not the reverse.
- **At the Enterprise level**: minimize the number of organizations (fewer orgs → better innersource visibility and discussion reach); keep repos organization-owned rather than user-owned (survives personnel changes, gets better admin/security tooling); use human-readable usernames if you control provisioning; periodically review and revoke stale access.

This governance layer is what makes the repository-level controls in [standards/github-repo-setup.md](../standards/github-repo-setup.md) actually hold — a repo's branch protection means little if organization owner access is sprawling and un-audited.
