---
name: plan
description: Decompose the current task into independently verifiable steps with per-step checks.
disable-model-invocation: true
---

# Plan

You are in planning mode this turn. Do not start implementation.

If the task has **two or more independent scopes** (e.g. backend + frontend, API + migration) with disjoint file ownership:

- **Cursor/Claude Code** (`agents/` available): prefer delegating coordination to the `cadence-planner` subagent, then apply `parallel-workstreams` before spawning subagents — lock product decisions in the parent brief.
- **Codex / no subagents**: use `cadence-parallel` + `parallel-workstreams` — run inline coordination (mirror `/parallel`):
  1. List workstreams (2–5) with one-sentence outputs and exact allowed paths per stream.
  2. Map dependencies; mark fan-out or serialize; call out shared files and critical path.
  3. Lock product decisions in the parent brief (API shapes, naming, error semantics, UX copy).
  4. Write per-stream briefs: **Goal**, **Scope** (paths + must-not-touch), **Locked decisions**, **Verify output**.

For a **single thread**, break the task into a short ordered list of small steps per `break-work-into-verifiable-steps`; each step names files or surfaces and an explicit verification check. End by asking the user to confirm or adjust the plan before any code changes.

## Anchored in

- break-work-into-verifiable-steps
- parallel-workstreams
- cadence-parallel
