---
name: feature-local-by-default
description: Use when placing new modules, components, hooks, or helpers — default to the feature folder that uses them; promote to shared only when a concrete second user exists.
---

# Feature-local by default

Default to placing new modules, components, hooks, helpers, and types **inside the feature folder** that uses them.

## When to promote to shared

- The code is used by ≥2 distinct features.
- The code is a foundational primitive (e.g. low-level utility, framework adapter).
- A future second user is concrete and imminent — not hypothetical.

## When to keep local

- A single feature uses it.
- It encodes feature-specific business rules.
- It's small enough that duplicating it later would be cheaper than the wrong abstraction.

Small intentional cross-feature imports are fine. Don't move things to `shared/` just because they "feel reusable".
