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

## Accessibility & Security Overlap

Accessibility is covered separately in [standards/engineering-standards.md](../standards/engineering-standards.md), but note one security-adjacent overlap: inputs for assistive tech (e.g., screen readers triggering autofill) can introduce injection vectors — validate/sanitize regardless of input source.
