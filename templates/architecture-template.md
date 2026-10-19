<!-- Copy to document a system/service's architecture. For a single decision, use governance/architecture-decision-records/0000-adr-template.md instead. -->

# [System/Service Name] Architecture

## Overview
[1-2 paragraphs: what this system does, and its role in the broader architecture.]

## Context Diagram
[Diagram or description of this system's external dependencies/consumers — what calls it, what it calls.]

```
[Consumer A] ──► [This System] ──► [Dependency 1]
                      │
                      ▼
                [Dependency 2]
```

## Components
| Component | Responsibility | Owner |
|---|---|---|
| [Component 1] | [What it does] | [Team/person] |

## Data Model
[Key entities and their relationships, or link to a schema file.]

## Non-Functional Requirements
| Attribute | Target |
|---|---|
| Availability | [e.g., 99.9%] |
| Latency (p95) | [e.g., < 200ms] |
| Throughput | [e.g., 500 req/s] |

See [standards/engineering-standards.md](../standards/engineering-standards.md) for baseline targets.

## Key Decisions
[Link relevant ADRs from governance/architecture-decision-records/]

## Open Questions / Risks
[Anything unresolved — link to governance/risk-management.md if tracked there.]
