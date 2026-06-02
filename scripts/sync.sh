#!/usr/bin/env bash
#
# Regenerate generated runtime shims from the canonical source tree.
#
# Cadence stores durable rule bodies under skills/<name>/SKILL.md. Cursor needs the same
# bodies wrapped with its own frontmatter (description + globs / alwaysApply). This script
# reads scripts/cursor-rules.json for per-rule Cursor frontmatter and writes rules/<name>.mdc.
#
# Command primers live in commands/<name>.md; sync generates Codex-friendly skills at
# skills/cadence-<name>/SKILL.md (name + description frontmatter, command body preserved).
#
# Codex installs self-contained packages from plugins/cadence/, refreshed here from skills/,
# assets/, legal files, and scripts/codex-plugin-README.md.
#
# Requires: jq.
# Usage:  ./scripts/sync.sh

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
RULES_DIR="$REPO_ROOT/rules"
SKILLS_DIR="$REPO_ROOT/skills"
COMMANDS_DIR="$REPO_ROOT/commands"
METADATA="$REPO_ROOT/scripts/cursor-rules.json"
CODEX_PLUGIN_DIR="$REPO_ROOT/plugins/cadence"
CODEX_MANIFEST_DIR="$CODEX_PLUGIN_DIR/.codex-plugin"
CODEX_README_SRC="$REPO_ROOT/scripts/codex-plugin-README.md"

if ! command -v jq >/dev/null 2>&1; then
  echo "error: jq is required (brew install jq)" >&2
  exit 1
fi

[ -f "$METADATA" ] || { echo "error: $METADATA missing" >&2; exit 1; }
[ -d "$SKILLS_DIR" ] || { echo "error: $SKILLS_DIR missing" >&2; exit 1; }
[ -d "$COMMANDS_DIR" ] || { echo "error: $COMMANDS_DIR missing" >&2; exit 1; }

# --- skills/cadence-<command>/ from commands/<command>.md ---

pruned=0
for skill_dir in "$SKILLS_DIR"/cadence-*; do
  [ -d "$skill_dir" ] || continue
  cmd_name="${skill_dir##*/cadence-}"
  if [ ! -f "$COMMANDS_DIR/$cmd_name.md" ]; then
    rm -rf "$skill_dir"
    pruned=$((pruned + 1))
    echo "removed orphaned skill → $skill_dir (no commands/$cmd_name.md)" >&2
  fi
done
if [ "$pruned" -gt 0 ]; then
  echo "pruned $pruned orphaned cadence-* skill(s)"
fi

command_skills=0
for cmd_file in "$COMMANDS_DIR"/*.md; do
  [ -f "$cmd_file" ] || continue
  cmd_name=$(basename "$cmd_file" .md)
  skill_name="cadence-$cmd_name"
  skill_dir="$SKILLS_DIR/$skill_name"

  cmd_description=$(
    awk '
      BEGIN { f = 0 }
      /^---$/ { f++; next }
      f == 1 && /^description:/ {
        sub(/^description:[[:space:]]*/, "")
        print
        exit
      }
    ' "$cmd_file"
  )
  if [ -z "$cmd_description" ]; then
    echo "warn: $cmd_file missing description — skipping $skill_name" >&2
    continue
  fi

  body=$(awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$cmd_file" | sed -e '/./,$!d')

  mkdir -p "$skill_dir"
  {
    printf -- '---\n'
    printf 'name: %s\n' "$skill_name"
    printf 'description: %s\n' "$cmd_description"
    printf -- '---\n\n'
    printf '%s\n' "$body"
  } > "$skill_dir/SKILL.md"

  command_skills=$((command_skills + 1))
done

echo "synced $command_skills command skills → $SKILLS_DIR/cadence-*/"

# --- rules/*.mdc from durable skills + cursor-rules.json ---

mkdir -p "$RULES_DIR"

names=$(jq -r '.rules | keys[]' "$METADATA")

written=0
for name in $names; do
  skill="$SKILLS_DIR/$name/SKILL.md"
  if [ ! -f "$skill" ]; then
    echo "warn: $skill missing — skipping $name" >&2
    continue
  fi

  description=$(jq -r --arg n "$name" '.rules[$n].description' "$METADATA")
  # Use has() so boolean false isn't swallowed by jq's // operator.
  always_apply=$(jq -r --arg n "$name" 'if (.rules[$n] | has("alwaysApply")) then (.rules[$n].alwaysApply | tostring) else "" end' "$METADATA")
  globs=$(jq -r --arg n "$name" '.rules[$n].globs // empty' "$METADATA")

  body=$(awk 'BEGIN{f=0} /^---$/{f++; next} f>=2{print}' "$skill" | sed -e '/./,$!d')

  out="$RULES_DIR/$name.mdc"
  {
    printf -- '---\n'
    printf 'description: %s\n' "$description"
    if [ -n "$always_apply" ]; then
      printf 'alwaysApply: %s\n' "$always_apply"
    fi
    if [ -n "$globs" ]; then
      printf 'globs: "%s"\n' "$globs"
    fi
    printf -- '---\n\n'
    printf '%s\n' "$body"
  } > "$out"

  written=$((written + 1))
done

echo "synced $written rules → $RULES_DIR"

# --- plugins/cadence/ Codex package (skills only; no commands/agents copy) ---

mkdir -p "$CODEX_PLUGIN_DIR"

find "$CODEX_PLUGIN_DIR" -mindepth 1 -maxdepth 1 ! -name ".codex-plugin" -exec rm -rf {} +

for path in skills assets LICENSE NOTICE.md PRIVACY.md SECURITY.md; do
  if [ -e "$REPO_ROOT/$path" ]; then
    cp -R "$REPO_ROOT/$path" "$CODEX_PLUGIN_DIR/$path"
  fi
done

if [ -f "$CODEX_README_SRC" ]; then
  cp "$CODEX_README_SRC" "$CODEX_PLUGIN_DIR/README.md"
else
  echo "warn: $CODEX_README_SRC missing — skipping Codex README" >&2
fi

[ -d "$CODEX_MANIFEST_DIR" ] || { echo "error: $CODEX_MANIFEST_DIR missing" >&2; exit 1; }

echo "synced Codex package → $CODEX_PLUGIN_DIR"
