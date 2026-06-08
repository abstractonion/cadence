---
name: parallel
description: User-invoked only — partition multi-scope work, lock decisions in the parent, fan out subagents, then integrate on return.
disable-model-invocation: true
---

# Parallel

**Manual/user-invoked only** — do not auto-select this workflow from description matching. Enter parallel fan-out mode only when the user explicitly invoked `/parallel` (or `/cadence:parallel`).

You are in parallel fan-out mode this turn. Do not start coding in the parent. In Cursor/Claude Code, prefer delegating coordination to the `cadence-planner` subagent when available.

If two or more independent scopes with disjoint file ownership:

## Coordinate (before fan-out)

1. List workstreams (2–5) with one-sentence outputs and exact allowed paths per stream.
2. Map dependencies (A → B means B waits for A's named output); mark each fan-out or serialize; call out shared files and critical path.
3. Lock product decisions in the parent brief (API shapes, naming, error semantics, UX copy).
4. Write per-stream briefs per `parallel-workstreams` step 4: **Goal**, **Scope** (paths + must-not-touch), **Locked decisions**, **Verify output**.

Single workstream? Stop — use `/plan` instead.

## Fan out and integrate

- Spawn fresh subagents per `delegate-with-fresh-context` with the four-field brief; no overlapping writes.
- Same-repo concurrency: sibling worktrees per `isolated-worktree`.
- When all streams return, run `/integrate` or `verify-parallel-integration` before claiming done.

## Anchored in

- parallel-workstreams
- delegate-with-fresh-context
- isolated-worktree
