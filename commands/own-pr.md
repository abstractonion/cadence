---
name: own-pr
description: "Babysit PR #N until it settles — green required CI and actionable review addressed; ongoing loop, not a single pass."
disable-model-invocation: true
---

# Own PR

**Manual/user-invoked only** — do not auto-select this workflow from description matching. Enter PR babysit mode only when the user explicitly invoked `/own-pr` (or `/cadence:own-pr`).

Babysit PR #N until settled — required CI green AND no unresolved actionable review threads. Ongoing loop, not a single pass. In Cursor/Claude Code, prefer delegating to the `cadence-pr-owner` subagent when available.

Pass the PR number from the user's message (or ask if missing). Work in sibling worktree `{repo}-pr{N}` per `isolated-worktree`. Do not merge the PR into base (`gh pr merge`, Merge button) or force-push; merging base into head when behind is allowed.

## How to operate

1. `gh pr view N --json url,headRefName,baseRefName,mergeable,mergeStateStatus,statusCheckRollup`; create worktree at `{repo}-pr{N}` if missing; confirm branch matches.
2. Fetch unresolved review comments; filter resolved. Read only bodies/locations needed to act.
3. **Partition before fixing.** Fan out fresh subagents per `parallel-workstreams` when comment triage, CI diagnosis, and conflict resolution are disjoint; serialize shared wiring.
4. Fix valid issues; run lint, typecheck, targeted tests per `run-lint-and-typecheck` / `verify-with-runtime`; integrate subagent diffs before push.
5. If `mergeStateStatus` is BEHIND, BLOCKED, or DIRTY: merge base into head — prefer `git fetch origin && git merge origin/{baseRefName}`; or `gh pr update-branch` then `git fetch origin && git merge origin/{headRefName}` (or ff-only pull) before push. Resolve conflicts. Rebase only if user explicitly approves force-with-lease.
6. Stage PR-scoped files only; commit; push; reply on addressed threads.
7. **Settle loop** — repeat: triage new threads while CI runs; poll `gh pr checks N --required`; fix and push.
8. **Stop when:** required checks pass AND no unresolved actionable threads — **or** explicit human blocker (permissions, product decision, ambiguous scope).

Return PR URL, CI status, review state, blockers.

## Anchored in

- isolated-worktree
- parallel-workstreams
- delegate-with-fresh-context
- clean-commits
- run-lint-and-typecheck
- verify-with-runtime
