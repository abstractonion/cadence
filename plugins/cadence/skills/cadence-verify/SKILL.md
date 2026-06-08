---
name: cadence-verify
description: Run runtime verification (browser, tests, manual) on the current change before claiming done.
disable-model-invocation: true
---

# Verify

You are in runtime verification mode this turn. Pick the cheapest path that exercises the change end to end — relevant tests, a build, a script, a browser step, an API call — and run it now. Return an evidence bundle per `verify-with-runtime` (library: `test_name` + red/green output; UI: flow + console; API/CLI: `exit_code` + output; blocked: `blocked_reason`). Stale evidence from earlier in the session does not count.

## Anchored in

- verify-with-runtime
