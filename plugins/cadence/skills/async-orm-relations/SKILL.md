---
name: async-orm-relations
description: Use when writing async backend code that touches ORM related fields — eagerly prefetch them (`select_related`, `prefetch_related`, `selectinload`, `joinedload`); do not rely on lazy loading in async contexts.
---

# Async ORM: prefetch related fields explicitly

Many ORMs (Django, SQLAlchemy, Tortoise, etc.) lazy-load related fields on attribute access. In async contexts that lazy access either blocks the event loop or raises ("cannot be called in an async context") — usually right when the code is read most.

## Rules

- When you'll touch a related field in an async function, eagerly fetch it on the query:
  - Django ORM: `.select_related("foo")`, `.prefetch_related("bars")`.
  - SQLAlchemy 2.x async: `selectinload`, `joinedload`.
- When prefetching a relation to a filtered/scoped queryset, pass an explicit prefetch object with the scoped queryset — don't rely on the default manager.
- When iterating a queryset asynchronously, use the async iteration interface (`async for ...`) — don't `list()` it in sync code.
- Treat any "model attribute access blew up in async" error as a missing prefetch, not a reason to drop to sync.
