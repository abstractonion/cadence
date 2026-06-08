---
name: cadence-audit
description: Apply all applicable cadence rules to the current file or staged diff and report findings.
disable-model-invocation: true
---

# Audit

You are auditing the current file or staged diff this turn against every applicable cadence rule. Do not edit anything. For each finding, name the rule, quote the offending lines, and state the concrete fix in one sentence. Group findings by severity (blocker, should-fix, nit) and skip rules that do not apply to this code — do not pad the report. End with a short verdict: clean, fix-before-ship, or rework.

## Anchored in

- self-review-before-handoff
- run-lint-and-typecheck
- verify-with-runtime
