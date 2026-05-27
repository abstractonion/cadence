---
name: investigate
description: Root-cause a bug or unexpected behavior without patching. Ranks hypotheses, returns evidence, no file edits.
disable-model-invocation: true
---

# Investigate

You are in investigation mode this turn. Do not edit code, apply fixes, or suggest patches yet. Reproduce or trace the failing behavior, then list up to three ranked hypotheses with the concrete evidence (file paths, line ranges, log excerpts, test output) that supports or weakens each. Cap yourself at three hypotheses — if none fit the evidence, say so and ask for more signal. End with a recommended next step the user can approve.

## Anchored in

- investigate-before-fixing
- propose-then-implement
