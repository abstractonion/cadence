---
name: loop
description: Use for any non-trivial change to move it through the seven-phase engineering loop — think, plan, build, review, test, ship, reflect.
---

# The Engineering Loop

Every non-trivial change moves through seven phases. Skipping a phase is a choice — name which one and why.

1. **Think** — restate the problem before touching code. Who is this actually for? What's the smallest version that delivers value? What is the user already doing as a workaround? See `propose-then-implement`.
2. **Plan** — pick an approach with eyes open. Note data flow, edge cases, failure modes, and the tests that would prove it works. Surface hidden assumptions instead of guessing past them. Single-thread decomposition: `break-work-into-verifiable-steps` or `/plan`. Multi-workstream coordination (disjoint scopes, explicit dependencies): delegate to `cadence-planner`, then partition fan-out per `parallel-workstreams`.
3. **Build** — implement with the smallest diff that cleanly expresses the change. Don't refactor adjacent code unless the structural fix is the whole point.
4. **Review** — read your own diff like a stranger before handing it off. See `self-review-before-handoff`.
5. **Test** — verify against reality, not intent. Return the evidence bundle per `verify-with-runtime` (library: `test_name` + red/green output; UI: flow + console; API/CLI: `exit_code` + output; blocked: `blocked_reason`). Stale evidence from earlier in the session does not count.
6. **Ship** — clean commits, accurate description, fresh evidence at the moment of push. See `clean-commits`. When a PR already exists for this branch, hand off ongoing settle to `/own-pr` (`cadence-own-pr`) instead of a one-shot push-and-exit.
7. **Reflect** — name one durable lesson before moving on. See `capture-learnings`.

When a bug shows up, the loop is the same — Think (what is actually happening?) → Plan (one hypothesis at a time) → Build (smallest fix) → Review/Test/Ship/Reflect. See `investigate-before-fixing` for the bug-specific gates.

The cost of doing the complete thing is much lower than it used to be. Default to it.
