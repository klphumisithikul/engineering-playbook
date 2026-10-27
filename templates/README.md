<!-- Copy to plan testing for a feature, release, or migration. -->

# Test Plan: [Feature/Release Name]

## Scope
[What is being tested? What's explicitly out of scope?]

## Test Levels
| Level | Covers | Owner | Tooling |
|---|---|---|---|
| Unit | Individual functions/components | Developer | [pytest/jest/go test/...] |
| Integration | Interactions between components/services | Developer/QA | [...] |
| End-to-end | Full user flows | QA | [Playwright/Cypress/...] |
| Non-functional | Performance, accessibility, security | [Owner] | [k6, axe-core, Trivy/gitleaks] |

See [standards/coding-standards.md](../standards/coding-standards.md) and [standards/engineering-standards.md](../standards/engineering-standards.md) for the baseline targets these should meet.

## Test Cases
| ID | Scenario | Steps | Expected Result | Status |
|---|---|---|---|---|
| TC-1 | [Happy path] | [steps] | [expected] | [ ] |
| TC-2 | [Edge case] | [steps] | [expected] | [ ] |
| TC-3 | [Failure/error case] | [steps] | [expected] | [ ] |

## Exit Criteria
- [ ] All test cases above pass.
- [ ] No open critical/high defects.
- [ ] Coverage meets the target in [standards/coding-standards.md](../standards/coding-standards.md).
- [ ] CI (`.github/workflows/ci.yml`) is green.

## Rollback Plan
[What happens if this fails in production? See workflows/incident-response-workflow.md.]
