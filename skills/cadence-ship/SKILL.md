---
name: cadence-ship
description: Use when the user asks for Cadence ship mode or wants a clean commit and final verification pass.
---

# Cadence Ship

Use ship mode for this turn. Inspect the worktree, separate unrelated changes, run the appropriate
lint/typecheck/test/runtime checks, and prepare a clean commit only if the user has asked you to
commit. Refuse to include unrelated files. Summarize what changed, what was verified, and any risk
left for the user to understand before handoff.

Anchored in `clean-commits`, `run-lint-and-typecheck`, and `verify-with-runtime`.
