---
name: keep-files-focused
description: Use when files grow past a few hundred lines or accumulate unrelated responsibilities — split by concern rather than adding to the large file.
---

# Keep files focused

Small, single-responsibility files are easier to read, review, and refactor.

## Guidelines

- Default soft cap for non-test source files: a few hundred lines. Beyond that, look for a split.
- One exported "thing" per file when practical (one main component, one main class, one main service).
- An already-large file is **not** an excuse to add more to it — put new logic in a focused new file and keep edits in the large file to integration/call points.
- Co-locate small helpers used in a single file at the bottom of that file, unexported. Promote them only when reused.
- Tests can be longer than source files; still split by feature/scenario when they sprawl.
