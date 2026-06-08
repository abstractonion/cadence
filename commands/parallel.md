---
name: parallel
description: Fan out independent workstreams with locked parent decisions, spawn subagents, then hand off to integrate.
disable-model-invocation: true
---

# Parallel

You are in parallel fan-out mode this turn. Do not integrate streams or claim the feature done. Partition the task into independent workstreams with disjoint file ownership; lock product decisions in the parent (API shapes, naming, error semantics, UX copy). For dependency mapping across streams, delegate to `cadence-planner` first. Spawn one fresh subagent per fan-out stream with a precise brief per `parallel-workstreams` and `delegate-with-fresh-context` — goal, scope, locked decisions, verify output. Serialize streams that share contracts, barrels, or wiring. When same-repo agents would collide on the main checkout, give each stream a sibling worktree per `isolated-worktree`. End by telling the user to run `/integrate` once all streams return.

## Anchored in

- parallel-workstreams
- delegate-with-fresh-context
- cadence-planner
