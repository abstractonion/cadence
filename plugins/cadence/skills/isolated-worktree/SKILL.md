---
name: isolated-worktree
description: Use when multiple agents or long-running tasks need the same repo without disturbing the main checkout — create a sibling git worktree.
---

# Isolated worktree

When parallel agents, PR babysitting, or a long-running task would fight over one checkout, work in a **sibling git worktree** instead of switching branches in the main tree. The main checkout stays on whatever the user was doing.

## Naming patterns

- **PR work:** `{repo}-pr{N}` — sibling directory next to the repo root (e.g. `cadence-pr4` beside `cadence`).
- **Feature branch:** `{repo}-{branch}` with slashes replaced (e.g. `cadence-feat-workflow-extensions` for `feat/workflow-extensions`).

Pick one pattern per task and stick to it. Reuse an existing worktree when the branch matches; do not create duplicates.

## Create or reuse

1. Resolve repo root: `git rev-parse --show-toplevel`.
2. Check for an existing worktree: `git worktree list`.
3. If missing, add at the sibling path on the target branch:
   `git worktree add ../{name} {branch}` (fetch/checkout branch first if needed).
4. Confirm `git branch --show-current` inside the worktree matches intent before editing.

## Rules

- **Never disturb the main checkout** — do not `git checkout` the user's branch in the primary tree to do agent work.
- **One branch per worktree** — do not point two worktrees at the same branch for concurrent writes.
- **Surgical commits** — stage only task-scoped files per `clean-commits`; push from the worktree when the branch is ready.
- **Clean up** when done: `git worktree remove ../{name}` after the branch is merged or abandoned (confirm with the user if unsure).

## When to use

- `/own-pr` and `cadence-pr-owner` — babysit a PR without hijacking the session checkout.
- `/parallel` fan-out — parent stays in main tree; streams can run in isolated worktrees when same-repo concurrency is needed.
- Any delegated subagent that would otherwise force a branch switch in the user's working tree.

## What not to do

- Don't edit files in the main checkout while a worktree owns the same branch.
- Don't force-push or rewrite history from a worktree without explicit user approval.
- Don't leave orphan worktrees indefinitely — list and remove when the task settles.

## Anchored in

- clean-commits
