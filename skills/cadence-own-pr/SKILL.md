---
name: cadence-own-pr
description: Own PR #N until CI is green — triage comments, fix failures, resolve conflicts, push scoped fixes.
---

# Own PR

You are owning a pull request to green this turn. Delegate to the `cadence-pr-owner` subagent with the PR number from the user's message (or ask if missing). The subagent works in a sibling worktree at `{repo}-pr{N}`, triages unresolved review threads, fixes in-scope CI failures, resolves merge conflicts, runs targeted lint and tests, commits and pushes scoped fixes, replies on threads, and polls CI until green or an explicit blocker. Do not merge or force-push. Return the PR URL, CI status, and any blockers.

## Anchored in

- cadence-pr-owner
- clean-commits
- run-lint-and-typecheck
- verify-with-runtime
