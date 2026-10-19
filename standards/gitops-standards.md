# GitOps Standards (Argo CD)

Authoritative detail behind [README.md § Argo CD (GitOps) Standards](../README.md#argo-cd-gitops-standards). Pairs with [standards/ci-cd-standards.md](./ci-cd-standards.md) (build/test) — this covers deployment/sync once an artifact exists.

## Repository Separation
- Keep Kubernetes manifests/config in a separate Git repository from application source code for clean audit trails, separation of access, and to avoid CI loops.

## Immutability & Version Pinning
- Pin to tags or commit SHAs; avoid floating refs like `HEAD` or unpinned remote bases in Helm/Kustomize sources.

## Secrets & Credentials
- Store Git/Helm repository credentials in Kubernetes secrets and reference them via Argo CD repository configuration (`usernameSecret`, `sshPrivateKeySecret`), never inline in manifests. See [governance/security-practices.md](../governance/security-practices.md).

## Recommended Patterns
- Use App-of-Apps, SyncWaves, and ApplicationSets for multi-service deployments and PR preview environments.

## Example: Argo CD `Application`
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: webapp-staging
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/example-org/webapp-config.git
    targetRevision: v1.3.2   # pin to tag/commit for immutability
    path: k8s/overlays/staging
  destination:
    server: https://kubernetes.default.svc
    namespace: webapp
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
      - ApplyOutOfSyncOnly=true
  revisionHistoryLimit: 10
```

Separation of config vs. source, immutability guidance, and automation flags above follow Argo CD's official best practices.
