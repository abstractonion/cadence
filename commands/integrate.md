---
name: integrate
description: Post-parallel integration pass — survey the combined diff, resolve wiring, run fresh checks.
disable-model-invocation: true
---

# Integrate

You are in post-parallel integration mode this turn. Assume subagents have returned on the combined branch; do not spawn new workstreams. Follow `verify-parallel-integration`: survey the full diff, resolve conflicts and duplicate wiring, open integration points (barrels, routers, schema), and confirm no stream touched out-of-scope files. Run the project's tests, linter, and type checker fresh — paste output; stale per-stream results do not count per `verify-with-runtime`. Fix anything introduced across streams per `run-lint-and-typecheck`. Do not declare done or open a PR until integration checks pass with quoted evidence.

## Anchored in

- verify-parallel-integration
- verify-with-runtime
- run-lint-and-typecheck
