---
name: verify-with-runtime
description: Use before declaring any change done — produce fresh runtime evidence from the actual system; stale evidence is not evidence.
---

# Verify Against Reality, Not Intent

"Should work" is not evidence. Before claiming a change is done, produce fresh runtime evidence from the actual system.

## What "done" requires, by change type

- **UI / web frontend.** Open the page in a browser using whichever browser MCP / DevTools / Playwright integration the workspace exposes, and exercise the changed flow end-to-end. Capture a screenshot or accessibility snapshot showing the expected state. Check the console for errors after each interaction, not only on first load.
- **API / backend.** Hit the endpoint against a running instance with realistic input. Paste the response. For state-changing endpoints, also show the post-call state.
- **CLI / script.** Run it with at least one real input. Paste the output, including exit code.
- **Library / pure function.** A passing test counts as evidence — but the test must fail without the change and pass with it.

## Verification gate before declaring done

If any code changed since the last evidence was gathered (a fix from review, a follow-up tweak), the previous evidence is stale. Re-run and re-paste. A green test run from after the last edit is required, not a screenshot from earlier in the session.

## Anti-rationalizations

- "I already tested it earlier." Code changed since then.
- "It's a trivial change." Trivial changes break production routinely.
- "The types check, so it's fine." Types are necessary, not sufficient.
- "I'm confident." Confidence is not evidence.

If verification is genuinely impossible in this environment (no browser available, no running server, no fixtures), say so explicitly and list what would need to be true to verify. Don't paper over it.
