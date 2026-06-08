---
name: cadence-diff-check
description: Self-review the staged diff like a stranger, with quoted evidence. Surfaces scope drift and weak claims.
---

# Diff Check

You are reviewing the current diff this turn — staged changes first, then unstaged if relevant. Read it as a stranger who does not trust the author. Flag scope drift (changes unrelated to the stated intent), incomplete refactors, missing callers, unsupported claims, and anywhere the diff promises more than it delivers. Quote the specific lines or hunks you are citing; vague review notes are not allowed. Flag any ship-ready claim that lacks a matching evidence bundle per `verify-with-runtime` (tests, runtime output, screenshots, or an explicit `blocked_reason`). Do not edit files — produce a review only, ending with a clear ship / hold verdict.

## Anchored in

- self-review-before-handoff
- verify-with-runtime
