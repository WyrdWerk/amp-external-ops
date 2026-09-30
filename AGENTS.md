# Maintainer guidance for amp-external-ops

This repository is a skill and documentation package, not an account provisioning script. Preserve ordinary Amp thread operations and the evidence-driven Cursor/Claude workflows. Discover current capabilities rather than introducing unconditional installers or setup mutations.

## Boundaries

- A documentation change does not authorize installation, global skill publication, live thread creation, authentication, or account-wide changes. Follow the user's stated destinations and approvals.
- Never alter Amp settings, providers, secrets, environment variables, MCP configuration or built-in external-agent setup as part of repository maintenance.
- Do not invoke auth helpers to test failures. If blocked, record the exact sanitized error and stop that route.
- Do not reset external agents or execute historical command templates. [deploy/originals.json](deploy/originals.json) is retained for provenance only.
- Never commit raw transcripts, exports, credentials or temporary signed URLs. Private evidence links and sanitized summaries are sufficient.
- Preserve unexpected user edits; use reviewable commits and never rewrite published history as rollback.

## Editing

The loadable package is `amp-external-ops/`, with frontmatter name matching that directory. Keep `SKILL.md` concise and use `reference/` for detailed matrices, dated evidence and live regression. Update README, metadata, installer paths and migration notes consistently.

Label results as verified, documented, agent-reported, inference, blocked or unknown. Do not strengthen a reported native model into verified served usage; a received owner-authored callback into source authentication; or an archive into process termination. Preserve late corrections and the unauthorized auth-attempt incident.

Scope verification notes by date, CLI/native versions, account/project context and resource budget. Test renamed skill inheritance only in an explicitly authorized live run. Other external agents are not covered by the Cursor/Claude evidence.

## Offline verification

```bash
node scripts/validate.mjs
node tests/validate.mjs
bash -n install.sh tests/install.sh
bash tests/install.sh
git diff --check
```

Installer tests must use disposable HOME directories, preserve conflicting content, and perform no network or authentication. Keep the package dependency-free unless a demonstrated requirement justifies adding tooling.

## Publication and rollback

Follow [MIGRATION.md](MIGRATION.md). GitHub push, repository rename, local installation, and global User/Workspace publication are distinct authorizations. Commit/push only to the requested destination; never edit managed global caches. Use a revert commit for published content, preserve local backups, and obtain explicit approval for any reverse repository rename or global publication.
