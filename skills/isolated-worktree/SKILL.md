---
name: isolated-worktree
description: Use when parallel same-repo agents need separate checkouts — sibling worktree at {repo}-pr{N} or {repo}-{branch}; never disturb the main tree.
---

# Isolated worktree

When multiple agents work on the same repository concurrently, give each its own git worktree at a sibling path. Never edit, commit, or rebase in the user's main checkout while an isolated agent owns a stream.

## Path convention

- PR work: `{parent-dir}/{repo}-pr{N}` (e.g. `cadence-pr42`)
- Branch work: `{parent-dir}/{repo}-{branch}` (e.g. `cadence-feat-auth`)

Use the directory name of the repo root as `{repo}`.

## Steps

1. **Create or reuse.** Run `git worktree list`. If the sibling path exists and is on the expected branch, reuse it; otherwise `git worktree add <path> <branch>`.
2. **Confirm branch.** Before any edit, verify `git branch --show-current` matches the named PR or feature branch. Switch or ask if mismatched (see `clean-commits`).
3. **Work only in the sibling.** All reads, writes, commits, and pushes happen in the isolated worktree — not the main checkout.
4. **Remove when done.** After the stream settles and changes are merged or abandoned, `git worktree remove <path>` and prune if needed. Do not leave stale siblings indefinitely.

## What not to do

- Don't run parallel agents in the same checkout — they will stomp each other's working tree.
- Don't assume the sibling path is on the right branch without checking.
- Don't commit unrelated files from the isolated tree (see `clean-commits`).

## Anchored in

- clean-commits
