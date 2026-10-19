# Repository Architecture: Monorepo vs. Polyrepo

One of the earliest, hardest-to-reverse decisions for a new project (see [governance/architecture-decision-records/](../governance/architecture-decision-records) — this is a textbook ADR candidate). Adapted from GitHub's own [Well-Architected: Repository Architecture Strategy](https://learn.github.com/well-architected/architecture/recommendations/scaling-git-repositories/repository-architecture-strategy) guide.

## The Decision

| | Monorepo | Polyrepo |
|---|---|---|
| **What** | One repository holds the entire codebase (web app, mobile app, microservices, shared libs) | Each component/service gets its own repository |
| **Pros** | Unified codebase, consistent tooling, simpler shared-dependency management, atomic cross-component commits | Scales independently, clear separation of concerns, per-repo tailored workflows, finer-grained access control |
| **Cons** | Can become large/slow to build as it grows; harder access control at scale; more merge contention | Harder cross-repo dependency management and coordinated changes; fragmented view of the whole system |

Neither is "more industry standard" than the other — large tech companies run both successfully (Google's monorepo is famous; most microservice-heavy orgs run polyrepo). Pick based on your team's actual coordination needs, not fashion.

## Key Design Strategies (apply whichever you choose)

| Area | Monorepo | Polyrepo |
|---|---|---|
| Project structure | Modular subdirectories per component | Consistent naming/structure *across* repos — see [naming-conventions/files-and-folders.md](../naming-conventions/files-and-folders.md) |
| Dependency management | Tools like Lerna, Bazel, Nx; centralize dependency versions | Git Submodules/Subtrees, or package managers (npm, Maven) for shared libs |
| Version control | A branching strategy that suits one shared history — see [standards/branching-strategy.md](./branching-strategy.md) | Consistent branching strategy *and* commit conventions across every repo, or coordination becomes chaos |
| CI/CD | Incremental builds — only rebuild changed directories/components | Per-repo pipelines, interconnected where needed — see [standards/ci-cd-standards.md](./ci-cd-standards.md) |
| Access control | [.github/CODEOWNERS](../.github/CODEOWNERS) + role-based access within the one repo | Per-repository permissions — more granular, more to maintain |
| Release strategy | Feature flags + coordinated release branches to avoid shipping half-finished cross-component changes | [Semantic Versioning](https://semver.org/) per repo, with explicit cross-repo dependency-update policies |

## GitHub-Specific Implementation

Per the same GitHub Well-Architected guide, once you've picked a model:
- **Monorepo**: one GitHub repository, directories per module; GitHub Actions with path filters (`on.push.paths`) for incremental/targeted builds; GitHub Packages for any pieces you still want independently versioned.
- **Polyrepo**: one GitHub repository per component, consistent naming (see [naming-conventions/files-and-folders.md](../naming-conventions/files-and-folders.md)), GitHub Packages for shared libraries so you're not hand-rolling dependency distribution, and an org-level [GitHub Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects) board if you need a cross-repo view of work.
- Either way: see [standards/github-repo-setup.md](./github-repo-setup.md) for the concrete per-repository setup checklist, and [governance/governance-model.md](../governance/governance-model.md) for organization-level structure (teams, owners) that polyrepo setups especially depend on.

## Implementation Checklist

1. **Define goals**: project scope/size, team structure, and what you're actually optimizing for (build speed? independent deploys? atomic cross-component changes?).
2. **Choose**: monorepo or polyrepo, explicitly, and write it down (an ADR — see [governance/architecture-decision-records/](../governance/architecture-decision-records)).
3. **Plan structure**: directory layout (monorepo) or naming/structure consistency (polyrepo).
4. **Pick dependency tooling** per the table above.
5. **Set version control + CI/CD practices** per [standards/branching-strategy.md](./branching-strategy.md) and [standards/ci-cd-standards.md](./ci-cd-standards.md).
6. **Set access control**: CODEOWNERS (monorepo) or per-repo permissions + org teams (polyrepo) — see [governance/governance-model.md](../governance/governance-model.md).
7. **Revisit periodically**: this decision isn't permanent — large monorepos sometimes get split, and sprawling polyrepos sometimes consolidate. Revisit if the original goals (step 1) stop being met.

## Further Reading
- [GitHub Well-Architected: Repository Architecture Strategy](https://learn.github.com/well-architected/architecture/recommendations/scaling-git-repositories/repository-architecture-strategy) — the source this page is adapted from.
- [Maintaining a Monorepo](https://monorepo-book.github.io/) — referenced by the above as further external reading.
