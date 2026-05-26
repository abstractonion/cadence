---
name: register-models-in-admin
description: Use when adding a new backend ORM model in a framework with a built-in admin UI (Django, Rails, Strapi, Payload, etc.) — register the model with a minimal usable configuration, or document why not.
---

# Register new models in admin

Frameworks with a built-in admin/inspection UI (Django admin, Rails ActiveAdmin, Strapi, Payload, etc.) become useless when half the models are missing.

## Default

- For each new model, add a minimal admin/inspection registration: list display, searchable fields, sensible filters.
- For tenant-scoped or otherwise restricted data, add the scoping in the admin class — don't expose a foot-gun.

## When to skip

- Pure join tables.
- Internal denormalization caches the user is not supposed to inspect directly.
- Truly transient/log-like tables where the cost of accidental edits outweighs the inspection benefit.

In every "skip" case, leave a one-line comment in `models.py` (or the equivalent) explaining why so a future agent doesn't add it by reflex.
