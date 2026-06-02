---
name: cadence-diff-check
description: Use when the user asks for Cadence diff-check mode or wants a self-review of current changes.
---

# Cadence Diff Check

Review the current diff like an independent reviewer. Focus on behavior changes, scope drift,
missing tests, risky assumptions, and claims that are not backed by evidence. Quote concrete file
paths and line numbers where possible. Findings should lead the response, ordered by severity. If
there are no findings, say that clearly and note any residual verification gaps.

Anchored in `self-review-before-handoff`.
