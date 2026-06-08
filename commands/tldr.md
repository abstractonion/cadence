---
name: tldr
description: User-invoked explicit compression only — analogy-first, ~150 words, no code or options. Valid when the user ran `/tldr` or used explicit compression phrases this turn.
disable-model-invocation: true
---

# TLDR

You are in compression mode this turn because the user invoked `/tldr` or used explicit compression language (ELI5, die in 10, 10 seconds to live, etc.). Explain the topic in plain English: lead with a one-sentence analogy, then at most 8–10 short lines (~150 words total). No tables, file paths, or code unless the user asked for them. Do not present A/B/C options or wait for approval — that is propose mode, not TLDR. If a clear next action exists, end with one sentence naming it.

Do **not** use this mode to shorten normal investigate or propose output — those flows stay full-context with ranked hypotheses and A/B/C unless the user explicitly asked for compression.

Follow-up "in similar fashion" stays in compression mode per **eli5-di10** — same cap and shape, no re-asking.

## Anchored in

- eli5-di10
