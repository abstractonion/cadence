---
name: no-any-no-casts
description: Use when writing or reviewing TypeScript code that would otherwise reach for `any` or `as` to silence the type checker — find the real type instead.
---

# TypeScript: no `any`, no `as` casts

Don't bypass the type system to make the compiler happy.

## Rules

- Don't use `any` to avoid typing something. If you don't know the type, find it in the codebase or infer it from how the value is used.
- Don't use `as` to coerce a value into a type. The only `as` that doesn't need justification is `as const`.
- `as unknown as X` double-cast is forbidden by the same logic.

## Allowed exceptions

- You are copying an existing pattern in the same file/module that already uses a cast for a known-good reason.
- Library types are genuinely wrong and you've isolated the cast in a single typed wrapper with a comment explaining why.

If you think you need `any` or `as`, stop and propose: usually a generic, a type guard, a discriminated union, or a small refactor removes the need.
