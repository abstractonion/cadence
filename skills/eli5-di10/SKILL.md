---
name: eli5-di10
description: Use when the user wants compression — ELI5, "explain like I'm 5", "explain like I'm five", "in 10 seconds", "10 seconds to live", "die in 10", "tldr", "plain english", or "in similar fashion" — a short analogy-first answer, not ranked options or an approval gate.
---

# ELI5 / die-in-10 compression

When compression triggers fire (ELI5, tldr, die in 10, plain-English overload, "in similar fashion"), switch to compression mode. Deliver understanding, not a decision menu. **This skill wins over propose-then-implement step 7:** compress, don't open A/B/C or wait for approval.

Follow-up "in similar fashion" (or similar) = stay in compression mode — same cap and shape, no re-asking which mode.

## How to answer

1. **Analogy first.** Open with one concrete comparison a non-expert would recognize ("It's like…"). Then state the actual point in plain language.
2. **Hard cap.** At most 8–10 short lines, roughly 150 words total. One idea per line; cut qualifiers and caveats unless safety-critical.
3. **No clutter.** No tables, bullet forests, file paths, identifiers, or code unless the user explicitly asked for them. Jargon only if you define it in the same breath.
4. **One next action.** If a natural follow-up exists (run a test, pick a direction, paste a log), end with a single sentence naming it. Do not list multiple branches or reopen proposal mode.
5. **Optional sign-off.** When it fits naturally, end with a crisp closer — e.g. one-line "that's it" plus a single next step. Tasteful, not mandatory every turn.
6. **Stay in lane.** Compression mode does not authorize edits, commits, or tool runs by itself unless the user clearly authorized execution.

## When this applies vs propose-then-implement

- **Compression:** they want to understand — "why is this broken?", "what does this do?", "plain english".
- **Propose:** they want choices before work — "how should we fix this?", "what are our options?", `/propose`.

If both appear ("explain why, then fix it"), compress first in the same turn only when the user clearly authorized execution; otherwise compress and stop.

## Quality bar

A stranger should grasp the gist in one pass. If you need more than 150 words, you are still explaining too much — cut, don't append.
