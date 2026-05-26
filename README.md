# Cadence

## What this is

Cadence is a personal workflow plugin that packages durable engineering rules and stack conventions for use across projects and accounts, on Cursor, Claude Code, and any other runtime that consumes Cursor rules or SKILL.md skills. The name reflects what it enforces: a deliberate rhythm of investigate → propose → implement → review → ship. Rules cover how to investigate, propose changes, review your own diffs, verify against runtime, commit cleanly, and ship — plus language- and stack-scoped conventions for TypeScript, frontend, and backend work.

## What's in it

33 rules / skills organized into five groups:

| Group        | Purpose                                                                  | Count |
|--------------|--------------------------------------------------------------------------|------:|
| Workflow     | Always-on engineering loop — think, plan, build, review, test, ship      | 12    |
| Universal    | Language-agnostic principles (imports, file size, refactor completeness) | 8     |
| TypeScript   | TypeScript-only conventions (no `any`, named exports, `== null`)         | 4     |
| Frontend     | Frontend patterns (API client, query options, theme tokens, React 19)    | 4     |
| Backend      | Backend patterns (async ORM, migrations, logging, admin, infra hygiene)  | 5     |

Each principle lives in two paired places:

- `skills/<name>/SKILL.md` — SKILL.md-format skill body (Claude Code, Superpowers, and other agent runtimes), with natural-language trigger frontmatter (`name`, `description`).
- `rules/<name>.mdc` — Cursor shim carrying the same body plus Cursor-specific frontmatter (`globs` or `alwaysApply`).

## Install

### Cursor

Install via Cursor's plugin flow pointed at:

```
https://github.com/abstractonion/cadence
```

Once installed, all `.mdc` files under `rules/` are auto-discovered. Workflow rules apply on every chat; stack-scoped rules attach based on the file globs in their frontmatter.

### Claude Code

```
/plugin marketplace add abstractonion/cadence
/plugin install cadence@cadence
```

Once installed, all `SKILL.md` files under `skills/` become available to the host runtime; each skill loads when its `description` trigger matches the current task.

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

## Repository layout

```
cadence/
├── .cursor-plugin/
│   └── plugin.json              # Cursor manifest
├── .claude-plugin/
│   ├── plugin.json              # Claude Code plugin manifest
│   └── marketplace.json         # Claude Code marketplace registration
├── skills/                      # Canonical source of truth — SKILL.md format
│   ├── propose-then-implement/SKILL.md
│   ├── no-any-no-casts/SKILL.md
│   └── ... (33 total)
├── rules/                       # Cursor-only flat .mdc shims, generated from skills/
│   ├── propose-then-implement.mdc
│   ├── no-any-no-casts.mdc
│   └── ... (33 total)
├── scripts/
│   ├── cursor-rules.json        # per-rule Cursor frontmatter (globs / alwaysApply)
│   └── sync.sh                  # regenerates rules/*.mdc from skills/*/SKILL.md
├── LICENSE                      # MIT
├── README.md
└── NOTICE.md                    # upstream-source attribution
```

`skills/` is the single source of truth for rule bodies. `rules/` is a generated Cursor-only directory: each `.mdc` carries the same body wrapped with Cursor-specific frontmatter (`globs` for stack-scoped rules, `alwaysApply: true` for workflow rules). The two manifests act as filters into the same content tree — Cursor reads `rules/`; SKILL.md-aware runtimes (Claude Code, Superpowers, etc.) read `skills/` — so neither runtime sees the other's metadata, and the same principle ships to both in one repo.

## Customize

### Editing a principle

Edit the canonical body in `skills/<name>/SKILL.md`. Then regenerate the Cursor shim:

```bash
./scripts/sync.sh
```

This rewrites every `rules/*.mdc` from the matching `skills/*/SKILL.md` plus the per-rule frontmatter declared in `scripts/cursor-rules.json`. Requires `jq` (`brew install jq`).

### Adding a new rule / skill

1. Create `skills/<new-name>/SKILL.md` with `name` and `description` frontmatter (the description is a natural-language trigger sentence — see existing skills for examples).
2. Add an entry for `<new-name>` to `scripts/cursor-rules.json` with the Cursor `description` and either `alwaysApply: true` (workflow-style) or `globs: "..."` (stack-scoped).
3. Run `./scripts/sync.sh` to materialize the `rules/<new-name>.mdc` shim.
4. Commit both files together.

Keep rules under ~50 lines and one concern per file — the discipline that makes them useful is the same discipline that keeps them maintainable.

## Credits

Workflow rules draw on several upstream projects, all MIT-licensed:
[garrytan/gstack](https://github.com/garrytan/gstack) (the engineering loop and runtime-verification gate),
[obra/superpowers](https://github.com/obra/superpowers) (test-first and fresh-context delegation),
and [GSD](https://github.com/open-gsd/get-shit-done-redux) (step decomposition and context-window hygiene).
Full attribution is in [`NOTICE.md`](./NOTICE.md).
