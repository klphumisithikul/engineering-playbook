<!-- Copy this before building a new API surface (REST/RPC/GraphQL). Fill in and get it reviewed (consider an ADR for anything hard to change later, see governance/architecture-decision-records/). -->

# API Design: [Name]

## Purpose
[What capability does this API expose, and to whom (internal service, public, partner)?]

## Style & Conventions
- Protocol: [REST | gRPC | GraphQL]
- Versioning strategy: [e.g., URL path `/v1/`, header-based]
- Naming: resources are plural nouns (`/users`, not `/getUser`) for REST; see [naming-conventions/variables-and-code.md](../naming-conventions/variables-and-code.md).
- Error format: [consistent error envelope, e.g. `{ "error": { "code": "...", "message": "..." } }`]

## Endpoints / Methods
| Method | Path/RPC | Description | Auth required |
|---|---|---|---|
| `GET` | `/v1/[resource]` | [description] | [yes/no] |
| `POST` | `/v1/[resource]` | [description] | [yes/no] |

## Request/Response Example
```json
// Request
{ }

// Response (200)
{ }
```

## Backward Compatibility
How will breaking changes be handled? (New version path? Deprecation window?) See [standards/commit-message-guidelines.md](../standards/commit-message-guidelines.md) for how a breaking API change should be flagged in commits (`BREAKING CHANGE:`).

## Security Considerations
Auth model, rate limiting, input validation — see [governance/security-practices.md](../governance/security-practices.md).

## Testing Plan
See [testing-template.md](./testing-template.md).
