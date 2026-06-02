---
name: nullable-equality
description: Use when writing TypeScript nullability checks — prefer `== null` / `!= null` to match both null and undefined; use strict equality everywhere else.
---

# TypeScript: compare nullables with `==` / `!=` null

For nullability checks specifically, use the loose-equality form.

## Do

```ts
if (value == null) { ... }   // matches null AND undefined
if (value != null) { ... }   // narrows to NonNullable<T>
```

## Don't

```ts
if (value === null || value === undefined) { ... }   // verbose
if (!value) { ... }                                   // wrong for 0, "", false
if (value === undefined) { ... }                      // misses null
```

This is the only place loose equality is acceptable. Everywhere else, use `===` / `!==`.
