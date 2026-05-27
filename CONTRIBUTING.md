# Contributing to Cadence

Thanks for helping improve Cadence.

## What to change

- **Rule body:** edit `skills/<name>/SKILL.md` (source of truth).
- **Cursor globs / alwaysApply:** edit `scripts/cursor-rules.json`.
- **Command:** edit `commands/<name>.md` (slash command for a single turn).
- **Subagent:** edit `agents/<name>.md` (delegated persona with a fresh context).
- Regenerate Cursor shims: `./scripts/sync.sh` (requires `jq`).
- Commit both `skills/` and `rules/` changes together.

For the full command and subagent catalogs, see the [Commands](./README.md#commands) and [Subagents](./README.md#subagents) tables in README.md — do not duplicate those tables here.

## Pull requests

1. One concern per PR when possible.
2. Keep rules/skills under ~50 lines, one idea per file.
3. Keep commands under ~25 lines and subagents under ~60 lines.
4. Note which upstream inspiration you drew from (see NOTICE.md) if applicable.
5. Do not commit secrets or project-specific paths.

## New rule checklist

1. Create `skills/<name>/SKILL.md` with `name` and `description` frontmatter.
2. Add an entry to `scripts/cursor-rules.json`.
3. Run `./scripts/sync.sh`.
4. Update the rule count table in README.md if adding a net-new rule.

## New command checklist

1. Create `commands/<name>.md` with YAML frontmatter: `name` (slash name, no leading `/`), `description` (what users see in menus and triggers — write for cross-role legibility: engineering, design, and product should each understand when to use it), and `disable-model-invocation: true` so Claude Code does not auto-invoke user-facing slash commands from description matching (Cursor may ignore unknown keys; harmless).
2. Body structure:
   - `# <Title>` — one short paragraph: what mode the agent enters this turn and what it must not do.
   - `## Anchored in` — bullet list of `skills/<name>` rule stems this command invokes (no file extension).
3. Keep the file under ~25 lines; one phase of work per command.
4. Add a row to the Commands table in README.md; the `description` in frontmatter must match the table verbatim. List bare `/name` in the table — Cursor invokes that form; Claude Code uses `/cadence:name` (see README § Commands).
5. If you are adding a new top-level directory (unlikely), declare it in `.cursor-plugin/plugin.json` and `.claude-plugin/plugin.json` under `commands`. For a new file inside the existing `commands/` directory, just add the file — the manifest already points at `./commands/`.

## New subagent checklist

1. Create `agents/<name>.md` with YAML frontmatter: `name` and `description` (menu/trigger text; same cross-role legibility as commands). Read-only subagents (no file edits) should use an explicit allowlist — `tools: Read, Grep, Glob, Bash` — per [Claude Code subagent docs](https://code.claude.com/docs/en/sub-agents); do not rely on `disallowedTools: Write, Edit` alone (that still inherits Bash, MCP, and other tools). Agent bodies should say "no file edits (Write/Edit)", not "no mutating tools", unless you also deny Bash. Mutating workflows (e.g. `cadence-shipper`) omit `tools` restrictions.
2. Body structure — all five sections, in order:
   - `# <Title>` — opening paragraph: remit, how the parent delegates, and what you refuse.
   - `## Scope` — what you do.
   - `## Out of scope` — what you refuse (include "no file edits" where applicable).
   - `## How to operate` — numbered steps the subagent follows.
   - `## Output` — what the parent gets back.
   - `## Anchored in` — bullet list of `skills/<name>` rule stems.
3. Keep the file under ~60 lines; one narrow remit per subagent.
4. Add a row to the Subagents table in README.md; frontmatter `description` must match the table verbatim.
5. If you are adding a new top-level directory (unlikely), declare it in `.cursor-plugin/plugin.json` and `.claude-plugin/plugin.json` under `agents`. For a new file inside the existing `agents/` directory, just add the file.

### cadence-planner

`cadence-planner` is for **cross-workstream coordination only** — multiple independent threads (e.g. backend + frontend + migration) with explicit dependencies and parallelism. Single-thread decomposition belongs to the `/plan` command (`/cadence:plan` in Claude Code) and `break-work-into-verifiable-steps`; if a task fits one workstream, do not extend `cadence-planner` — point users at `/plan` instead.

## Sanitization

Command and subagent bodies follow the same banned-term policy as rules and skills:

- Do not use **nstack**, **newton**, **kenley**, or **noah** (or obvious variants).
- Do not name **gstack**, **superpowers**, GSD, or other upstream projects in command/subagent bodies — attribution belongs in README, NOTICE.md, and LICENSE only.

After editing, spot-check your changes:

```bash
rg -i 'nstack|newton|kenley|noah|gstack|superpowers' CONTRIBUTING.md commands/ agents/ skills/
```

(TanStack Query in rule examples is fine; the ban is on conflated spellings and upstream product names in workflow text.)

## Code of conduct

See [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).
