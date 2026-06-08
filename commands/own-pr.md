---
name: own-pr
description: Babysit PR #N until it settles — green required CI and actionable review addressed; ongoing loop, not a single pass.
disable-model-invocation: true
---

# Own PR

Delegate to the `cadence-pr-owner` subagent for **ongoing babysit** until the PR settles — not a single fix-and-exit pass. Pass the PR number from the user's message (or ask if missing). The subagent works in a sibling worktree at `{repo}-pr{N}`, runs the settle loop (each push → fresh CI + new comments → re-triage → fix → push → repeat), triages threads in parallel while CI runs, and stops when required CI is green, actionable review is addressed, or a human blocker surfaces. Do not merge or force-push. Return PR URL, CI status, review state, and blockers.

## Anchored in

- clean-commits
- run-lint-and-typecheck
- verify-with-runtime
