---
name: self-review-before-handoff
description: Use before declaring a change ready for review — read your own diff like a stranger, surface scope drift and completeness gaps, and calibrate claims with quoted evidence.
---

# Self-Review Before Handoff

Before declaring a change ready for the user (or for a PR), read your own diff like a stranger reading it for the first time. Most issues that survive into review survive because the author never re-read.

## Self-review checklist

- **Diff scan.** Read every changed line. If anything is unclear at first read, it's unclear in review too — fix it now.
- **Scope drift.** Anything in the diff that isn't part of the stated task? Either justify it in one line or remove it.
- **Completeness gaps.** New code path with no test? New error case with no handler? New config with no default? Surface or fill the gap.
- **Adjacent breakage.** New enum value, new status, new field — search for every place sibling values are handled and confirm the new one is too. This is the one check where reading outside the diff is mandatory.
- **Drive-by wins.** If you noticed something off outside your scope, flag it (one sentence) instead of fixing it silently in this diff.

## Confidence calibration

When raising a concern or claiming something is broken, quote the line that motivates it (`path/to/file.ts:42` plus the actual text). If you can't quote it, you haven't verified it — say so explicitly.

| Claim                          | Required evidence                          |
|--------------------------------|--------------------------------------------|
| "This is broken"               | Quoted code + reproduction or failing test |
| "This might be broken"         | Quoted code + the specific concern         |
| "This is a smell"              | Pattern name + one example                 |
| "I think but didn't check"     | Say so explicitly; don't bury it           |

## Completion status

Close the work with one of: **DONE** (verified), **DONE_WITH_CONCERNS** (list them), **BLOCKED** (state blocker + what was tried), **NEEDS_INPUT** (state exactly what).
