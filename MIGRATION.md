# Rename, publication and rollback

The canonical repository and frontmatter name are now `amp-external-ops`, replacing historical `amp-thread-ops`. This is a repository/skill-package migration, not permission to modify an Amp account or external-agent environment.

## Repository rename

Authorized migration: GitHub `WyrdWerk/amp-thread-ops` → `WyrdWerk/amp-external-ops`. Use the repository's authenticated management API/UI with a name-only rename; preserve visibility, default branch, issues, security and other settings. Verify the returned repository identity rather than treating an accepted request as completion. Do not create a replacement repository or change permissions to work around missing access.

GitHub content publication is separate from personal/workspace skill publication. After the rename, update the checkout's origin to the verified canonical URL:

```bash
git remote set-url origin https://github.com/WyrdWerk/amp-external-ops.git
git remote -v
```

This changes only the local checkout. Check the canonical remote and pushed commit before claiming delivery. Existing historical URLs are provenance, not active installation targets. Recheck upstream redirect behavior rather than assuming it for every integration.

## Optional local installation

First inspect `amp skill list`, `amp skill repositories` and agent-native skill paths. Fresh external probes automatically inherited the predecessor; don't add a bootstrap to their launch commands.

Only after explicit local-install authorization, review the checkout and run `bash install.sh [reviewed-checkout-directory]`. The script copies `amp-external-ops/` into `~/.agents/skills/amp-external-ops`, including references. It makes no account/settings/network changes and leaves the predecessor directory untouched. Identical installation is a no-op; differing content or a symlink is rejected.

Local `amp skill add` in the tested CLI copied only SKILL.md into a disposable target. It parsed the package name but dropped `reference/`. Do not substitute that path for whole-package installation; verify the destination contents after any other installation method.

If replacing a local installation, inspect and back up that exact directory outside skill discovery before a separately approved move/removal. Do not delete it merely because the new name exists. Local rename/replacement is not tested global inheritance; native restart/reload requirements remain unverified. Use Amp's `reload_skills` tool after an approved active-skill change, not CLI listing as a substitute.

## Optional personal or workspace publication

Publish only when the user explicitly authorizes the named global repository destination. A GitHub push does not grant that scope.

For an executable Puck procedure covering this package and other skill layouts, use [AGENTS.md: Puck installation runbook](AGENTS.md#puck-installation-runbook). It discovers the requesting user's scope and credentials, preserves full packages, stops on conflicts, publishes only when authorized, and verifies discovery.

1. Use `amp skill repositories` to discover scope, clone URL and write permission. Prefer User scope unless Workspace is explicitly requested.
2. Use the canonical repository cache clone prescribed by the current building-skills guidance. Preserve any existing work; don't blindly reset a dirty clone.
3. Read the installed predecessor and its repository history. Copy the whole reviewed `amp-external-ops/` package, not just SKILL.md. Compare origin, path and contents to detect collisions.
4. Remove/rename the predecessor only with approval for that migration and after preserving a rollback commit. Verify all bundled links and frontmatter.
5. Commit and push to the explicitly authorized global scope, then reload skills in the current normal Amp session. New-thread inheritance should be tested separately; external restart behavior is not guaranteed.

Do not install/update skills to repair an investigation unless that class of change is authorized. Never write into the managed `~/.cache/amp/global-skills` cache or alter external setup scripts.

## Retired deployment record

The previous runbook prescribed unsupported launch-command customization and unconditional remote shell bootstrap. That guidance is removed. [deploy/originals.json](deploy/originals.json) preserves the old captured templates as historical, non-executable data with a warning. It is not a current settings backup or a restoration recipe. Current management exposes post-install hooks; no hook is required by this package.

The previous canonical content remains in Git history at [7e317be](https://github.com/WyrdWerk/amp-external-ops/commit/7e317bebb4d44ac07fca19b84ce4f4b5c5b1b98f). It contains obsolete guidance; inspect it for provenance, not for operational deployment.

## Rollback without account resets

- Published content: review and create a revert commit for the migration commit(s), validate, then push only with authorization for the target. Do not force-push or erase investigation evidence.
- Repository name: a reverse rename is a separate external action requiring explicit approval and permission; verify conflicts and repository identity first. Do not silently recreate the old repository.
- Local installation: restore the inspected backup of the exact authorized directory. Do not remove unrelated skills or symlink targets.
- Global publication: revert the specific global repository commit and push only with that destination's authorization, then reload. Leave workspace/team skills alone if they were not part of the migration.
- External-agent/MCP/provider settings: this migration does not touch them, so it supplies no reset command. If an earlier deployment changed settings, reconstruct an exact approved patch from a trusted current baseline rather than executing the historical templates or resetting all customizations.
