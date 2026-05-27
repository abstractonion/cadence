# Notices

This file records attribution for Cadence at the time of publish. It distinguishes
original work authored for this plugin from concepts influenced by upstream workflow
projects. See also the [Credits](./README.md#credits) section in `README.md`.

## Original work (as of v0.4.0, May 2026)

The following content in this repository is original work of the Cadence project,
authored for this plugin (MIT-licensed; see `LICENSE`):

- **`skills/`** — SKILL.md-format workflow and stack convention bodies, plus generalized
  engineering principles distilled for Cursor and other agent runtimes.
- **`rules/`** — Generated Cursor rule shims (`.mdc`) produced from `skills/` via
  `scripts/sync.sh`; same substantive bodies with Cursor-specific frontmatter.
- **`commands/`** — Slash-command workflows (for example `/propose`, `/plan`, `/verify`,
  `/ship`, `/reflect`, `/promote`, `/investigate`, `/audit`, and `/diff-check`).
- **`templates/`** — Copy-into-project stubs for learnings logs and solution docs.
- **`agents/`** — Cadence subagent definitions (planner, investigator, reviewer, shipper).
- **Plugin manifests** — `.cursor-plugin/plugin.json`, `.claude-plugin/plugin.json`,
  `scripts/cursor-rules.json`, and related packaging metadata.
- **Project documentation** — `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `PRIVACY.md`,
  `CODE_OF_CONDUCT.md`, and other top-level docs unless explicitly noted otherwise
  in this file.

None of the paths above are copies of, forks of, or verbatim excerpts from upstream
repositories. They were written for Cadence's plugin model and directory layout.

## Relationship to upstream projects

Workflow **concepts** in some skills and rules may be *influenced by* the upstream
projects listed below (loop discipline, test-first defaults, step decomposition, context
hygiene, and similar). The **expression** in `skills/`, generated `rules/`, `commands/`,
and `agents/` — wording, structure, triggers, and Cursor/Claude packaging — is Cadence's
own. The rules in this plugin are paraphrased guidance adapted for Cursor's passive-rule
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
