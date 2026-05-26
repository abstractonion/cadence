# Notices

The workflow rules under `skills/` (and the matching `rules/` shims) are inspired by several upstream
projects. The rules in this plugin are paraphrased guidance adapted for Cursor's passive-rule
model and Claude Code's SKILL.md format; no source project is vendored or modified here.

## gstack

The Think → Plan → Build → Review → Test → Ship → Reflect loop and the
runtime-verification gate are inspired by the loop principles in
[garrytan/gstack](https://github.com/garrytan/gstack) (MIT, © 2026 Garry Tan).
gstack itself is a separate project for Claude Code.

## Superpowers

The test-first-by-default discipline and the delegate-with-fresh-context
pattern are inspired by skills in
[obra/superpowers](https://github.com/obra/superpowers)
(MIT, © 2025 Jesse Vincent) — specifically `test-driven-development`,
`subagent-driven-development`, and `dispatching-parallel-agents`.
Superpowers is a separate skills framework for Claude Code and several
other coding-agent runtimes.

## GSD

The step-decomposition guidance and the context-window-hygiene rule are
inspired by content in the GSD (Get Shit Done) project
(MIT, © 2025 Lex Christopherson). Originally released at
[gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done);
the active fork as of this writing is
[open-gsd/get-shit-done-redux](https://github.com/open-gsd/get-shit-done-redux),
which is what the rules in this plugin were derived from. GSD itself is a
separate spec-driven workflow CLI for Claude Code and other coding-agent
runtimes.
