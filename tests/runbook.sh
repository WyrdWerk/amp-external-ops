#!/usr/bin/env bash
# Exercise the actual documented blocks. All Git destinations are disposable/local.
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
# Isolate fixtures from the user's Git identity, hooks and signing configuration.
export HOME="$TMP/home" GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null
export GIT_AUTHOR_NAME='Runbook Test' GIT_COMMITTER_NAME='Runbook Test'
export GIT_AUTHOR_EMAIL='runbook@example.invalid' GIT_COMMITTER_EMAIL='runbook@example.invalid'
mkdir -p "$HOME"
sed -n '/^# puck-copy-package$/,/^```$/p' "$ROOT/AGENTS.md" | sed '$d' > "$TMP/copy.sh"
sed -n '/^# puck-publish-package$/,/^```$/p' "$ROOT/AGENTS.md" | sed '$d' > "$TMP/publish.sh"
test -s "$TMP/copy.sh"
test -s "$TMP/publish.sh"
bash -n "$TMP/copy.sh" "$TMP/publish.sh"

git init --quiet --bare --initial-branch=main "$TMP/remote.git"
git init --quiet --initial-branch=main "$TMP/global"
export GLOBAL="$TMP/global" SKILL_SOURCE="$ROOT/amp-external-ops" SKILL_NAME=amp-external-ops
git -C "$GLOBAL" remote add origin "$TMP/remote.git"
mkdir -p "$GLOBAL/amp-thread-ops"
printf '%s\n' 'Preserve predecessor' > "$GLOBAL/amp-thread-ops/SKILL.md"
git -C "$GLOBAL" add -- amp-thread-ops
git -C "$GLOBAL" commit --quiet -m 'Fixture baseline'
bash "$TMP/copy.sh"
bash "$TMP/publish.sh"
PUBLISHED=$(git -C "$GLOBAL" rev-parse HEAD)
test "$PUBLISHED" = "$(git --git-dir="$TMP/remote.git" rev-parse main)"
diff -qr "$SKILL_SOURCE" "$GLOBAL/$SKILL_NAME"
grep -qx 'Preserve predecessor' "$GLOBAL/amp-thread-ops/SKILL.md"
test -z "$(git -C "$GLOBAL" status --porcelain)"
echo 'PASS: full real package published locally; references and predecessor preserved'

bash "$TMP/copy.sh"
bash "$TMP/publish.sh" > "$TMP/repeat.log"
grep -qx 'No changes; nothing to publish' "$TMP/repeat.log"
test "$PUBLISHED" = "$(git -C "$GLOBAL" rev-parse HEAD)"
echo 'PASS: identical repeat creates no commit or push'

git clone --quiet "$TMP/remote.git" "$TMP/conflict"
export GLOBAL="$TMP/conflict"
printf '%s\n' 'User customization' >> "$GLOBAL/$SKILL_NAME/SKILL.md"
git -C "$GLOBAL" add -- "$SKILL_NAME"
git -C "$GLOBAL" commit --quiet -m 'Fixture customization'
cp "$GLOBAL/$SKILL_NAME/SKILL.md" "$TMP/customized.md"
if bash "$TMP/copy.sh" > "$TMP/conflict.log" 2>&1; then
  echo 'FAIL: differing destination accepted' >&2; exit 1
fi
cmp "$TMP/customized.md" "$GLOBAL/$SKILL_NAME/SKILL.md"
test -z "$(git -C "$GLOBAL" status --porcelain)"
echo 'PASS: committed conflicting content rejected and preserved'

git clone --quiet "$TMP/remote.git" "$TMP/symlink"
export GLOBAL="$TMP/symlink"
mv "$GLOBAL/$SKILL_NAME" "$TMP/symlink-target"
ln -s "$TMP/symlink-target" "$GLOBAL/$SKILL_NAME"
git -C "$GLOBAL" add -- "$SKILL_NAME"
git -C "$GLOBAL" commit --quiet -m 'Fixture symlink'
if bash "$TMP/copy.sh" > "$TMP/symlink.log" 2>&1; then
  echo 'FAIL: symlink destination accepted' >&2; exit 1
fi
test -L "$GLOBAL/$SKILL_NAME"
diff -qr "$SKILL_SOURCE" "$TMP/symlink-target"
echo 'PASS: symlink destination rejected; target untouched'

git clone --quiet "$TMP/remote.git" "$TMP/dirty"
export GLOBAL="$TMP/dirty"
printf '%s\n' 'Unrelated user work' > "$GLOBAL/unrelated.txt"
if bash "$TMP/copy.sh" > "$TMP/dirty.log" 2>&1; then
  echo 'FAIL: dirty clone accepted' >&2; exit 1
fi
grep -qx 'Unrelated user work' "$GLOBAL/unrelated.txt"
diff -qr "$SKILL_SOURCE" "$GLOBAL/$SKILL_NAME"
echo 'PASS: dirty clone rejected; unrelated work preserved'

export GLOBAL="$TMP/not-a-repository"
mkdir -p "$GLOBAL"
if bash "$TMP/copy.sh" > "$TMP/nonrepo.log" 2>&1; then
  echo 'FAIL: Git failure treated as clean status' >&2; exit 1
fi
test ! -e "$GLOBAL/$SKILL_NAME"
echo 'PASS: non-repository destination rejected without copying'

export GLOBAL="$TMP/global" SKILL_NAME='../escaped'
if bash "$TMP/copy.sh" > "$TMP/name.log" 2>&1; then
  echo 'FAIL: path traversal name accepted' >&2; exit 1
fi
test ! -e "$TMP/escaped"
echo 'PASS: invalid path-like name rejected'

export SKILL_SOURCE="$TMP/another-source" SKILL_NAME=another-skill
mkdir -p "$SKILL_SOURCE/reference"
printf '%s\n' '---' 'name: another-skill' 'description: Fixture.' '---' > "$SKILL_SOURCE/SKILL.md"
printf '%s\n' 'Bundled alternate resource' > "$SKILL_SOURCE/reference/note.md"
bash "$TMP/copy.sh"
bash "$TMP/publish.sh"
diff -qr "$SKILL_SOURCE" "$GLOBAL/another-skill"
test "$(git -C "$GLOBAL" rev-parse HEAD)" = "$(git --git-dir="$TMP/remote.git" rev-parse main)"
echo 'PASS: another skill name and root-style staged package published locally'
