---
name: parallel-workstreams
description: Use when spinning up subagents on a multi-file feature with two or more independent scopes — partition work, lock decisions in the parent, fan out, then integrate.
---

# Parallel workstreams

When a feature spans multiple independent scopes (backend + frontend, API + migration, two unrelated modules), partition the work before dispatching subagents. The parent owns coordination and integration; each subagent owns one slice with no overlapping file writes.

## When this applies

- You are about to spin up subagents on the same branch.
- The change is multi-file and has two or more scopes that can be owned separately.
- Each scope has clear file boundaries and does not need the other's in-progress edits to start.

Single-thread work belongs in `break-work-into-verifiable-steps` or `/plan` — do not fan out for one linear sequence.

## Steps

1. **List workstreams and file ownership.** Name each stream (e.g. "API routes", "client hooks") and assign exact paths each subagent may touch. Flag shared files (index barrels, route tables, schema) — either parent-owned or serialized last.
2. **Serialize vs fan-out.** Fan out only streams with disjoint file sets. Serialize anything that shares a contract file, migration order, or a single wiring point. When in doubt, serialize.
3. **Lock product decisions in the parent.** API shapes, naming, error semantics, feature flags, and UX copy stay in the parent brief — subagents implement, they do not invent product policy.
4. **Spawn subagents with a precise brief** (see `delegate-with-fresh-context`):
   - **Goal** — one sentence for this stream's done state.
   - **Scope** — allowed paths; explicit must-not-touch list.
   - **Locked decisions** — paste the parent's locked choices so the subagent does not re-decide.
   - **Verify output** — the command(s) and passing criteria before reporting back.
5. **Integrate when all return.** Do not claim done until the parent runs `verify-parallel-integration` on the combined branch.

## What not to do

- Don't dispatch parallel subagents that edit the same files — they will conflict on merge.
- Don't skip locked decisions — divergent assumptions are the main failure mode.
- Don't trust per-stream "done" without parent-level integration checks.

## Anchored in

- `delegate-with-fresh-context`
- `break-work-into-verifiable-steps`
