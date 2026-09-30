#!/usr/bin/env bash
# Offline behavioral checks. HOME is disposable; no real installation is changed.
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
export HOME="$TMP/home"
SOURCE="$TMP/source"
DEST="$HOME/.agents/skills/amp-external-ops"
mkdir -p "$SOURCE/amp-external-ops/reference" "$HOME/.agents/skills/amp-thread-ops"
printf '%s\n' '---' 'name: amp-external-ops' 'description: Fixture.' '---' > "$SOURCE/amp-external-ops/SKILL.md"
printf '%s\n' 'Reference fixture' > "$SOURCE/amp-external-ops/reference/note.md"
printf '%s\n' 'Preserve old installation' > "$HOME/.agents/skills/amp-thread-ops/SKILL.md"

bash "$ROOT/install.sh" "$SOURCE"
cmp "$SOURCE/amp-external-ops/SKILL.md" "$DEST/SKILL.md"
cmp "$SOURCE/amp-external-ops/reference/note.md" "$DEST/reference/note.md"
test ! -d "$DEST/.git"
test ! -d "$DEST/amp-external-ops"
grep -qx 'Preserve old installation' "$HOME/.agents/skills/amp-thread-ops/SKILL.md"
echo 'PASS: correct skill layout, bundled references, legacy installation preserved'

bash "$ROOT/install.sh" "$SOURCE"
cmp "$SOURCE/amp-external-ops/SKILL.md" "$DEST/SKILL.md"
echo 'PASS: identical repeat installation'

printf '%s\n' 'User customization' >> "$DEST/SKILL.md"
cp "$DEST/SKILL.md" "$TMP/expected"
if bash "$ROOT/install.sh" "$SOURCE" > "$TMP/conflict.log" 2>&1; then
  echo 'FAIL: installer overwrote a differing destination' >&2
  exit 1
fi
cmp "$TMP/expected" "$DEST/SKILL.md"
echo 'PASS: conflicting installation rejected without overwriting'

export HOME="$TMP/missing-source-home"
if bash "$ROOT/install.sh" "$TMP/missing-source" > "$TMP/missing.log" 2>&1; then
  echo 'FAIL: missing source accepted' >&2
  exit 1
fi
test ! -e "$HOME/.agents/skills/amp-external-ops"
echo 'PASS: missing source rejected without installation'

export HOME="$TMP/symlink-home"
mkdir -p "$HOME/.agents/skills" "$TMP/symlink-target"
printf '%s\n' 'Preserve symlink target' > "$TMP/symlink-target/SKILL.md"
ln -s "$TMP/symlink-target" "$HOME/.agents/skills/amp-external-ops"
if bash "$ROOT/install.sh" "$SOURCE" > "$TMP/symlink.log" 2>&1; then
  echo 'FAIL: symlink destination accepted' >&2
  exit 1
fi
test -L "$HOME/.agents/skills/amp-external-ops"
grep -qx 'Preserve symlink target' "$TMP/symlink-target/SKILL.md"
echo 'PASS: symlink destination and target preserved'
