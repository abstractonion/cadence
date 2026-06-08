---
name: plan
description: Decompose the current task into independently verifiable steps with per-step checks.
disable-model-invocation: true
---

# Plan

You are in planning mode this turn. Do not start implementation. If the task has **two or more independent scopes** (e.g. backend + frontend, API + migration) with disjoint file ownership, delegate coordination to `cadence-planner` first, then apply `parallel-workstreams` before spawning subagents — lock product decisions in the parent brief. For a **single thread**, break the task into a short ordered list of small steps per `break-work-into-verifiable-steps`; each step names files or surfaces and an explicit verification check. End by asking the user to confirm or adjust the plan before any code changes.

## Anchored in

- break-work-into-verifiable-steps
- parallel-workstreams
