# amp-external-ops

A capability-driven skill for orchestrating [Amp](https://ampcode.com) threads, including Cursor and Claude Code external agents. Ordinary launch, steering, reading, metadata and lifecycle operations remain the foundation. The skill adds execution checks for hidden native work, delayed callbacks, Puck reporting, file-based results, inherited skills, and distinct MCP/authentication layers.

Canonical repository: **https://github.com/WyrdWerk/amp-external-ops**. The skill lives in [amp-external-ops/SKILL.md](amp-external-ops/SKILL.md).

## Ask your Puck to install it

Paste this into **your own Puck conversation**:

```text
Install the latest revision from the main branch of https://github.com/WyrdWerk/amp-external-ops into my personal Amp User Skills repository and publish the reviewed installation there.

Read README.md and follow the installation runbook in AGENTS.md. Discover my repository and permissions, inspect and pin the source revision, and preserve the complete amp-external-ops package, including all reference files and the latest wake-up/recovery guidance.

Preserve existing skills. If a conflicting copy exists, ask before replacing or removing it. Do not modify providers, secrets, MCP, authentication, account settings, or external-agent setup. Do not trigger login or OAuth to work around a blocker.

Validate the complete package, commit and push only to my personal Amp User Skills repository, then reload skills where supported. Verify the resolved skill origin and bundled resources; report any local copy that masks the published version without deleting it.

Return the destination repository and scope, source revision, published commit, validation results, reload/discovery results, and any blocker or unverified behavior. Do not claim fresh Cursor/Claude Code inheritance unless it was actually tested.

If Puck needs an executor, use an authenticated normal Amp thread in my account and report the results back to this Puck conversation.
```

This request authorizes publication to **your personal skills repository**, not this GitHub repository, another user's repository, or your workspace. Puck must inspect the skill before publishing it. If its capabilities or permissions cannot complete the route, it should prepare the change and report the exact remaining step rather than bypass authentication or change account settings.

For **another skill**, replace the source URL and selected skill name. A repository may contain a root skill, nested skill, or several skills; Puck must locate `SKILL.md`, read its frontmatter, and confirm which package to install. The installation runbook covers Git repositories/local packages and shared Amp skill URLs. It is a reusable procedure, not a promise that every skill is safe or compatible with every hosted destination.

Choose a different scope explicitly if needed:

| Requested scope | Destination and effect |
|---|---|
| Personal User Skills | Requesting user's global repository; push publishes across Amp environments |
| Workspace Skills | Explicitly named workspace repository; admin/write permission required; affects teammates |
| Project only | `.agents/skills/<name>/` in the named checkout; commit/push only if requested |
| This machine only | Reviewed full package in a local skill directory; not account-wide or durable across fresh orbs |

See [AGENTS.md: Puck installation runbook](AGENTS.md#puck-installation-runbook) for source review, exact copy/publication steps, verification, conflict handling and rollback. GitHub publication of this package alone does not install it into your account. Existing local skills may mask a newly published skill with the same name.

## What the evidence supports

September 30, 2026 probes showed that both external agents could independently launch, poll, read, continue and archive normal Amp children. Their own Amp status remained `unknown` and their native assistant output did not appear in Amp transcripts. Direct-parent CLI callback content eventually arrived, owner-authored without source-thread envelopes. Fresh external orbs already inherited the predecessor skill; no bootstrap was needed.

These findings are account/version-specific. Requested mode is not served model; connected MCP is not invocable MCP; callback acceptance is not receipt; archival is not native-process termination. The skill requires current capability discovery and explicit authorization rather than promising universal behavior.

## Read by task

| Document | Purpose |
|---|---|
| [Skill](amp-external-ops/SKILL.md) | Operating workflow and safety boundaries |
| [Capability matrices](amp-external-ops/reference/capabilities.md) | Cursor/Claude, MCP, skills, communication and selection |
| [Verification record](amp-external-ops/reference/verification-2026-09-30.md) | Durable evidence, late corrections, incident and resource ledger |
| [Regression procedure](amp-external-ops/reference/regression.md) | Repeatable authorized live checks and report contract |
| [Migration and rollback](MIGRATION.md) | Rename, installation/publication scopes and recovery |
| [Puck installation runbook and maintainer guidance](AGENTS.md) | Install this or another skill safely; repository contribution rules |

## Discover before installing

```bash
amp skill list
amp skill repositories
amp config external-agents list
```

If the skill is already available, use it. Global User/Workspace repositories, local skills and native agent catalogues are different publication surfaces. GitHub publication alone does not update an installed personal skill. Do not edit managed caches or change external-agent setup to force discovery.

For an **explicitly approved local installation**, clone and review the repository, then copy only the skill directory with the offline installer:

```bash
git clone --branch main https://github.com/WyrdWerk/amp-external-ops.git
git -C amp-external-ops rev-parse HEAD
# Inspect the checkout and scripts before running them.
bash amp-external-ops/install.sh
```

The installer targets `~/.agents/skills/amp-external-ops`, includes bundled references, performs no network/auth/account operations, and refuses to overwrite differing content or symlink destinations. It leaves existing installations under the old name intact. Identical repeats are no-ops. Account-wide publication requires separate scope authorization; follow [MIGRATION.md](MIGRATION.md).

In the tested CLI, local `amp skill add` accepted the frontmatter but omitted bundled references. Use the reviewed full-directory installer for this package, not a SKILL-only copy. This limitation was verified in disposable targets, not by modifying active skills.

## Validate without live agents

Requires Bash, Git and Node.js; no package installation or credentials:

```bash
node scripts/validate.mjs
node tests/validate.mjs
bash -n install.sh tests/install.sh tests/runbook.sh
bash tests/install.sh
bash tests/runbook.sh
git diff --check
```

The validator checks skill identity/frontmatter, links and anchors, retired guidance, and historical metadata. Installer tests use disposable homes and verify correct layout, repeat installation, and preservation of user files. Runbook tests execute the documented copy/publication blocks against a disposable local bare Git repository, checking complete packages, no-op repeats, conflicts, symlinks, dirty clones, invalid destinations and another skill name. No test publishes to Amp or GitHub. These checks do not establish fresh-agent inheritance or live external execution. Live regression is an optional separately scoped run, not something the validator silently launches.

## Rename and safety

This repository replaces the historical `amp-thread-ops` name. Its unsupported launch-command customization and unconditional bootstrap instructions were retired. History and rollback provenance remain available, but historical command templates are not current setup instructions.

No workflow here grants permission to change providers, secrets, MCP/authentication, account settings, or external-agent setup. An auth-helper attempt is unauthorized under a no-auth task even when rejected. The dated record preserves that incident and the limits of state-change verification.
