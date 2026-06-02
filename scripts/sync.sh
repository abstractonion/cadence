#!/usr/bin/env bash
#
# Regenerate generated runtime shims from the canonical source tree.
#
# Cadence stores rule bodies once, under skills/, in Claude-Code-compatible SKILL.md format
# (frontmatter: name + description-as-trigger). Cursor needs the same bodies wrapped with
# its own frontmatter (description + globs / alwaysApply). This script reads
# scripts/cursor-rules.json for the per-rule Cursor frontmatter, strips each SKILL.md's
# frontmatter, and writes rules/<name>.mdc with the assembled output.
#
# Codex installs plugins from self-contained marketplace package directories, so this also
# refreshes plugins/cadence from the repo's canonical runtime artifacts.
#
# Requires: jq.
# Usage:  ./scripts/sync.sh

set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
RULES_DIR="$REPO_ROOT/rules"
SKILLS_DIR="$REPO_ROOT/skills"
METADATA="$REPO_ROOT/scripts/cursor-rules.json"
CODEX_PLUGIN_DIR="$REPO_ROOT/plugins/cadence"
CODEX_MANIFEST_DIR="$CODEX_PLUGIN_DIR/.codex-plugin"

if ! command -v jq >/dev/null 2>&1; then
  echo "error: jq is required (brew install jq)" >&2
  exit 1
fi

[ -f "$METADATA" ] || { echo "error: $METADATA missing" >&2; exit 1; }
[ -d "$SKILLS_DIR" ] || { echo "error: $SKILLS_DIR missing" >&2; exit 1; }

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

  # Strip the SKILL.md frontmatter (the first two --- markers and everything between them);
  # then drop any leading blank lines so we don't compound blank lines under the new frontmatter.
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

mkdir -p "$CODEX_PLUGIN_DIR"

find "$CODEX_PLUGIN_DIR" -mindepth 1 -maxdepth 1 ! -name ".codex-plugin" -exec rm -rf {} +
for path in skills commands agents templates assets README.md LICENSE NOTICE.md PRIVACY.md SECURITY.md; do
  if [ -e "$REPO_ROOT/$path" ]; then
    cp -R "$REPO_ROOT/$path" "$CODEX_PLUGIN_DIR/$path"
  fi
done

[ -d "$CODEX_MANIFEST_DIR" ] || { echo "error: $CODEX_MANIFEST_DIR missing" >&2; exit 1; }

echo "synced Codex package → $CODEX_PLUGIN_DIR"
