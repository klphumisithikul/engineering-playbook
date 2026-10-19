# Infrastructure & Resource Naming

## Pattern
```
<org/project>-<environment>-<resource-type>-<descriptor>
```
Example: `acme-prod-db-orders`, `acme-staging-queue-notifications`.

## Environments
Use a fixed, small vocabulary everywhere (CI variables, Argo CD environments, cloud tags): `dev`, `staging`, `prod`. Avoid synonyms like `production`/`prd`/`live` creeping in across different systems — pick one and use it consistently (see [standards/gitops-standards.md](../standards/gitops-standards.md) for environment naming in Argo CD `Application` manifests).

## Environment Variables & Secrets
- `UPPER_SNAKE_CASE` for environment variables: `DATABASE_URL`, `API_KEY`.
- Prefix secrets that are environment-specific: `PROD_DB_PASSWORD` vs. `STAGING_DB_PASSWORD`, rather than one ambiguous `DB_PASSWORD` reused across CI environments.
- Never put the actual secret value in the name (obvious, but it happens): the name describes *what it unlocks*, not *the value itself*.
- See [code-starter/.env.example](../code-starter/.env.example) for the pattern of documenting required env vars without committing real values.

## Cloud Resources (illustrative — adapt per provider)
| Resource | Pattern | Example |
|---|---|---|
| Container image | `<registry>/<org>/<app>:<semver-or-sha>` | `ghcr.io/acme/orders-api:1.4.2` |
| Kubernetes namespace | `<app>-<env>` | `orders-api-staging` |
| S3/Blob bucket | `<org>-<env>-<purpose>` | `acme-prod-user-uploads` |
| IAM role/service account | `<app>-<env>-<purpose>-role` | `orders-api-prod-s3-role` |

## Why This Matters
Inconsistent infra naming is one of the most common sources of production incidents (deploying to the wrong environment because two naming schemes disagreed). Treat this list as non-negotiable even when code-level style is flexible — see [governance/risk-management.md](../governance/risk-management.md) (Operational risk category).
