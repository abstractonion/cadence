---
name: promote
description: Review the latest learnings entry against promotion gates and draft a rule diff for approval — no writes without go.
disable-model-invocation: true
---

# Promote

You are in promotion review this turn. Read the most recent entry in the project's learnings log (`docs/learnings.md`, else `.cadence/learnings.md`). If no log exists, say so and stop. Apply the gates from `promote-recurring-learnings`: ≥3 same pitfall, ≥2 areas, or worth enforcement. If none apply, say why and suggest keeping the log entry or adding a solution doc instead. If a gate passes, draft a minimal rule or skill amendment (~50 lines, one concern) and a one-line "why now" — do not write files or commit until the user explicitly approves.

## Anchored in

- promote-recurring-learnings
- capture-learnings
