# Security Practices

This is the detailed security program. [README.md](../README.md#security) keeps a short summary and links here; [SECURITY.md](../SECURITY.md) is specifically the *vulnerability reporting* process (how to tell us about a problem), while this document is the *preventive* program (how we avoid problems in the first place).

## Guiding Framework

Follow the [OWASP Top 10](https://owasp.org/www-project-top-ten/) as the baseline threat model for anything handling user input, auth, or data storage, regardless of language/stack.

## Controls by SDLC Phase

| Phase | Control |
|---|---|
| **Planning/Design** | Threat-model new features that touch auth, payments, or PII in the ADR (see [architecture-decision-records/](./architecture-decision-records)). |
| **Development** | Secret-scanning pre-commit (recommended, see [code-starter/.pre-commit-config.yaml](../code-starter/.pre-commit-config.yaml)); never commit `.env` files (enforced via [.gitignore](../.gitignore)). |
| **Testing/CI** | `.github/workflows/security.yml` runs gitleaks (secrets) + Trivy (dependency/filesystem vulnerabilities) on every PR and weekly on a schedule. `.github/workflows/dependency-review.yml` blocks PRs introducing high/critical vulnerable dependencies. |
| **Deployment** | Signed/pinned container images and IaC (see [standards/docker-standards.md](../standards/docker-standards.md), [standards/gitops-standards.md](../standards/gitops-standards.md)); secrets injected via a vault/secret manager, never baked into images. |
| **Maintenance** | `.github/dependabot.yml` opens automated upgrade PRs; see [governance/risk-management.md](./risk-management.md) for triage SLAs. |

## Minimum Baseline Checklist

- [ ] No secrets, API keys, or credentials committed to the repo (`.env`, `*.pem`, `*.key` are gitignored by default).
- [ ] Dependencies are scanned (Dependabot + Trivy) and have no unresolved critical/high vulnerabilities.
- [ ] Branch protection requires passing status checks + review before merge (see [README.md](../README.md#project-resources)).
- [ ] Least-privilege access: CI tokens, GitHub Apps, and service accounts request only the scopes they need.
- [ ] Containers run as a non-root user with resource limits (see [standards/docker-standards.md](../standards/docker-standards.md)).
- [ ] A documented, tested path exists to report and respond to a real vulnerability — see [SECURITY.md](../SECURITY.md).

## GitHub Actions Hardening

Pulled from the California Department of Technology's published [GitHub Best Practices](https://webstandards.ca.gov/2023/04/19/github-best-practices/), itself summarizing GitHub's own [Security hardening for GitHub Actions](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions) guidance. Applies on top of the `.github/workflows/security.yml` scanning already in this template:

- **Pin third-party actions to a full-length commit SHA**, not just a version tag — tags can be moved/retargeted by the action's author (or an attacker who compromises their account); a SHA cannot.
- **Audit third-party action source code** before use, and keep actions up to date (treat them like any other third-party dependency — see [governance/risk-management.md](./risk-management.md)).
- **Restrict `GITHUB_TOKEN` permissions** to the minimum needed per workflow (`permissions:` block — already scoped minimally in this template's `.github/workflows/*.yml`), rather than relying on the broad default.
- **Use OpenID Connect (OIDC)** to authenticate to cloud providers (AWS/Azure/GCP) instead of long-lived cloud credentials stored as repo secrets.
- **Mitigate script injection**: never interpolate untrusted input (PR titles, issue bodies, branch names) directly into an inline `run:` script — pass it through an environment variable instead, or use an action rather than inline shell.
- **Never use structured data (JSON/XML/YAML) as a secret value** — GitHub's log redaction can't reliably redact a secret embedded inside a larger structured blob.
- **Register all secrets used in workflows** (via repo/org secrets), including ones *derived* from another secret at runtime — a derived value won't be auto-redacted in logs unless it's registered itself.
- **Avoid self-hosted runners on public repositories** — anyone can open a PR against a public repo and potentially run code on a self-hosted runner, compromising it.
- **Prevent Actions from creating or approving PRs** — disable this org/repo setting so a compromised workflow can't self-approve a malicious change.

## Resolving Dependabot Alerts

A dependency-vulnerability alert is a risk to triage, not just a PR to merge. This section is the detailed lifecycle behind the `.github/dependabot.yml` / `.github/workflows/dependency-review.yml` controls listed above and the "Dependency & Supply-Chain Risk" section of [governance/risk-management.md](./risk-management.md).

### Triage by severity *and* exploitability, not CVSS alone

CVSS is a starting point, but weigh it alongside:
- **Reachability** — is the vulnerable code path actually invoked by your app, or is it present only in an unused transitive dependency?
- **Exploit maturity** — is there a public PoC, or is the CVE in CISA's [Known Exploited Vulnerabilities (KEV) catalog](https://www.cisa.gov/known-exploited-vulnerabilities-catalog)? KEV entries warrant expedited handling regardless of CVSS score.
- **Direct vs. transitive** — direct dependencies are usually easier and safer to bump than deep transitive ones.

### Lifecycle

1. **Detect** — Dependabot alerts (passive, ongoing) plus `.github/workflows/dependency-review.yml` (blocks a PR at merge time if it *introduces* a new high/critical vulnerability).
2. **Triage** — score severity + exploitability per above; route to the Code Owner for the affected path (see [CODEOWNERS](../.github/CODEOWNERS)).
3. **Remediate**:
   - Prefer Dependabot's *security* updates (opens a PR bumping specifically to the patched version) over waiting for a routine version-update PR.
   - Auto-merge low-risk bumps (patch/minor semver, green CI) to reduce triage load; reserve manual review for major/breaking bumps.
   - If no fix exists yet, apply a compensating control (config workaround, disable the affected feature) and log it as an accepted risk with an owner and review date via the process in [governance/risk-management.md § Process](./risk-management.md#process) — never leave it silently open.
4. **Track** — anything not immediately fixable goes through the same risk-scoring and logging process as any other risk in [governance/risk-management.md](./risk-management.md), with an owner and due date, rather than being left to age in the Security tab.
5. **Verify** — confirm the alert auto-closes once the patched version lands on the default branch (Dependabot does this automatically).
6. **Dismiss only with justification** — GitHub requires a reason (false positive / vulnerable code not used / risk accepted / won't fix) when dismissing an alert; require a second approver for "won't fix" dismissals and revisit them on the same cadence as other accepted risks.
7. **Escalate** critical/KEV findings through [workflows/incident-response-workflow.md](../workflows/incident-response-workflow.md) and, if a release is needed out-of-band, the hotfix path in [standards/branching-strategy.md](../standards/branching-strategy.md).
8. **Measure** — track mean-time-to-remediate per severity and the count/age of open alerts; report it rather than just generating it.

### Remediation SLA

Don't maintain a second SLA table here — a dependency alert is just another risk. Map Dependabot's Critical/High/Medium/Low severity onto the existing scoring and response-SLA bands in [governance/risk-management.md § Simple Risk Scoring](./risk-management.md#simple-risk-scoring), tightening the response for any CVE in CISA's [KEV catalog](https://www.cisa.gov/known-exploited-vulnerabilities-catalog) regardless of where it otherwise scores.

### Supporting standards/frameworks

- [OWASP A03:2025 – Software Supply Chain Failures](https://owasp.org/Top10/2025/A03_2025-Software_Supply_Chain_Failures/) (the [OWASP Top 10:2025](https://owasp.org/Top10/2025/) retired the 2021 edition's standalone "Vulnerable and Outdated Components" category and folded it into this broader one)
- NIST SP 800-40 (patch management) / [NIST SSDF (SP 800-218), v1.1](https://csrc.nist.gov/pubs/sp/800/218/final)
- [CISA BOD 26-04: Prioritizing Security Updates Based on Risk](https://www.cisa.gov/news-events/directives/bod-26-04-prioritizing-security-updates-based-risk) (supersedes and revokes BOD 22-01; timelines now scale by exposure, KEV status, exploit automation, and technical impact rather than a flat KEV-catalog clock — relevant for federal or federal-adjacent work)
- PCI DSS v4.0.1 Req 6.3.3 (if payment-card data is ever in scope; 4.0.1 is a clarification-only release over 4.0, requirement numbering unchanged)
- [SLSA](https://slsa.dev/), currently v1.2 (supply-chain provenance — build integrity rather than alert triage, but commonly cited alongside this topic)
- GitHub's own guidance: [About Dependabot security updates](https://docs.github.com/en/code-security/dependabot/dependabot-security-updates/about-dependabot-security-updates) and [Dependabot auto-triage rules](https://docs.github.com/en/code-security/dependabot/dependabot-auto-triage-rules/about-dependabot-auto-triage-rules)

## Accessibility & Security Overlap

Accessibility is covered separately in [standards/engineering-standards.md](../standards/engineering-standards.md), but note one security-adjacent overlap: inputs for assistive tech (e.g., screen readers triggering autofill) can introduce injection vectors — validate/sanitize regardless of input source.
