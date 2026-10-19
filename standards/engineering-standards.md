# Engineering Standards

The authoritative detail behind the summary in [README.md § Engineering Standards](../README.md#engineering-standards). Covers performance, accessibility, and maintainability. Security lives in [governance/security-practices.md](../governance/security-practices.md) instead, since it spans more than engineering mechanics.

## Performance
- Target Core Web Vitals: INP ≤ 200 ms (p75), LCP ≤ 2.5 s, CLS ≤ 0.1. Prefer SSR/SSG over CSR; leverage edge caching/CDN.
- Adopt server-first architectures (e.g., React Server Components) and code-splitting; minimize client bundles.
- Implement real-user monitoring (RUM) and performance budgets in CI.
- These targets apply to web applications specifically — for APIs/services, define equivalent SLOs (p95/p99 latency, error rate, throughput) and track them the same way.

## Accessibility
- Meet WCAG 2.2 AA: semantic HTML, keyboard operability, sufficient contrast, visible focus states, and 24x24 px minimum tap targets.
- Run automated accessibility checks (e.g., axe-core) in CI alongside unit tests; automated checks catch ~30-40% of issues, so pair with periodic manual/screen-reader testing.

## Maintainability
- Prefer statically-typed languages/typed superset (e.g., TypeScript over JavaScript) where practical; enforce lint and format checks on commit (see [code-starter/.pre-commit-config.yaml](../code-starter/.pre-commit-config.yaml)).
- Keep cyclomatic complexity low and use component-driven/modular design — see [standards/coding-standards.md](./coding-standards.md) for language-specific detail.
- Track technical debt explicitly (tag issues `tech-debt`) rather than letting it accumulate silently — see [governance/risk-management.md](../governance/risk-management.md).

## CI/CD & Observability
- Optimize for [DORA metrics](https://dora.dev/): frequent deploys, short lead time, and fast MTTR via canary/blue-green releases, feature flags, and fast feedback loops.
- Instrument with tracing, metrics, and error monitoring (e.g., OpenTelemetry, Sentry, Datadog) — observability is what turns "deployment" into "deployment you can trust," per the Maintenance phase in [governance/SDLC.md](../governance/SDLC.md).
- See [standards/ci-cd-standards.md](./ci-cd-standards.md) for pipeline mechanics and [standards/gitops-standards.md](./gitops-standards.md) for deployment mechanics.
