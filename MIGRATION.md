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
3. Select the latest source `main`, record its commit and review that fixed revision as described in AGENTS.md. Read the installed predecessor and its repository history. Copy the whole reviewed `amp-external-ops/` package, including all references and wake-up/recovery guidance, not just SKILL.md. Compare origin, path and contents to detect collisions.
4. Remove/rename the predecessor only with approval for that migration and after preserving a rollback commit. Verify all bundled links and frontmatter.
5. Validate, commit and push to the explicitly authorized global scope, then reload skills in the current normal Amp session where supported. Verify resolved origin/resources and report any masking copy without deleting it. Report reload as unperformed if unavailable; do not compensate with setup/auth changes. Fresh Cursor/Claude inheritance must be reported as unverified unless actually tested; external restart behavior is not guaranteed.

Do not install/update skills to repair an investigation unless that class of change is authorized. Never write into the managed `~/.cache/amp/global-skills` cache or alter external setup scripts.

## Retired deployment record

The previous runbook prescribed unsupported launch-command customization and unconditional remote shell bootstrap. That guidance is removed. [deploy/originals.json](deploy/originals.json) preserves the old captured templates as historical, non-executable data with a warning. It is not a current settings backup or a restoration recipe. Current management exposes post-install hooks; no hook is required by this package.

The previous canonical content remains in Git history at [7e317be](https://github.com/WyrdWerk/amp-external-ops/commit/7e317bebb4d44ac07fca19b84ce4f4b5c5b1b98f). It contains obsolete guidance; inspect it for provenance, not for operational deployment.

## Privacy cleanup and history limits

Public notes now use neutral case labels and relative sequence instead of concrete thread identifiers/links, private run markers, content fingerprints and wall-clock event times. Findings, versions, authorization limits and cleanup outcomes remain intact. Keep the original source mapping and detailed evidence outside this public repository.

Use an existing verified contributor GitHub `noreply` identity for both author and committer of future public commits. A repository-local email setting can prevent ordinary Git commands from reusing a contact address without changing Amp account/global identity; verify the resulting commit metadata because environment overrides can supersede configuration. Do not add a concrete source thread ID as a commit trailer.

The separately owner-authorized history cleanup reviewed all seven earlier commits. Five commit IDs changed; the two earliest commits already had no targeted disclosures and retain their IDs. Historical Markdown snapshots were redacted individually, without inserting later findings into earlier commits. Private source-thread trailers were removed, contact author/committer addresses were replaced with the contributor's verified public GitHub `noreply` identity, and Amp assistance attribution was retained without an email trailer. File layout, modes, chronological sequence and substantive findings remain intact. Ordinary Git commit dates and public contributor identity remain visible; this is scoped redaction, not anonymous authorship.

Before publication, the process preserves a complete Git bundle and old-to-new commit map in restricted owner-controlled storage outside the public checkout, scans reachable historical contents and commit metadata, runs the offline suite, and uses an explicit force-with-lease against the inspected remote tip. Only `main` is the authorized push target; any additional published ref or concurrent remote change requires inspection before proceeding. Verify remote refs and a fresh clone after publication. Never publish the original bundle or map in a backup branch/tag: they preserve the removed disclosures.

A rewritten branch cannot guarantee removal from existing clones, forks, GitHub cached commit pages, unreachable provider objects or other copies. Do not promise complete erasure or contact a provider without authorization. Retain the private backup independently of this execution environment if long-term recovery is required.

Existing clones will diverge where history changed. Prefer a fresh clone. Preserve unpublished work privately, inspect it for disclosures, and reapply only the reviewed changes onto the new `main`; do not merge or push the old branch back. Do not blindly reset a dirty checkout. Previously pinned source revisions may need a new reviewed pin; rewriting this repository does not update an installed personal/workspace skill.

## Rollback without account resets

- Published content: review and create a revert commit for the migration commit(s), validate, then push only with authorization for the target. Review the revert for disclosures before publication. Do not restore redacted history, force-push or erase investigation evidence as ordinary rollback.
- History cleanup: use the restricted original bundle and commit map for private inspection/recovery only. Restoring any original public history requires separate explicit approval because it would republish removed disclosures; preserve collaborators' new work and inspect the current remote before proposing that action.
- Repository name: a reverse rename is a separate external action requiring explicit approval and permission; verify conflicts and repository identity first. Do not silently recreate the old repository.
- Local installation: restore the inspected backup of the exact authorized directory. Do not remove unrelated skills or symlink targets.
- Global publication: revert the specific global repository commit and push only with that destination's authorization, then reload. Leave workspace/team skills alone if they were not part of the migration.
- External-agent/MCP/provider settings: this migration does not touch them, so it supplies no reset command. If an earlier deployment changed settings, reconstruct an exact approved patch from a trusted current baseline rather than executing the historical templates or resetting all customizations.
