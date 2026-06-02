---
name: update-callers-on-contract-changes
description: Use when changing a shared contract — function signature, schema field, union variant, dispatch key — update every caller, test, fixture, and snapshot in the same change.
---

# Update callers when contracts change

A "shared contract" is anything other code depends on by shape:

- Function/method signatures.
- API schema fields (request/response, GraphQL types, protobuf, OpenAPI).
- Union/enum variants and discriminator values.
- Event payload shapes, message types, dispatch tables.
- Public types/interfaces exported from a module.

## What to do

- Before changing the contract, search for callers (grep the symbol name, the field name, and any string-based dispatch key).
- Update each caller and its tests in the same PR.
- Update evals / fixtures / snapshots that encode the shape.
- If the contract crosses a service boundary, plan compatibility (versioning or lockstep deploy) explicitly — don't quietly break consumers.
