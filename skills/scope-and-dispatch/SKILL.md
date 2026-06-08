---
name: scope-and-dispatch
description: Use for non-trivial work — multi-file features, unknown root cause, tasks spanning areas, or when the user asks to implement, build, or spin up subagents; parent gauges scope and dependencies, then routes adequate subagents serial or parallel.
---

# Scope and dispatch

Default parent orchestration for non-trivial work. Gauge before you code or fan out; dispatch adequate capacity; integrate when streams return.

## When to run

Run for any non-trivial change: multi-file edits, unknown RCA, multiple areas or services, or an implementation/build request. **Skip** for pure questions, single-line fixes, or when the user already invoked a mode command (`cadence-investigate`, `cadence-propose`, `cadence-plan`, `cadence-dispatch`, etc.) this turn.

## 1. Gauge

Restate the goal in one sentence. Count independent workstreams. List dependencies (A blocks B). Note active modes: investigate, propose, plan, open PR, or parallel fan-out already in flight.

## 2. Route

In Cursor/Claude Code with `agents/`, delegate to `cadence-planner` etc. when subagents available; in Codex invoke `cadence-*` skills only.

- **Bug / unknown behavior** → `cadence-investigate` first; no patches until RCA.
- **Design / product choices** → `cadence-propose` per `propose-then-implement`; wait for approval before build.
- **Single thread, clear scope** → `cadence-plan` + `break-work-into-verifiable-steps`; at most one subagent if the slice is self-contained.
- **Two or more disjoint scopes** → `cadence-planner`, then `cadence-parallel` + `parallel-workstreams`.
- **Ready to land** → `cadence-shipper` or `cadence-ship`.
- **Open PR needs tending** → `cadence-own-pr`.
- **Post-parallel (N>1 returned)** → `cadence-integrate` + `verify-parallel-integration`.

## 3. Dispatch

Spin **adequate** subagents — not one agent for a large multi-area task. Non-overlapping briefs per `delegate-with-fresh-context` (goal, scope, locked decisions, verify output). Lock product decisions in the parent. Same-repo concurrency: sibling worktrees per `isolated-worktree`. On large fan-out, recommend the plan and wait for user go unless they already said implement/go.

## 4. Integrate

When N>1 subagents touched the same branch, run `verify-parallel-integration` before claiming done. New blockers → loop back to gauge and dispatch.

## Anchored in

- propose-then-implement
- parallel-workstreams
- delegate-with-fresh-context
- break-work-into-verifiable-steps
- verify-parallel-integration
- isolated-worktree
