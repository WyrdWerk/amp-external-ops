# Repeatable regression procedure

Run only the approved subset. Offline repository validation is safe to repeat; live thread creation, lifecycle and MCP checks need task-specific authorization. No check below grants permission to authenticate or change configuration.

## Acceptance criteria

An orchestration route passes when a uniquely marked task executes, its consequential result is independently inspected, continuity is exercised when required, and all created resources reach the declared cleanup state. A returned URL or marker present only in a user prompt is insufficient.

Use a new run prefix (for example `EXTOPS-<UTC-date>-<random-suffix>`) and distinct marker for every test. Record UTC timestamps, versions, exact requested mode, approved size, executor/project, route, and deadline. Separate observed, documented, agent-reported, inferred, blocked, and untested results.

## Before live tests

1. Inspect CLI help, current native catalogues, normal modes, external registry, skill origins, and scoped MCP registries.
2. Confirm the exact authorized actions, owner, parent/Puck identifiers, resource budget, archive targets and deletion-only target. Check delegated-session restrictions before child creation.
3. Preserve sanitized pre-test configuration metadata and native connection statuses when accessible. Do not read/print raw credential stores. If no baseline is available, record that no-change verification will be partial.
4. Start the ledger. Detect existing plugins that may create extra review threads; do not disable them or alter settings just to simplify the test.

## Ordinary-thread foundation

1. Launch one approved normal orb with a unique completion marker and codeword `amber-73` (or another new asymmetric value). Capture its ID/URL.
2. Read immediately and record whether the assistant result exists. Poll until the exact assistant marker appears or the budget expires.
3. Export to private scratch. Independently check normal mode, `meta.executorType`, assistant `usage.model`; record missing fields rather than filling them from launch arguments.
4. Continue with a second marker and ask for the remembered codeword without supplying it again. Check the actual returned value.
5. Exercise normal callback/wait only if exposed and authorized. Verify receipt/source metadata and result, not state alone.
6. Archive, verify `archived:true`, unarchive and verify `archived:false`, then rearchive. If testing archived continuation, observe its rejection before recovery.

## External-agent parity

Use Cursor as baseline, then Claude for parity and meaningful differences. Launch each with its verified external key, an approved size, and the same narrowly bounded probe contract:

```text
<RUN>-<AGENT>-START. This is a disposable capability probe.
Do not modify settings, setup, providers, secrets, environment, MCP or skills.
Do not invoke auth helpers, OAuth or reconnect, even to test a failure.
Record native/CLI tools and versions; do not expose credentials.
Use only the one authorized normal child, exact mode <KEY>, size <SIZE>.
Apply existing relevant skills without installing them. Inventory origin/path.
Launch/read/poll/export the child; remember <CODEWORD> only in turn one.
Continue once to ask for the remembered word; inspect result and metadata.
Archive/unarchive/rearchive and verify; no deletion or additional children.
Write a sanitized report to <WORKSPACE-REPORT-PATH>, including errors/IDs/state.
Report to parent <PARENT-ID> through the exposed supported workflow.
If instructed, separately report to Puck <PUCK-ID> using native amp.puck send.
Include findings in your final response, not just a delivery acknowledgment.
```

1. Capture native tool/version inventories and Amp MCP schemas. Check for the four-tool profile without assuming it remains fixed forever.
2. Check skill visibility and actual loading, without naming a skill in the prompt when testing unhinted discovery. Compare sanitized content hashes where appropriate.
3. Verify the agent's normal child independently from the parent. Use different codewords for Cursor and Claude so swapped evidence fails the test.
4. Send an authorized parent/Puck follow-up marker and inspect execution in native report/callback/child evidence. Empty Amp assistant transcripts and unknown status are not completion checks.
5. Verify direct-parent CLI callback receipt separately from exit status and Puck receipt. Allow the parent turn to settle before concluding delivery failure; don't claim bounded latency.
6. If peer coordination is authorized, send one echo-only unique marker per direction and inspect destination persistence. Do not create another task loop.
7. Recover the report using discovered file tools; if download fails, try `thread_file_url` and `amp files get` with a new destination filename. Inspect contents.

## Existing-thread wake-up recovery

Run only with steering authorization for the exact existing thread, or an approved disposable. Do not deliberately break UI, credentials, setup or an orb to induce this case. If the symptom is absent, mark it unexercised rather than claiming recovery coverage. Follow [the operating procedure](../SKILL.md#wake-up-a-blank-stuck-or-unknown-external-thread).

1. Record the ID and read-only pre-check status/transcript, last visible activity and any UI-not-loading/blank/stuck symptom. Separate owner reports from server observations; unknown status or an empty transcript is not a dead-orb/auth diagnosis.
2. Check archive state and approval/blocker metadata. Stop on an unsafe or unauthorized route; do not silently unarchive, dismiss approvals, authenticate or change settings to enable the test.
3. Send exactly one uniquely marked harmless follow-up to that same ID requesting existing-context status and observable blockers, with no restart/reset/file/config/auth change solely for the check. Record submission time and route. On uncertain delivery, inspect before considering any retry.
4. Observe read-only within a declared budget (for example 5–10 second checks, at most 2 minutes). Save separate evidence of acceptance, persistence and renewed activity. A marker in a user message alone fails the activity check; a native response/report or owner-confirmed usability must be labeled by its source. Record the actual observed delay without claiming a latency guarantee.
5. On success, verify the original ID is reused and no replacement/reset was needed in the observed sequence. Preserve the workspace and available transcript/report evidence. Resumability is the tested result; restoration of missing prior transcript/state or remembered context is not. If continuity is required, check a value provided only before the symptom, not a value resupplied in the wake-up.
6. On budget expiry, report no renewed activity observed in that window and preserve the thread. Only after an unsuccessful wake-up may replacement be recommended, with separate creation/cleanup authorization. A blocked check is not a performed failure. Do not automatically replace, archive or delete it.
7. Record what no-change verification actually covers and which evidence remains missing. Owner-confirmed recovery without server-side assistant output is a scoped observation, not independently verified execution or parity across agents. See [the dated case](verification-2026-09-30.md#existing-thread-wake-up-observation).
8. Add before/after evidence, marker, budget, result/source and existing-thread disposition to the ledger. A pre-existing user thread remains preserved and is not a disposable cleanup target.

## MCP and selection checks

- Record each layer separately: registry, schema, connection/auth category, Amp bridge, native catalogue, native read invocation. Test only a schema-reviewed harmless read. Stop at an auth or feature gate.
- Prefer scoped cached tool listings to bulk output when the latter is truncated. Do not refresh connections or retry side effects.
- Inspect model/effort help and creation schemas. Document picker-only fields, gates, native settings and served metadata separately. Testing a native flag does not establish Amp launch behavior.
- Do not induce missing-credential failures by deleting credentials or changing environment. Report the smallest future approved test instead.

## Safe edges and cleanup

Authorized safe checks can include invalid mode/ID, unsupported option, immediate read, archived search, and archived continuation. Inspect resulting state after a connection failure before deciding whether to retry a submission. Never replay a possibly executed mutation blindly.

Deletion needs a separate dedicated disposable: preserve its sanitized result first, delete only that target, then verify absence. Keep ordinary/external probes archived for review. Archival does not establish native process termination; report that limitation rather than silently issuing stop commands.

After the run, compare the accessible sanitized configuration/auth metadata with the baseline. If an auth helper was attempted, classify it as an unauthorized attempt and preserve the exact error. Rejection alone does not prove every native file unchanged. Explicitly state coverage gaps.

## Resource ledger

| ID / URL | Owner / purpose | Parent relationship | Requested mode / size | Observed executor / model | Markers / receipt | Cleanup / timestamp |
|---|---|---|---|---|---|---|
| `<T-uuid and full URL>` | `<probe or plugin>` | `<explicit or unknown>` | `<arguments>` | `<metadata or unavailable>` | `<prompt vs execution vs receipt>` | `<archived/deleted/unknown>` |

Include all children, grandchildren and automatically created plugin reviews. Broad marker search complements ancestry filters, which may miss CLI-created children. Use explicit archive filters and account for every ledger entry. Do not clean up unrelated search results.

## Final report contract

State proven routes, failures, unresolved selection/auth/inheritance questions, scope/version limits, configuration verification coverage, evidence links, each resource's cleanup, and actual delivery state. Report separately to the coordinator and Puck where requested. Do not claim global skill publication, process termination, native served usage, authenticated callback source, or passing live regression without evidence.
