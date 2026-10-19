# Risk Management

A lightweight risk process for the "Maintenance" phase of [SDLC.md](./SDLC.md) (and ongoing risk review during Planning/Design).

## Risk Categories

| Category | Examples | Primary mitigation docs |
|---|---|---|
| **Security** | Vulnerable dependencies, exposed secrets, missing auth checks | [governance/security-practices.md](./security-practices.md), [SECURITY.md](../SECURITY.md), `.github/workflows/security.yml` |
| **Operational** | Deploy failures, missing rollback plan, no monitoring | [standards/ci-cd-standards.md](../standards/ci-cd-standards.md), [workflows/incident-response-workflow.md](../workflows/incident-response-workflow.md) |
| **Technical Debt** | Outdated dependencies, inconsistent naming, low test coverage | [standards/coding-standards.md](../standards/coding-standards.md), `.github/dependabot.yml` |
| **Compliance/Licensing** | Incompatible dependency licenses, missing attribution | [README.md § Licensing](../README.md#licensing), `.github/workflows/dependency-review.yml` |
| **Knowledge/People** | Single point of failure (one person owns critical context) | [CODEOWNERS](../.github/CODEOWNERS) (require ≥2 owners per critical path), onboarding docs in [docs/onboarding.md](../docs/onboarding.md) |

## Simple Risk Scoring

Score = **Likelihood (1-3) × Impact (1-3)**, giving a 1-9 scale:

| Score | Severity | Response SLA |
|---|---|---|
| 7-9 | Critical | Immediate — block release, page on-call (see [SECURITY.md](../SECURITY.md) for vuln SLAs) |
| 4-6 | High | Fix within the current sprint/iteration |
| 2-3 | Medium | Scheduled into near-term backlog |
| 1 | Low | Tracked, revisit opportunistically |

## Process

1. **Identify**: Anyone can flag a risk via a GitHub issue (tag `risk`) or during design review/ADR.
2. **Assess**: Maintainer or relevant Code Owner scores it using the table above.
3. **Decide**: Mitigate, accept, transfer (e.g., insurance/vendor contract), or avoid (don't build the risky thing).
4. **Track**: Log accepted risks and their owner/review date — don't let "accepted risk" mean "forgotten risk."
5. **Review**: Revisit open risks at a regular cadence (e.g., each release, or quarterly for long-lived risks).

## Dependency & Supply-Chain Risk

Automated by default in this template:
- `.github/dependabot.yml` — flags outdated/vulnerable dependencies.
- `.github/workflows/security.yml` — secret scanning (gitleaks) + filesystem vulnerability scanning (Trivy).
- `.github/workflows/dependency-review.yml` — blocks PRs introducing known-vulnerable or disallowed-license dependencies.

See [governance/security-practices.md](./security-practices.md) for the fuller security program this plugs into.
