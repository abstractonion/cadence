# Contributing to Cadence

Thanks for helping improve Cadence.

## What to change

- **Rule body:** edit `skills/<name>/SKILL.md` (source of truth).
- **Cursor globs / alwaysApply:** edit `scripts/cursor-rules.json`.
- Regenerate Cursor shims: `./scripts/sync.sh` (requires `jq`).
- Commit both `skills/` and `rules/` changes together.

## Pull requests

1. One concern per PR when possible.
2. Keep rules/skills under ~50 lines, one idea per file.
3. Note which upstream inspiration you drew from (see NOTICE.md) if applicable.
4. Do not commit secrets or project-specific paths.

## New rule checklist

1. Create `skills/<name>/SKILL.md` with `name` and `description` frontmatter.
2. Add an entry to `scripts/cursor-rules.json`.
3. Run `./scripts/sync.sh`.
4. Update the rule count table in README.md if adding a net-new rule.

## Code of conduct

See [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).
