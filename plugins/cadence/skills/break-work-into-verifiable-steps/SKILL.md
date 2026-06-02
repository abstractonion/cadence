---
name: break-work-into-verifiable-steps
description: Use when planning a multi-file or multi-concern change — break it into small steps with explicit files, edits, and verification commands per step.
---

# Break work into verifiable steps

A multi-file or multi-concern change is a sequence of small steps, not one heroic edit. Each step should be independently runnable, independently verifiable, and — when shipping incrementally — independently revertable.

## When this applies

The change touches more than one file's primary logic, spans multiple commits, or has more than one acceptance criterion. For tiny single-file edits, just do it.

## Each step has

- **Files.** Exact paths created or modified.
- **What changes.** The actual code or the precise edit — not "add appropriate handling" or "wire it up".
- **How to verify.** The command to run (test, build, manual check) and what passing looks like.
- **A commit boundary.** When shipping incrementally, each step lands as its own focused commit (see `clean-commits`).

## Don't

- Don't write a step as "TBD" or "similar to step N" — every step must stand on its own; the next reader may not be reading top-to-bottom.
- Don't skip the verify line. "Should work" is not verification (see `verify-with-runtime`).
- Don't start step N+1 until step N's check passes. A failing step gets fixed before moving on, not deferred to the end.

## Why

A sequence of small verified steps is recoverable when something goes wrong: you can point at the last green step and restart from there. A single 800-line diff is not. Steps also make handoff trivial — anyone (including a future session) can pick up at the next unchecked item without re-deriving the plan.
