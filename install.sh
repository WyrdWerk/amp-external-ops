#!/usr/bin/env bash
# Explicit local installation from a reviewed checkout. No network or account writes.
set -euo pipefail

if [ "$#" -gt 1 ]; then
  echo 'Usage: bash install.sh [reviewed-repository-directory]' >&2
  exit 1
fi
SOURCE="${1:-$(cd "$(dirname "$0")" && pwd)}"
SKILL="$SOURCE/amp-external-ops"
DEST="${HOME}/.agents/skills/amp-external-ops"

if [ ! -f "$SKILL/SKILL.md" ]; then
  echo "Missing source skill: $SKILL/SKILL.md" >&2
  exit 1
fi
if [ -L "$DEST" ]; then
  echo "Refusing symlink destination: $DEST" >&2
  exit 1
fi
if [ -e "$DEST" ]; then
  if [ -d "$DEST" ] && diff -qr "$SKILL" "$DEST" >/dev/null; then
    echo "amp-external-ops already installed: $DEST"
    exit 0
  fi
  echo "Refusing to overwrite $DEST; inspect and back it up before an approved replacement." >&2
  exit 1
fi

mkdir -p "${HOME}/.agents/skills"
cp -R "$SKILL" "$DEST"
echo "amp-external-ops installed: $DEST"
