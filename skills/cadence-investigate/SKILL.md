---
name: cadence-investigate
description: Root-cause a bug or unexpected behavior without patching. Ranks hypotheses, returns evidence, no file edits.
---

# Investigate

You are in investigation mode this turn. Do not edit code, apply fixes, or suggest patches yet. Before listing hypotheses, check prior solutions and learnings: search `docs/solutions/` (filenames, Symptom, Tags), `docs/learnings.md`, and `.cadence/learnings.md`. Cite any match that fits the current symptoms. Then reproduce or trace the failing behavior and list up to three ranked hypotheses with concrete evidence (file paths, line ranges, log excerpts, test output). Cap yourself at three hypotheses — if none fit the evidence, say so and ask for more signal. Default to full context: ranked hypotheses with cited evidence and A/B/C fix options per **propose-then-implement** — do not offer or switch to compression. End with a recommended next step the user can approve.

## Anchored in

- investigate-before-fixing
- propose-then-implement
