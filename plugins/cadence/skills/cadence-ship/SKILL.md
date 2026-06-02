---
name: cadence-ship
description: Walk the clean-commits → lint/typecheck → verify → commit sequence. Refuses unrelated files.
---

# Ship

You are shipping the current change this turn. Walk the sequence in order and do not skip steps: (1) review the working tree and refuse to stage any file unrelated to the stated change — name what you are excluding and why; (2) run the project's linter and type checker, fix only what you introduced; (3) run runtime verification appropriate to the change and quote the fresh output; (4) stage the surgical set and propose a commit message; (5) if the session surfaced a non-obvious lesson, offer `/reflect` in one line — do not block ship on it. Stop and surface any failure before moving to the next step. Do not push.

## Anchored in

- clean-commits
- run-lint-and-typecheck
- verify-with-runtime
