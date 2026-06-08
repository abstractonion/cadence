# Cadence

## What this is

Cadence is a personal workflow plugin that packages durable engineering rules and stack conventions for use across projects and accounts, on Cursor, Claude Code, and any other runtime that consumes Cursor rules or SKILL.md skills. The name reflects what it enforces: a deliberate rhythm of investigate → propose → implement → review → test → ship → reflect. Rules cover how to investigate, propose changes, review your own diffs, verify against runtime, commit cleanly, ship, and capture cross-session learnings — plus language- and stack-scoped conventions for TypeScript, frontend, and backend work.

## What's in it

38 durable rules, plus 14 command shims (`cadence-*` skills generated from `commands/`), organized into five groups:

| Group        | Purpose                                                                  | Count |
|--------------|--------------------------------------------------------------------------|------:|
| Workflow     | Engineering loop, learnings capture, and promotion (mostly always-on)  | 17    |
| Universal    | Language-agnostic principles (imports, file size, refactor completeness) | 8     |
| TypeScript   | TypeScript-only conventions (no `any`, named exports, `== null`)         | 4     |
| Frontend     | Frontend patterns (API client, query options, theme tokens, React 19)    | 4     |
| Backend      | Backend patterns (async ORM, migrations, logging, admin, infra hygiene)  | 5     |

Each principle lives in two paired places:

- `skills/<name>/SKILL.md` — SKILL.md-format skill body (Claude Code, Superpowers, and other agent runtimes), with natural-language trigger frontmatter (`name`, `description`).
- `rules/<name>.mdc` — Cursor shim carrying the same body plus Cursor-specific frontmatter (`globs` or `alwaysApply`).

## Install

Logo: `assets/logo.svg`.

### Cursor

Install via Cursor's plugin flow pointed at:

```
https://github.com/abstractonion/cadence
```

Once installed, all `.mdc` files under `rules/` are auto-discovered. Workflow rules apply on every chat; stack-scoped rules attach based on the file globs in their frontmatter. Slash commands and subagents ship from `commands/` and `agents/` via the same plugin manifest.

### Claude Code

```
/plugin marketplace add abstractonion/cadence
/plugin install cadence@cadence
```

Once installed, all `SKILL.md` files under `skills/` become available to the host runtime; each skill loads when its `description` trigger matches the current task. Slash commands and subagents ship from `commands/` and `agents/` via the same plugin manifest.

### Codex

```
codex plugin marketplace add abstractonion/cadence
codex plugin add cadence@cadence
```

Codex loads `plugins/cadence/` via `.codex-plugin/plugin.json`. Durable rules and command primers ship as `SKILL.md` files under `skills/`. Command modes use generated skill names `cadence-<command>` — for example `cadence-plan`, `cadence-verify`, `cadence-ship` — with the same bodies as `commands/<command>.md`. Example prompts: "Use cadence-plan to decompose this into verifiable steps", "Run cadence-diff-check on my staged diff", "Use cadence-verify before we ship".

### Other runtimes

Any agent runtime that reads SKILL.md files from a directory (Superpowers, custom frameworks, etc.) can consume `skills/` directly. Drop the `skills/` directory into the runtime's skills path or follow the runtime's specific install flow.

## Precedence & conflicts

Cadence is a **baseline** of guardrails, not a replacement for repo rules or custom IDE rules.

**Order of authority** (highest first):

1. Explicit user instruction in the current chat.
2. Project/repo rules and skills (`.cursor/rules`, `AGENTS.md`, repo `SKILL.md` / skills).
3. Cadence plugin rules.

When cadence and a project rule cover the **same topic** but differ, **follow the project rule** and note the conflict once in plain English. Cadence fills gaps where the repo is silent.

Multiple rule sources can load into the same session; there is no guaranteed automatic winner besides this policy. The `prefer-project-local-rules` workflow rule encodes it for the agent.

You can **disable individual cadence rules** in Cursor Settings → Rules, or turn off the plugin for a project, if overlap is noisy.

On Claude Code and other SKILL.md runtimes, the same idea applies: repo skills override plugin skills on the same topic unless the user says otherwise.

## Cross-session memory (flywheel)

Cadence strengthens **institutional memory** without replacing propose-then-implement or verify-with-runtime. The seven-phase loop is the spine:

| Phase | Cadence |
| --- | --- |
| Think | Restate the problem; prior-art in `propose-then-implement` |
| Plan | `/plan`, `/parallel`, `parallel-workstreams`, `break-work-into-verifiable-steps` |
| Build | Smallest diff; gated by approval |
| Review | `/diff-check`, `self-review-before-handoff` |
| Test | `verify-with-runtime`, `/verify`, `/integrate`, `verify-parallel-integration` |
| Ship | `/ship`, `clean-commits`, `isolated-worktree` (on-demand, for PR/worktree isolation) |
| Reflect | `/reflect`, `capture-learnings` |

**Bootstrap in your project** (copy from this repo; paths are conventions, not plugin installs):

| Artifact | Copy from | Place in project |
| --- | --- | --- |
| Learnings log | `templates/learnings.md` | `docs/learnings.md` (preferred) or `.cadence/learnings.md` |
| Solution doc template | `templates/solutions/_template.md` | `docs/solutions/<slug>.md` per hard bug |

Agents append one lesson per `/reflect`, search learnings and solutions during Think and Investigate, and may offer `/reflect` after `/ship`. Use `/promote` when a lesson meets promotion gates and should become a rule — always with explicit approval before writing.

## Repository layout

```
cadence/
├── .cursor-plugin/
│   └── plugin.json              # Cursor manifest (rules, commands, agents)
├── .claude-plugin/
│   ├── plugin.json              # Claude Code plugin manifest
│   └── marketplace.json         # Claude Code marketplace registration
├── .agents/plugins/
│   └── marketplace.json         # Codex marketplace registration
├── skills/                      # Canonical source of truth — SKILL.md format
│   ├── propose-then-implement/SKILL.md
│   ├── no-any-no-casts/SKILL.md
│   └── ... (38 rules + 14 cadence-* command shims from sync.sh)
├── plugins/cadence/             # Self-contained Codex package, generated by sync.sh
│   ├── .codex-plugin/plugin.json
│   └── skills/
├── rules/                       # Cursor-only flat .mdc shims, generated from skills/
│   ├── propose-then-implement.mdc
│   ├── no-any-no-casts.mdc
│   └── ... (38 total)
├── templates/                   # Copy-into-project stubs (learnings log, solution docs)
├── commands/                    # User-invoked slash-command primers (single-turn modes)
├── agents/                      # Delegatable subagent personas
├── scripts/
│   ├── cursor-rules.json        # per-rule Cursor frontmatter (globs / alwaysApply)
│   └── sync.sh                  # regenerates rules/*.mdc, cadence-* skills, plugins/cadence
├── LICENSE                      # MIT
├── README.md
└── NOTICE.md                    # upstream-source attribution
```

`skills/` is the single source of truth for durable rule bodies; `commands/` is the source of truth for command primers (sync generates `skills/cadence-*/`). `rules/` is a generated Cursor-only directory: each `.mdc` carries the same body wrapped with Cursor-specific frontmatter (`globs` for stack-scoped rules, `alwaysApply: true` for workflow rules). `plugins/cadence/` is a generated self-contained Codex package. Manifests filter the same content — Cursor reads `rules/` and `commands/`; Claude Code reads the root plugin; Codex reads `plugins/cadence/`; other SKILL.md runtimes can read `skills/` directly.

## Customize

### Editing a principle

Edit the canonical body in `skills/<name>/SKILL.md` (or `commands/<name>.md` for command modes). Then regenerate shims and packages:

```bash
./scripts/sync.sh
```

This rewrites `rules/*.mdc`, `skills/cadence-*/SKILL.md`, and `plugins/cadence/` from the canonical tree plus `scripts/cursor-rules.json`. Requires `jq` (`brew install jq`).

### Adding a new rule / skill

1. Create `skills/<new-name>/SKILL.md` with `name` and `description` frontmatter (the description is a natural-language trigger sentence — see existing skills for examples).
2. Add an entry for `<new-name>` to `scripts/cursor-rules.json` with the Cursor `description` and either `alwaysApply: true` (workflow-style) or `globs: "..."` (stack-scoped).
3. Run `./scripts/sync.sh` to materialize the `rules/<new-name>.mdc` shim and refresh `plugins/cadence/`.
4. Commit both files together.

Keep rules under ~50 lines and one concern per file — the discipline that makes them useful is the same discipline that keeps them maintainable.

## Commands

User-invoked slash commands that prime the agent into a specific mode for a single turn. Each command names the phase of work it covers and anchors to the cadence rules that govern that phase. Use them when you want the agent to investigate, propose, plan, parallel, integrate, review, verify, ship, audit, reflect, promote, or tldr — without dragging in unrelated behaviour. In **Cursor**, type the bare name (for example `/propose`); in **Claude Code** after `/plugin install cadence@cadence`, use the plugin namespace (for example `/cadence:propose`).

| Command | Codex skill | Description |
| --- | --- | --- |
| `/propose` | `cadence-propose` | Surface 1–3 options before any change. For design, product, or architecture decisions where you want choices, not work. |
| `/investigate` | `cadence-investigate` | Root-cause a bug or unexpected behavior without patching. Ranks hypotheses, returns evidence, no file edits. |
| `/plan` | `cadence-plan` | Decompose the current task into independently verifiable steps with per-step checks. |
| `/parallel` | `cadence-parallel` | Partition multi-scope work, lock decisions in the parent, fan out subagents, then integrate on return. |
| `/integrate` | `cadence-integrate` | Post-parallel integration pass — survey combined diff, resolve wiring, run fresh checks. |
| `/diff-check` | `cadence-diff-check` | Self-review the staged diff like a stranger, with quoted evidence. Surfaces scope drift and weak claims. |
| `/verify` | `cadence-verify` | Run runtime verification (browser, tests, manual) on the current change before claiming done. |
| `/ship` | `cadence-ship` | Walk the clean-commits → lint/typecheck → verify → commit sequence. Refuses unrelated files. |
| `/audit` | `cadence-audit` | Apply all applicable cadence rules to the current file or staged diff and report findings. |
| `/reflect` | `cadence-reflect` | Capture one durable lesson from the session into a learnings log. |
| `/promote` | `cadence-promote` | Review the latest learnings entry against promotion gates; draft a rule diff for approval — no writes without go. |
| `/tldr` | `cadence-tldr` | One-turn compressed explanation — analogy-first, ~150 words, no code or options. |
| `/own-pr` | `cadence-own-pr` | Babysit PR #N until it settles — green required CI and actionable review addressed; ongoing loop, not a single pass. |
| `/workflow-from-chats` | `cadence-workflow-from-chats` | Mine recent chats for durable preferences and propose Cadence artifacts (rules, skills, commands, or subagents). |

*Cursor:* `/name` as listed. *Claude Code* (plugin install): `/cadence:name` (plugin `name` in `.claude-plugin/plugin.json` is `cadence`). *Codex:* invoke the `cadence-<name>` skill or use natural-language prompts (see § Codex).

## Subagents

Specialized personas the parent agent can delegate to with a fresh context window. Each subagent has a narrow remit and refuses work outside it, so the parent gets a focused report back instead of a sprawling side-quest. The descriptions are written across roles so engineering, design, and product mgmt can each find a fit for their mental model.

| Subagent | When to delegate |
| --- | --- |
| `cadence-investigator` | Bug investigation, root-cause analysis, or any task where the parent should rule out hypotheses before any code change. |
| `cadence-reviewer` | Code review on a diff before commit or push. Use when the parent needs an independent read on quality, scope, and evidence. |
| `cadence-shipper` | Final commit and verification pass before pushing. Use when the parent has working code and needs ship discipline applied. |
| `cadence-planner` | Coordination planning when a task spans multiple independent workstreams (areas, services, files) and needs explicit dependencies plus parallelism mapped. |
| `cadence-pr-owner` | Babysit a pull request until it settles — green required CI and no unresolved actionable review threads; triage, fix, push, repeat. |

## Contributing

PRs welcome. Edit `skills/<name>/SKILL.md` or `commands/<name>.md`, update `scripts/cursor-rules.json` if needed, run `./scripts/sync.sh`, and open a PR. See [CONTRIBUTING.md](./CONTRIBUTING.md) and [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).

Privacy: [PRIVACY.md](./PRIVACY.md)

## Credits

Workflow rules draw on several upstream projects, all MIT-licensed:
[garrytan/gstack](https://github.com/garrytan/gstack) (the engineering loop and runtime-verification gate),
[obra/superpowers](https://github.com/obra/superpowers) (test-first and fresh-context delegation),
and [GSD](https://github.com/open-gsd/get-shit-done-redux) (step decomposition and context-window hygiene).
Full attribution is in [`NOTICE.md`](./NOTICE.md).
