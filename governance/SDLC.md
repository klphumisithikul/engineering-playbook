# Software Development Life Cycle (SDLC)

> Authoritative source for the lifecycle phases. [README.md](../README.md) and [docs/overview.md](../docs/overview.md) have link here rather than duplicating this content.

## Why SDLC Is Platform- and Methodology-Agnostic

The core SDLC phases - ** planning, design, development, testing, deployment, and maintenance** - are fundamental across industries and tech stacks. They hold true regardless of methodology (Waterfall, Agile, DevOps) or platform (Windows, macOS, Linux), which is what makes SDLC a universal foundation rather than a tool- or team-specific process. The SDLC phases are a framework for thinking about software development, not a prescriptive set of steps to follow.

This repository also aligns its phase definitions with **ISO/IEC/IEEE 12207**, the international standard outling process activities across the software lifecycle. ISO 12207 doesn't replace Agil/DevOps/Waterfall - it describes _what_ process activities exist (e.g., requirements analysis, verficiation, configuration management); your methodology decides _how_ and _in what order_ you execute those activities.

## The Phases

| Phase              | Purpose                                                            | Primary Artifacts in This Repo                                                                                                                                                                        |
| ------------------ | ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Planning**    | Define scope, goals, success criteria, and risks                   | [governance-model.md](./governance-model.md), [risk-management.md](./risk-management.md), issue templates                                                                                             |
| **2. Design**      | Architecture, interfaces, data models, non-functional requirements | [architecture-decision-records/](./architecture-decision-records), [templates/architecture-tempate.md](../templates/architecture-template.md)                                                         |
| **3. Development** | Implementation following standards                                 | [standards/](../standards), [naming-conventions/](../naming-conventions), [code-starter/](../code-starter)                                                                                            |
| **4. Testing**     | Verification & validation against requirements                     | [standards/coding-standards.md](../standards/coding-standards.md)(testing section), `.github/workflows/ci.yml`                                                                                        |
| **5. Deployment**  | Release to staging/production                                      | [standards/ci-cd-standards.md](../standards/ci-cd-standards.md), [standards/gitops-standards.md](../standards/gitops-standards.md), [workflows/release-workflow.md](../workflows/release-workflow.md) |
| **6. Maintenance** | Monitoring, incident response, patching, deprecation               | [governance/risk-management.md](./risk-management.md), [workflows/incident-response-workflow.md](../workflows/incident-response-workflow.md), `SECURITY.md`                                           |

These phases are **iterative, not strictly sequential** - in an Agile/DevOps model they repeat every sprint or every deploy not on pers propect.

## Mapping to This Repopository

```
Plan -----> Design ------> Develop ------> Test ------> Deploy ------> Maintain
  |           |             |                |            |                |
governance/ templates/     standards/     .github/     standards/     governance/
risk-mgmt   architecture-   naming-conv.    workflows/    ci-cd-std.  risk-mgmt,
model, ADRs template        code-starter    ci.yml        gitops-std. SECURITY.md
```

## Methodology Overlay

This repo doesn't mandate Agile vs. Waterfall vs. DevOps -- pick what fits your team's needs, and layer it on top of these phases:

- **Waterfall**: phases run once, sequentially, with formal sign-off (see [governance-model.md](./governance-model.md) for approval process).
- **Agile/Scrum**: phases repeat every sprint at a smaller scale (plan a sprint -> design a story -> build -> test -> ship increment -> retro).
- **DevOps/Continuous Delivery**: Development/Testing/Deployment phases collapse into a single automated pipline (see `.github/workflows/ci.yml` and `.gitlab-ci.yml`), running on every commit

## References

- Sourcegraph, [SDLC Best Practices and Tools: A Complete Guide (2026)](https://sourcegraph.com/blog/sdlc-best-practices-and-tools-a-complete-guide-2026)
- GeeksforGeeks, [Software Development Life Cycle (SDLC) Phases](https://www.geeksforgeeks.org/software-development-life-cycle-sdlc-phases/)
- ISO/IEC/IEEE 12207:2026, _Systems and software engineering — Software life cycle processes_
