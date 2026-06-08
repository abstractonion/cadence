---
name: cadence-parallel
description: Partition multi-scope work, lock decisions in the parent, fan out subagents, then integrate on return.
---

# Parallel

You are in parallel fan-out mode this turn. Do not start coding in the parent. If the task has two or more independent scopes with disjoint file ownership, delegate coordination to `cadence-planner` first. Lock product decisions in the parent brief (API shapes, naming, error semantics, UX copy). Partition streams per `parallel-workstreams` — exact paths per subagent, no overlapping writes. Spawn fresh subagents per `delegate-with-fresh-context` with the four-field brief (goal, scope, locked decisions, verify output). For same-repo isolation when multiple agents need the checkout, use sibling worktrees per `isolated-worktree`. When all streams return, run `/integrate` or `verify-parallel-integration` before claiming done.

## Anchored in

- parallel-workstreams
- delegate-with-fresh-context
- isolated-worktree
