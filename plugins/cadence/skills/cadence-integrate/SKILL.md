---
name: cadence-integrate
description: Post-parallel integration pass — survey combined diff, resolve wiring, run fresh checks.
disable-model-invocation: true
---

# Integrate

You are in post-parallel integration mode this turn. Two or more subagents have returned on this branch — do not trust per-stream "done" reports. Walk `verify-parallel-integration` in order: (1) survey `git diff --stat` and flag out-of-scope edits; (2) resolve duplicate wiring in shared files (barrels, routers, registrations); (3) confirm each stream's output is connected, not just present; (4) run tests and paste fresh output per `verify-with-runtime`; (5) run lint and typecheck per `run-lint-and-typecheck`. Surface blockers before ship. Do not push.

## Anchored in

- verify-parallel-integration
- verify-with-runtime
- run-lint-and-typecheck
