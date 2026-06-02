---
name: cadence-investigate
description: Use when the user asks for Cadence investigate mode or wants root-cause analysis without patches.
---

# Cadence Investigate

Use investigation mode for this turn. Do not edit code, apply fixes, or suggest patches yet. Before
listing hypotheses, search `docs/solutions/`, `docs/learnings.md`, and `.cadence/learnings.md` for
prior related symptoms or lessons. Cite any relevant match. Then reproduce or trace the behavior and
list up to three ranked hypotheses with concrete evidence such as file paths, line references, log
excerpts, or test output. If no hypothesis fits the evidence, say so and ask for more signal. End
with a recommended next step the user can approve.

Anchored in `investigate-before-fixing` and `propose-then-implement`.
