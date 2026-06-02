---
name: centralized-query-options
description: Use when adding server-state queries or mutations (TanStack Query, SWR, RTK Query, Apollo) — define options in a centralized factory module; do not write inline keys at call sites.
---

# Centralized query options, stable keys

When the project uses a server-state library (TanStack Query, SWR, RTK Query, Apollo), define each query's options in a single factory module rather than inline at the call site.

## Pattern (TanStack Query example)

```ts
// queries/projects.ts
export const projectQueries = {
  detail: (id: string) =>
    queryOptions({
      queryKey: ["projects", "detail", id],
      queryFn: () => api.projects.get({ id }),
    }),
};

// component.tsx
const { data } = useQuery(projectQueries.detail(projectId));
```

## Why

- Query keys are spelled exactly once → safe invalidation.
- The fetcher function and key live together → less drift.
- Mutations that need to invalidate can import the same factory.

## Don't

- Don't write inline `useQuery({ queryKey: ["projects", id], queryFn: ... })` in components.
- Don't duplicate the same key string across files — import it.
- Don't put the cache key inside a `useMemo` to "stabilize" it; the factory already gives you a stable shape.
