# Repository Architecture: Monorepo vs. Polyrepo

One of the earliest, hardest-to-reverse decisions for a new project (see [governance/architecture-decision-records/](../governance/architecture-decision-records/) - this is a textbook ADR candidate). Adapted from GitHub's own [Exploring repository architecture strategy](https://learn.github.com/well-architected/architecture/recommendations/scaling-git-repositories/repository-architecture-strategy) guide.

## The Decision

|   | Monorepo | Polyrepo |
|---|---|---|
| **What** | One repository holds the entire codebase (web app, mobile app, microservices, shared libs) | Each component/service gets its own repository | 
| **Pros** | Unified codebase, consistent tooling, simpler shared-dependency management, atomic cross-component commits | Scales independently , clear separation of concerns, per-repo tailored workflows, finer-grained access control | 
| **Cons** | Can become large/slow to build as it grows; harder access control at scale; more merge contention | Harder cross-repo dependency management and coordinate changes; framented view of the whole system |

Neither is "more industry standard" than the other - large tech companies run both successfully (Google's monorepo is famous; most microservice-heavy orgs run poly repo). Pick based on your team's actual coordination needs, not trends.

## Key Design Strategies (apply whichever your choose)

| Area | Monorepo | Polyrepo |
|---|---|---|
| Project structure | Modular subdirectories per component | Consisten naming/structure *across* repos - see [naming-conventions/files-and-folders.md](../naming-conventions/files-and-folders.md) |
| Dependency management | Tools like Lerna, Bazel, Nx; centralize dependency versions | Git Submodules/Subtrees, or package managers (npm, Maven) for shared libs | 
| Verstion control | A branching strategy that suits one shared hsitory - see [standards/branching-strategy.md](../standards/branching-strategy.md) | Consistent branching strategy *and* commit conventions across every repo, or coordination becaomes chaos |
| CI/CD | Incremental builds - only rebuild changed directories/components | Per-repo pipelines, interconnected where needed - see [standards/ci-cd-standards.md](../standards/ci-cd-standards.md) |
| Access control | [.github/C]()