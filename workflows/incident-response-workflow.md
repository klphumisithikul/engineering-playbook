# Incident Response Workflow

What happens when production breaks. Pairs with [governance/risk-management.md](../governance/risk-management.md) (severity scoring) and [SECURITY.md](../SECURITY.md) (if the incident is a security vulnerability specifically).

## Steps

1. **Detect**: via monitoring/alerting (see [standards/engineering-standards.md § CI/CD & Observability](../standards/engineering-standards.md#cicd--observability)) or a user/internal report.
2. **Triage & score**: assign severity using [governance/risk-management.md](../governance/risk-management.md)'s Likelihood × Impact scale.
3. **Declare & communicate**: for Critical/High severity, notify stakeholders immediately (status page, Slack/Teams channel) — don't let people discover an outage on their own.
4. **Mitigate first, root-cause later**: roll back, flip a feature flag, or scale resources to stop the bleeding before doing a full investigation. See [standards/gitops-standards.md](../standards/gitops-standards.md) for rollback via Argo CD (`syncPolicy`/previous revision).
5. **Fix via `hotfix/<name>`** branch if a code change is required, per [standards/branching-strategy.md](../standards/branching-strategy.md) — merges to both `main` and `develop`.
6. **Resolve & confirm**: verify the mitigation/fix in production; close out communications.
7. **Postmortem**: for Critical/High incidents, write a blameless postmortem — what happened, why, what we're changing (process, code, or monitoring) to prevent recurrence. Link it from an ADR in [governance/architecture-decision-records/](../governance/architecture-decision-records) if it changes an architectural decision.

## Security Incidents

If the incident is (or might be) a security vulnerability — follow [SECURITY.md](../SECURITY.md) instead of/in addition to this workflow: do not discuss details in public channels/issues until a fix is available.

## Severity → Response Mapping

| Severity (from risk-management.md) | Response |
|---|---|
| Critical | Immediate, all-hands, status page update |
| High | Same business day, fix within the sprint |
| Medium/Low | Scheduled into backlog, no incident declaration needed |
