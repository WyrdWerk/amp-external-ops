# amp-external-ops

A capability-driven skill for orchestrating [Amp](https://ampcode.com) threads, including Cursor and Claude Code external agents. Ordinary launch, steering, reading, metadata and lifecycle operations remain the foundation. The skill adds execution checks for hidden native work, delayed callbacks, Puck reporting, file-based results, inherited skills, and distinct MCP/authentication layers.

Canonical repository: **https://github.com/WyrdWerk/amp-external-ops**. The skill lives in [amp-external-ops/SKILL.md](amp-external-ops/SKILL.md).

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
| [Maintainer guidance](AGENTS.md) | Repository contribution and validation rules |

## Discover before installing

```bash
amp skill list
amp skill repositories
amp config external-agents list
```

If the skill is already available, use it. Global User/Workspace repositories, local skills and native agent catalogues are different publication surfaces. GitHub publication alone does not update an installed personal skill. Do not edit managed caches or change external-agent setup to force discovery.

For an **explicitly approved local installation**, clone and review the repository, then copy only the skill directory with the offline installer:

```bash
git clone https://github.com/WyrdWerk/amp-external-ops.git
# Inspect the checkout and scripts before running them.
bash amp-external-ops/install.sh
```

The installer targets `~/.agents/skills/amp-external-ops`, includes bundled references, performs no network/auth/account operations, and refuses to overwrite differing content or symlink destinations. It leaves existing installations under the old name intact. Identical repeats are no-ops. Account-wide publication requires separate scope authorization; follow [MIGRATION.md](MIGRATION.md).

In the tested CLI, local `amp skill add` accepted the frontmatter but omitted bundled references. Use the reviewed full-directory installer for this package, not a SKILL-only copy. This limitation was verified in disposable targets, not by modifying active skills.

## Validate without live agents

Requires Bash and Node.js; no package installation or credentials:

```bash
node scripts/validate.mjs
node tests/validate.mjs
bash -n install.sh tests/install.sh
bash tests/install.sh
git diff --check
```

The validator checks skill identity/frontmatter, links and anchors, retired guidance, and historical metadata. Installer tests use disposable homes and verify correct layout, repeat installation, and preservation of user files. They do not establish fresh-agent inheritance or live external execution. Live regression is an optional separately scoped run, not something the validator silently launches.

## Rename and safety

This repository replaces the historical `amp-thread-ops` name. Its unsupported launch-command customization and unconditional bootstrap instructions were retired. History and rollback provenance remain available, but historical command templates are not current setup instructions.

No workflow here grants permission to change providers, secrets, MCP/authentication, account settings, or external-agent setup. An auth-helper attempt is unauthorized under a no-auth task even when rejected. The dated record preserves that incident and the limits of state-change verification.
