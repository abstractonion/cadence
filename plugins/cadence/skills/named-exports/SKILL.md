---
name: named-exports
description: Use when adding TypeScript modules — prefer named exports; avoid `export default` except where a framework explicitly requires it.
---

# TypeScript: named exports only

Use named exports. Don't use `export default`.

## Why

- Named exports make refactors safe: renaming the symbol updates all importers via the language server.
- Default exports allow each importer to invent its own local name → harder to grep, harder to refactor.
- One exported "thing" per file (one main component, one main class, one main hook) keeps modules legible.

## Exceptions

- Framework files that require a default export by convention (e.g. some bundler entry points, Next.js page files). Use the framework's expected shape; don't fight it.
