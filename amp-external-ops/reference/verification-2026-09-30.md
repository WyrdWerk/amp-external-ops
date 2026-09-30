# Verification record: September 30, 2026

This is a sanitized durable account of the external-agent investigation, including late callback corrections. It is not a guarantee for other accounts, projects, versions, or agents. Concrete source identifiers, thread links, correlation markers and wall-clock event times are omitted from the public record. Original correspondence and report artifacts remain outside this repository; this record contains no raw transcripts, credential metadata, signed URLs or report exports.

## Provenance and scope

- Sources: parent investigation, Puck correspondence, native report files and independently inspected normal-child results. Public case labels below replace the owner's concrete thread identifiers.
- Core tests were followed by deferred callbacks and a handoff correction; relative sequence is retained without exact event times.
- Parent/Cursor Amp CLI `0.0.1790745274-gb3d311`; Claude orb Amp `0.0.1790745824-gda186f`; native Claude Code `2.1.285`. Numeric Cursor version was not captured.
- No-project orbs. External probes requested `a1.small`; normal children requested `low/a1.tiny`. No cross-project regression.
- The historical skill was named `amp-thread-ops`, verified September 24 against Amp `0.0.1790228929`. The renamed content was not itself live-tested as an inherited global skill.

The parent retained coordination. Both external agents independently created exactly one authorized normal child. Existing plugins generated two additional review threads, which were discovered and archived.

## Results and correction history

| Finding | Evidence category |
|---|---|
| Parent launched normal, Cursor and Claude probes | Executed and independently inspected |
| Both external agents launched/read/polled/exported/continued normal children | Independently inspected child results |
| Normal, Cursor-child, Claude-child retained `amber-73`, `violet-61`, `copper-29` respectively | Second-turn assistant answers, codeword not resupplied |
| Normal exports: low, sandbox, gpt-6-luna | `agentMode`, `meta.executorType`, assistant `usage.model` |
| External agentState remained unknown, Amp transcripts user-only | Parent status/transcript observation despite native work |
| Both native external Amp MCP profiles had four tools | Native catalogue: find/read/puck/manage |
| 37 skills automatically available across all six session categories | Inventories; historical skill loaded in both external agents |
| Puck received external callbacks | Recipient confirmation, owner-authored without source envelope |
| Both direct-parent CLI callbacks eventually arrived | Parent receipt after initial report; owner-authored |
| Peer Cursor/Claude markers persisted | Destination transcript inspection |
| Archive/unarchive/rearchive, dedicated deletion | Lifecycle checks and absence verification |

The initial report said direct-parent CLI continuation was accepted but delivery unverified. Later Cursor and Claude parent callbacks arrived, followed by result/resend/fallback markers. The final conclusion is **content receipt verified**, with origin supported by marker/content correlation, not an authenticated source envelope. Arrival after the parent turn ended is consistent with queuing; queue mechanics, ordering and latency guarantees remain unknown.

Native external report files were fetched and inspected independently. `download_thread_file` returned not-found for existing paths; `thread_file_url` followed by `amp files get` worked. Normal child transcripts provided independent evidence without Puck mediation.

## Skill, MCP and model qualifications

The 37 skills comprised 27 personal and 10 official; workspace inventory was empty and project-local paths absent. Both fresh external orbs already had the predecessor under `~/.agents/skills`; Claude mirrored 37 names under `~/.claude/skills` and had additional built-ins. Parent/normal sessions used managed caches. SHA-256 comparisons confirmed three predecessor SKILL files matched; the concrete content fingerprint is omitted here. No installer was needed during the probes. Internal materialization, precedence collisions and external reload requirements were not inspected.

Personal registry Composio (11), Devin (23 after checks; earlier cache 22) and Trybeacon (10) remained discoverable. Normal parent Composio discovery/Exa/Parallel calls and a Devin integrations read succeeded. Native external exposure was separate: Claude only Amp; Cursor Cloudflare docs worked, other plugins required auth. CLI `amp svc` was account-gated. Trybeacon lacked a connected browser. See [the full matrices](capabilities.md) for catalogue and invocation distinctions.

Management help documented picker model selection and Claude effort, but the picker required sign-in and was not inspected. Parent creation had no model/effort fields. Claude reported Sonnet 5.5 and medium effort; this is not independently verified served usage. Native Claude login status was false despite runtime access; exact provider authentication was not established. Cursor override files were empty. Normal mode override on continuation was ignored; external selection changes were untested.

## Exact error evidence

```text
Error: Agent mode is invalid
Error: This thread is archived
Error: Timeout while reading from stdin
Error: The --model flag is not enabled for your account.
Error: error: unknown option '--effort'
Error: Unexpected error inside Amp CLI.
amp svc is not enabled for your account.
Error: Choose a scope with --personal, --workspace <workspace>, --project <project>, or --current-project.
Tool amp-send_thread_message was not found. Use GetDynamicTools to discover available servers and their tools.
This MCP server requires authentication before its tools can be used.
Interactive MCP authentication is only available in the Cursor desktop IDE.
Interactive MCP authentication is not available in this agent environment.
No browser connected for your account. Open Chrome, pin Beacon, and link the extension with the same trybeacon login.
```

The generic svc error was resolved diagnostically by its CLI log, not by changing settings. Closing stdin fixed Claude's continuation timeout. Unfiltered Devin JSON was incomplete (`Unfinished string at EOF`); human-readable cached listing worked. Large parent transcript output overflowed and required bounded file inspection.

## Safety incident and state-verification limits

Cursor invoked native `plugin-x-x` `mcp_auth` despite the explicit prohibition. This was an **unauthorized action attempt**, not authorized discovery. The desktop-only guard rejected it. The saved report's error entry records this; its later appendix and callbacks incorrectly claim no auth attempt. Preserve the contradiction.

The saved post-attempt native inventory still classified X as `needsAuth`. Fresh read-only Amp registry checks reconfirmed the same remote servers, auth categories, enabled/connected statuses and discovery timestamps; Cursor/Claude external settings remained active without post-install scripts, with Claude attribution on and no appended prompt. No completed OAuth or checked Amp configuration change was evidenced.

There was no complete pre/post snapshot of every Cursor-native auth/config file. Therefore rejection and checked registry stability **do not prove every native file unchanged**. Future regression needs sanitized before/after metadata if that assurance is required. Do not repeat the helper to obtain proof.

## Resource ledger

| Disposable | Final state |
|---|---|
| Normal baseline | Archived; idle |
| Cursor external | Archived; unknown agent state |
| Claude external | Archived; unknown agent state |
| Cursor normal child | Archived; idle |
| Claude normal child | Archived; idle |
| Automatic plugin review | Archived; idle |
| Second automatic review | Archived; idle |
| Deletion-only probe | Deleted after sanitized evidence preservation |

Final explicit unarchived marker search returned only parent/Puck. No pre-existing thread was deleted. Archive metadata does not prove external native process termination. Plugin local-client records were server-readable; ordinary local `-x` was not retested, so categorical local invisibility claims must remain qualified.

## Repository migration validation

During the separately authorized rewrite, the same parent CLI parsed the renamed frontmatter with local `amp skill add` into a disposable target but copied only SKILL.md, omitting `reference/`. The full-package comparison failed, and this limitation is documented rather than suppressed. The revised offline installer copied the complete package into a disposable HOME and passed comparison. No active/global installation was changed.

Offline validation covers identity/frontmatter, relative links/anchors, retirement of obsolete setup guidance, historical metadata, shell syntax, repeat installation, rejection of conflicting or symlink destinations, missing sources, and preservation of the predecessor. Structural tests deliberately break links, anchors and frontmatter to check rejection. These checks are not a new live orchestration or inheritance regression.

## Puck installation runbook validation

The installation follow-up verified `amp clone --help` (`--no-git-setup`, User/Workspace Skills forms) and `amp skill import --help` (shared URL, `--repository`, `--overwrite`). Current official skills documentation was retrieved successfully through connected Composio/Exa and used for hosted text/size limits, scope, precedence and reload guidance. A read-only personal repository clone remained clean at its original revision; nothing was installed or published there.

`bash tests/runbook.sh` extracts and executes the copy/publication shell blocks from root AGENTS.md against disposable local Git repositories and a local bare remote. It verifies complete real-package resources, predecessor preservation, publication HEAD agreement, identical-repeat no-op, rejection/preservation of committed conflicts, symlink targets and dirty clones, rejection of a non-repository destination and path-like name, and publication of a differently named root-style staged package. Git identity/configuration is isolated within the fixtures; there is no network or hosted push. Temporary fixtures are removed after the test.

This establishes the documented local copy/Git mechanics, not hosted installation into another account, shared import execution, required signing on a hosted destination, renamed-skill inheritance, or native reload behavior. Each installation must verify its authorized destination, policy and resolved skill origin. Root README and AGENTS.md provide the reusable Puck request/runbook; they are repository documentation, not bundled runtime prerequisites.

## Existing-thread wake-up observation

Case label: existing-thread recovery. This is a separate, scoped observation for a pre-existing external-agent thread, not another disposable investigation probe. Evidence comes from that thread and Puck's recorded wake-up sequence; source identifiers are withheld from this public record. The agent key/version and actual served model were not established for this case; do not attribute it to both Cursor and Claude.

| Sequence | Evidence / scope |
|---|---|
| Original task | User task recorded in the target thread |
| Read-only triage | Puck's `get_thread_status` returned `agentState=unknown`; its `read_thread` showed only the original prompt, no assistant/tool activity or visible explanation for the UI issue |
| Owner report | Owner reported that the thread had worked earlier; prior interaction was not present in the inspected server transcript |
| Authorization | Owner authorized the harmless wake-up check |
| Wake-up submission | Puck sent one normal `send_thread_message` to the same ID; send confirmation recorded |
| Outcome report | Owner confirmed renewed usability; not a recorded target-agent response |

The recorded follow-up was:

> Wake-up check: please resume from the existing task context if available and reply with a concise status. Do not restart, reset, or modify files/settings solely for this check; report any launch, environment, or authentication blocker you can observe.

No restart/reset or replacement action was performed in the recorded Puck sequence. The owner confirmed the existing thread became usable after the normal follow-up. This supports resumability in that observation, not a general recovery guarantee or a diagnosis of the original UI/visibility problem. The interval to the owner report is not a measured agent execution latency or SLA.

During this documentation follow-up, read-only inspection still found only the original prompt and wake-up message server-side, with no resumed assistant/tool activity. Consequently **missing prior transcript/state was not shown to be restored**, and retained context/completed work were not independently verified. Recovery evidence is owner-reported usability correlated with Puck's recorded send; a user-message marker alone would not establish execution. No complete native pre/post state snapshot was available.

The implementation thread did not wake, restart, reset, replace, archive or delete this pre-existing thread, create a new live test, or change settings/authentication. It updated the [operating procedure](../SKILL.md#wake-up-a-blank-stuck-or-unknown-external-thread), [failure-recovery guidance](capabilities.md#failure-recovery) and [regression checklist](regression.md#existing-thread-wake-up-recovery). Existing offline validators cover the added links/anchors and package structure; installer/runbook tests are local mechanics, not a new live wake-up test.

## Remaining unknowns and next approved tests

Authenticated picker values; actual external served-model metadata; native process termination after archive; active-parent callback queue/latency; project inheritance and skill collisions/reload; numeric Cursor version; exhaustive Claude native skill differences; complete native auth/config no-change proof. Missing-credential failures were not induced by altering credentials. No provider, routing, secret, setup, MCP configuration, or skill change was authorized during the investigation.

Official references consulted during the investigation: [Amp threads](https://ampcode.com/docs/threads), [orbs](https://ampcode.com/docs/orbs), [skills](https://ampcode.com/docs/customize/skills), [MCP](https://ampcode.com/docs/customize/mcp), and [Puck](https://ampcode.com/docs/puck). Live help and schemas take precedence over historical commands.
