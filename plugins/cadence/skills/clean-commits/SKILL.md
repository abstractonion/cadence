---
name: clean-commits
description: Use when committing or pushing — keep diffs surgical, exclude unrelated changes, and verify the local branch matches the named target before pushing.
---

# Clean commits

- Before committing, list files that would be staged and exclude anything unrelated to the stated task.
- If the user names a PR or branch (e.g., "PR16"), verify the local branch matches before pushing. If not, switch or ask.
- One commit message should describe one coherent change. If the working tree spans multiple concerns, propose splitting before committing.
