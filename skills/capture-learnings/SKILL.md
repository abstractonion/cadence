---
name: capture-learnings
description: Use after shipping a change, fixing a non-trivial bug, or finishing a debugging session — name one durable lesson the next session would benefit from knowing.
---

# Reflect: Capture One Durable Lesson

After a change ships, a bug is fixed, or a debugging session ends — name one thing the next session would benefit from knowing. This is the difference between a session that compounds and one that resets.

## When to reflect

- After fixing a non-trivial bug (especially if it took more than one hypothesis).
- After shipping a feature whose design surprised you mid-implementation.
- After a review surfaced a class of issue you hadn't been watching for.
- When you noticed an undocumented constraint, a project-specific gotcha, or a recurring footgun.

## What a useful learning looks like

A learning has four parts, even if it fits on one line:

- **Pattern or pitfall** — what to do, or what to avoid.
- **Where it applies** — which file/module/area, or which class of change.
- **Why** — the underlying reason, not just the symptom.
- **Confidence** — observed in this session (high) vs. inferred (lower). Be honest.

Example: "When adding a new status to the `OrderState` enum, also update `notifyOnTransition()` in `notifications/order.ts` — the dispatch table is keyed by enum and silently no-ops on unknown values. Observed: missed in the original change, caught in QA."

## Where it lands

Choose the lightest durable home:

- A line in `TODOS.md` if it's a follow-up task.
- A new or amended rule/skill if it's a recurring pattern worth enforcing.
- A short comment next to the surprising code, if the lesson is local.
- The PR description itself, if the lesson is about this PR's context.

If this is the third time touching a problem in the same area, surface that — the fix is probably structural, not local.
