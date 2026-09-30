---
name: amp-external-ops
description: "Orchestrates ordinary Amp threads and Cursor or Claude Code external-agent threads using capability discovery, CLI steering, evidence-based completion checks, MCP and skill inheritance checks, Puck correspondence, and safe cleanup. Use when launching, coordinating, inspecting, or troubleshooting Amp external agents."
metadata:
  verification_date: "2026-09-30"
  upstream: "https://github.com/WyrdWerk/amp-external-ops"
---

# Amp External Operations

Discover the session's actual capabilities, execute only authorized operations, and verify effects rather than command acceptance. Ordinary Amp thread operations are the foundation; external-agent execution and reporting require additional evidence.

Read [the dated verification record](reference/verification-2026-09-30.md) for observed versions, scope, sanitized case labels, failures, and unresolved questions. Historical results are not universal product guarantees.

## Authorization comes before capability

- The parent owns coordination and integration. A child may create threads only when its task and applicable session policy permit it. Technical CLI access does not override a delegation restriction; otherwise route the request through the parent with the exact mode key and approved size.
- Establish authorized thread creation, steering, lifecycle actions, destination, resource budget, and deletion scope. Keep a [resource ledger](reference/regression.md#resource-ledger) from the first launch, including plugin-created threads.
- Keep concrete IDs, source mappings, private run markers and exact event times in the owner's run record, not a public repository. Public summaries use neutral case labels and relative sequence without weakening findings or evidence limits.
- Default to read-only discovery. Do not change settings, model providers, routing, secrets, environment variables, MCP configuration, external-agent setup, or built-in launch/install scripts without explicit authorization.
- Do not invoke authentication helpers, initiate OAuth, reconnect integrations, or request credentials during a no-auth investigation, even if the call is expected to fail. Authentication-blocked is a result, not permission to repair it.
- Never expose secret values, headers, cookies, tokens, raw credential files, or unsanitized exports. Report auth source categories and statuses only.
- Archive only the task's disposable resources. Delete only an explicitly authorized deletion target after preserving sanitized evidence. Never delete a pre-existing thread or reset all external-agent customizations as cleanup.

## 1. Discover before choosing a route

Run read-only help and inventories in the current session:

```bash
amp --version
amp --help
amp threads --help
amp config external-agents list
amp config external-agents show cursor
amp config external-agents show claude-code
amp skill list
amp skill repositories
amp mcp list
```

Inspect native tool names and schemas separately from CLI help. When available, use `list_agent_modes` for normal modes and `manage_amp` with topic `external_agents`, operation `help` then `list` for external keys. External keys may be absent from the normal mode inventory. Resolve the exact requested key; do not substitute a model label.

| Surface | Verified capability, not a universal catalogue |
|---|---|
| Normal Amp parent | Native creation/read/wait tools; deferred `find_thread`, `send_thread_message`, `get_thread_status`, `update_thread`; authenticated CLI |
| Cursor native Amp MCP | `find_thread`, `read_thread`, `puck`, `manage_amp` only |
| Claude Code native Amp MCP | The same four tools, exposed with native naming such as `mcp__amp__read_thread` |
| External-agent Amp CLI | Launch, continue, export, archive/unarchive, and read/search routes were exercised by both agents |

Discover again if an expected tool is absent. Claude native team `SendMessage`/`ListAgents` and Cursor `Task`/`SwitchMode` are not Amp thread coordination or main-thread model selection.

## 2. Launch and steer ordinary or external threads

Use the parent creation tool when it expresses the required mode, executor, project, and size. Otherwise the authorized CLI route below was verified. External keys are `external-agent:cursor` and `external-agent:claude-code`; discover active state before using them.

```bash
amp -ox -m <verified-mode-key> -x "<unique-marker prompt>" \
  --title "<test title>" --orb-size <approved-size> \
  --no-archive-after-execute </dev/null

amp threads continue <thread-id-or-url> -ox -x "<second unique marker>" </dev/null
```

- `-ox` selects asynchronous remote execution. Capture the printed URL/ID immediately; exit 0 and a URL prove submission, not completion.
- Supply the message immediately after `-x`. Closing stdin avoids the observed external Bash continuation timeout.
- Select a project explicitly when required. A no-project probe does not prove project inheritance or cross-project behavior. The no-matching-Git-remotes warning was benign for no-project tests.
- Use the approved resource size. Primary external probes used `a1.small`; supporting normal children requested `a1.tiny`. Do not increase size without permission. Export lacked `orbSize`, so flag acceptance alone is not metadata verification of allocation.
- Normal mode is selected at creation; a continuation `-m` override was ignored. Do not generalize that observation to external model/effort changes.
- Prefer `-ox` for a server-visible probe. Do not use `createdOnServer` to infer visibility or assert that every local-client record is unshareable: plugin-created local-client records were server-readable. Ordinary local `-x` behavior was not retested in this investigation.

## 3. Verify execution, including hidden external work

For a normal child, poll `read_thread` until the exact assistant completion marker appears, then inspect `amp threads export <id>`. Immediate reads can contain only the prompt. If available, use normal `get_thread_status`/wait tools, but still check the result.

For external agents, `agentState=unknown` and user-only Amp transcripts can persist during successful native execution. Do not infer boot failure, missing credentials, idle state, or completion from those observations. Normal wait semantics are not sufficient.

At launch ask the external agent to:

1. Confirm an alive marker and record its native capabilities without exposing credentials.
2. Use only the authorized test resources and independent marker for every action.
3. Write a concise sanitized report at a specified workspace path, including IDs, requested and observed metadata, errors, continuity results, and cleanup state.
4. Attempt the supported direct-parent route and separately report to Puck only if requested. Include the same findings in its final response; do not end with only a delivery acknowledgment.

Poll the available transcript, report file, or child result within a declared budget (for example 5 to 10 second intervals, 2 minute initial budget). Those intervals are operator choices, not latency guarantees. At expiry report what is observed and still unknown; do not change authentication or setup to compensate.

Test continuity with an asymmetric codeword: supply it only in turn one, ask for the remembered value in turn two, and inspect the actual assistant answer. A marker in the user prompt is not an executed result.

### Metadata is nested and coverage differs

```bash
amp threads export <id> > <private-scratch-path>/thread.json
jq '{agentMode, executorType: .meta.executorType,
     models: [.messages[]? | .usage.model? // empty]}' <private-scratch-path>/thread.json
```

Use `agentMode`, `meta.executorType`, and assistant `usage.model` where available. The served normal model was `gpt-6-luna`; external served-model usage was unavailable. `meta.createdOnServer:false` appeared even for server-visible orbs. Sanitize before sharing; never commit raw exports.

## 4. Communicate without making Puck the bridge

Use normal Amp `send_thread_message` when actually exposed. Both external native Amp profiles lacked it. Authorized external CLI continuation of a parent or peer thread was accepted, and callback content later arrived after the active parent's final report. These callbacks were owner-authored without an external source-thread envelope.

Distinguish submission, transcript persistence, execution, and recipient receipt. Match unique markers and independently inspect results. Owner-authored receipt establishes content arrival, not authenticated source attribution. Deferred arrival is observed; queue mechanics, order guarantees, and latency are unverified. Do not resend solely because an active parent has not yet displayed an accepted callback.

When instructed to report to Puck, inspect the native `amp` namespace's `puck` schema and use the requested conversation ID:

```json
{
  "action": "send",
  "params": {
    "conversationID": "<Puck T-uuid supplied by the coordinator>",
    "message": "<unique marker, concise findings, blockers and cleanup>"
  }
}
```

The tested tool also listed `read_reply`; its semantics were not separately exercised. `puck.send` was verified for Puck, not arbitrary thread injection. Puck's external callbacks also lacked source envelopes. Preserve source distinctions and keep Puck informed at phase boundaries, not command by command.

### Report-file fallback

`download_thread_file` returned not-found for existing external report paths. A working fallback was:

1. Call the discovered `thread_file_url` tool with the source thread and exact absolute report path, following its live schema.
2. Download the returned attachment URL with `amp files get <url> -o <new-local-path>`.
3. Read and inspect the sanitized report; independently verify its consequential claims where possible.

Use a new filename if the CLI refuses overwrite. Attachment URLs expire; do not publish signed temporary URLs or treat file paths in another orb as local files. Preserve durable sanitized evidence or private thread references.

## 5. Discover skills and MCP independently

### Skills

The investigation found 37 global skills in fresh normal sessions and both external agents. Fresh external orbs automatically had the historical skill under `~/.agents/skills`; Claude mirrored the names in `~/.claude/skills`. Normal Amp used managed global caches. Cursor additionally had product skills under `~/.cursor/skills-cursor`.

Inspect personal/workspace repositories, local global directories, agent-specific directories, project paths, and built-ins. Do not infer scope from a matching name alone; compare path, origin and contents. Workspace and project paths were empty/absent in the tested no-project setup. Collision precedence, internal materialization and external restart requirements remain untested.

Check for this renamed skill before installing anything. Automatic inheritance of its predecessor does not prove this name is already published to the user's repository. Never edit managed `~/.cache/amp/global-skills` files. Installation/publication needs explicit scope authorization; see the repository migration runbook.

### MCP: registry, auth and execution are separate

Start with `manage_amp`, topic `remote_mcp_servers`, operation `help`. For authorized discovery use scoped `list-servers`, `list-tools`, `list-credential-secrets`, `detect-authentication`, and `check-server` only as needed. Checks can update discovery caches; they are not credential repairs. Do not use refresh/create/update/delete/OAuth operations in a read-only test.

```bash
amp mcp remote list --personal
amp mcp remote tools --personal <server-name-or-id>
```

Classify each server separately for registry visibility, schema readability, connection/auth status, Amp service invocation, and agent-native invocation. Only execute a schema-reviewed harmless read tool with an active required connection. Never infer invocation from `connected` or copy Amp credentials into a native agent.

Observed distinctions: personal Composio/Devin/Trybeacon were registry-visible across sessions; normal Amp Composio/Devin reads worked; `amp svc` was account-feature-gated; Trybeacon needed a linked browser; Cursor-native plugins had separate authentication; Claude-native MCP exposed only Amp. See [the MCP and selection matrix](reference/capabilities.md).

## 6. Qualify model and effort selection

Inspect help and schemas before passing options. Amp management help documents picker model selection and Claude effort per thread; values were not inspected because the browser needed sign-in. Parent creation exposed no model/effort fields. Amp `--model` was account-gated; `--effort` was unknown.

Claude's native report named Sonnet 5.5 and medium effort despite native login status being false. These are reported runtime settings, not independently verified served usage or universal defaults. Native Claude help flags do not prove Amp launch overrides. Cursor's override files were empty. Do not mutate providers, routing, environment variables, scripts or defaults to test selection without approval.

## 7. Recover and clean up only owned resources

### Wake up a blank, stuck or unknown external thread

A blank transcript, stuck-looking thread, UI-not-loading report or `agentState=unknown` is a visibility symptom, not proof of a dead orb or authentication failure. Try the existing thread before recommending replacement, within the user's steering authorization:

1. **Inspect read-only first.** Capture its exact ID, current status and available transcript, last visible activity, archive state and any explicit error or pending approval. Record a UI symptom separately from server-side evidence. Do not change configuration or dismiss an approval with a wake-up message; an archived thread requires authorized unarchive before continuation.
2. **Send one harmless follow-up to the same ID.** Use the exposed `send_thread_message` or the [existing CLI continuation route](#2-launch-and-steer-ordinary-or-external-threads), not a new thread or an orb restart. Ask for a concise status from existing context and observable blockers. For example:

   ```text
   <RUN>-WAKE. Please resume from the existing task context if available and
   reply with a concise status. Do not restart, reset, or modify files/settings
   solely for this check; do not change setup, providers, secrets, MCP or auth.
   Report any launch, environment or authentication blocker you can observe.
   If prior context is unavailable, say so rather than reconstructing it.
   ```

3. **Observe within a declared budget.** For example, check every 5–10 seconds for up to 2 minutes; these are operator choices, not product guarantees. Inspect available transcript/status, native activity, requested reply, callback or sanitized report file; owner-confirmed UI usability is evidence too, labeled as owner-reported. Acceptance or a marker only in a user message is not renewed execution. Do not flood the thread with repeated wake-ups; inspect destination state after an uncertain send before considering a retry.
4. **Reuse it if it wakes.** Preserve its ID, workspace and available evidence, and continue the authorized task in that thread. Record what actually resumed and any blocker; status may remain unknown and the server transcript may still be incomplete.
5. **Recommend replacement only after the wake-up attempt is unsuccessful.** At budget expiry, record “no renewed activity observed within the budget,” not “dead orb.” Preserve the old thread and report the limitation before proposing a separately authorized replacement. A blocked/unsafe wake-up is an unperformed check, not evidence of failure. Do not automatically create a replacement, reset, archive/delete the original, or repair credentials/settings.

A successful wake-up demonstrates resumability in that observation. It does **not** restore or prove missing prior transcript/state, remembered context or completed work. Verify continuity separately when needed. In the [dated recovery case](reference/verification-2026-09-30.md#existing-thread-wake-up-observation), the owner confirmed usability after Puck's normal follow-up; the server transcript still provided no resumed assistant activity. This is not a guarantee for every external agent or blank UI. See [failure-recovery guidance](reference/capabilities.md#failure-recovery) and the [wake-up regression checklist](reference/regression.md#existing-thread-wake-up-recovery).

### Lifecycle recovery and cleanup

```bash
amp threads archive <id>
amp threads archive <id> --unarchive
```

Continuation of an archived disposable returned `Error: This thread is archived`; unarchive then continue recovered. Verify with status metadata and explicit `archived:true id:<id>` / `archived:false id:<id>` searches. Unfiltered searches can include archived resources. Ancestry filters missed CLI-created external children; use broad unique markers plus the ledger.

Archive retains evidence and is reversible; it is not deletion and does not prove external native process termination. Test deletion only on a separately authorized dedicated disposable, preserve evidence first, then verify absence via export/status/search. Do not retry a destructive command when its outcome is unknown.

Snooze had no exposed CLI mutation in the inspected help; the older run recorded queryable state. Recheck current schemas rather than promising UI-only behavior indefinitely.

Before reporting completion, account for every child and plugin-created resource, state actual delivery and cleanup, and separate verified facts, documented behavior, reported settings, inference, and unknowns. Run the [regression checklist](reference/regression.md) only within its approved scope.
