# Variable, Function, and Class Naming

Pairs with [standards/coding-standards.md](../standards/coding-standards.md). Casing conventions differ by language — follow each language's idiom rather than forcing one style everywhere.

| Identifier | Python | JS/TypeScript | Go | Rust |
|---|---|---|---|---|
| Variable | `snake_case` | `camelCase` | `camelCase` | `snake_case` |
| Function | `snake_case` | `camelCase` | `camelCase` (exported: `PascalCase`) | `snake_case` |
| Class/Type | `PascalCase` | `PascalCase` | `PascalCase` | `PascalCase` |
| Constant | `UPPER_SNAKE_CASE` | `UPPER_SNAKE_CASE` | `PascalCase` or `UPPER_SNAKE_CASE` | `UPPER_SNAKE_CASE` |
| Interface | n/a | `PascalCase` (no `I` prefix) | `PascalCase` (often `-er` suffix: `Reader`) | `PascalCase` (trait) |

## Naming Quality, Regardless of Language
- **Name by intent, not by type or implementation.** `userList` is weaker than `activeUsers`; `data` tells the reader nothing.
- **Booleans read as a question**: `isValid`, `hasPermission`, `canRetry` — not `valid`, `flag`, `check`.
- **Avoid abbreviations** unless they're domain-standard (`id`, `url`, `html` are fine; `usrMgr` is not).
- **Function names are verbs** (`calculateTotal`, `fetch_user`); **class/type names are nouns** (`InvoiceCalculator`, `UserRepository`).
- **Match the plurality to the thing**: a single item is singular (`user`); a collection is plural (`users`) — don't name a list `userList` when `users` is enough, unless disambiguating from a non-list `user` in the same scope.

## Infrastructure/Data
See [infrastructure-resources.md](./infrastructure-resources.md) for cloud resources, environment variables, and secrets naming.
