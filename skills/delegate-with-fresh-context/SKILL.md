---
name: delegate-with-fresh-context
description: Use when a subtask is self-contained or parallelizable — delegate it to a fresh subagent with a precise brief instead of dragging conversation context forward.
---

# Delegate with fresh context

When a task is well-scoped and doesn't need the running conversation to succeed, hand it off to a fresh subagent. The subagent gets a clean context window and exactly what it needs; your main context stays lean and focused on orchestration.

## When to delegate

- The task is independent — a self-contained bug fix, a focused refactor, one piece of investigation that doesn't depend on conversation history.
- The work is parallelizable — multiple independent failures, investigations, or build tasks can run concurrently rather than sequentially.
- The task would otherwise pull large files, long stack traces, or unrelated history into the main context just to do one thing.

## What the brief must include

- **Goal.** One sentence stating what success looks like.
- **Scope.** Exact files or directories the subagent should touch or read. Constrain what it must NOT change.
- **Context.** Paste the specific snippets, errors, or facts it needs — don't make it re-derive what you already know by re-reading large files.
- **Expected output.** Concrete: a fix plus a passing test, a summary with `file:line` references, a list of root causes.

## What not to do

- Don't dispatch a subagent with "figure out what's wrong" and no scope — it will get lost.
- Don't dispatch parallel subagents that touch the same files — they'll conflict. Same branch with disjoint scopes: partition per `parallel-workstreams` first.
- Don't trust a subagent's "done" report without checking the diff and re-running its verification fresh (see `verify-with-runtime`).

## After it returns

Integrate the work the same way you'd review your own diff (see `self-review-before-handoff`): quote evidence, run the verification fresh, surface scope drift, and resolve conflicts before claiming done.

**Multiple subagents on the same branch.** When two or more subagents have returned on one branch, do not claim done from per-stream reports alone. Run `verify-parallel-integration` on the combined diff: survey overlaps and wiring, resolve duplicate registrations, then run lint, typecheck, and tests fresh (see `verify-with-runtime`).
