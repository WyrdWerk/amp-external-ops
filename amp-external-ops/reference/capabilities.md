# Capability matrices

Snapshot: September 30, 2026, no-project orbs. Discover current schemas before reuse. Counts describe this account and date, not a fixed product contract. Evidence and limitations: [verification record](verification-2026-09-30.md).

## Parent and native external tools

Normal mode inventory had 41 entries (four built-in and 37 custom/plugin modes). External keys were absent there; the separate external-agent registry had six active agents. Cursor/Claude had no post-install scripts. These counts are a snapshot, not selection defaults.

Normal parent tools included creation, reading, waiting, and file transfers. Its deferred `amp` module exposed 22 functions:

```text
find_thread, public_artifact_url, thread_file_url, thread_portal_login_url,
get_current_user_identity, slack_write, slack_read, slack_read_user_profile,
slack_list_user_channels, slack_list_channel_members, get_schedule,
set_schedule, update_schedule, clear_schedule, list_agent_modes,
list_runners, list_workspace_members, find_shared_plugins_and_skills,
update_thread, get_thread_status, send_thread_message, ship_thread_changes
```

The native external-agent Amp MCP profile exposed only `find_thread`, `read_thread`, `puck`, and `manage_amp`. Normal built-in tools and deferred modules are separate surfaces. A tool absent in the external profile is not repaired by guessing another name.

| Capability | Cursor | Claude Code |
|---|---|---|
| Launch/native execution | Verified | Verified |
| Native version | Numeric version not captured | 2.1.285 |
| Amp CLI | Available; lifecycle exercised | Available; lifecycle exercised |
| Native Amp MCP | Four tools above | Same four tools |
| Ordinary child orchestration | Launch/read/poll/export/continue/cleanup verified | Same |
| Direct parent CLI callback | Content eventually received, owner-authored | Same |
| Native Amp `send_thread_message` | Absent | Absent |
| Native team/subagent tools | `Task`, `SwitchMode`; not Amp messaging | `SendMessage`, `ListAgents`; not Amp messaging |
| Native skill | Historical skill automatically available | Automatically available and native-loaded |
| Commit attribution | Not investigated | Enabled; native reminder observed; no commit test |
| Appended prompt | Not investigated | Registry none; full composition unverified |

Cursor native tools included Shell/Grep/Read/Write/StrReplace/Glob, GetDynamicTools/CallDynamicTool, AwaitShell, CreateGoal/UpdateGoal, Delete, EditNotebook, FetchMcpResource, GenerateImage, ReadLints, SwitchMode, Task, TodoWrite, WebFetch/WebSearch.

Claude native tools included Agent, Artifact, AskUserQuestion, Bash, Edit, ListAgents, Read, ReportFindings, ScheduleWakeup, Skill, ToolSearch, Workflow, Write; deferred Cron tools, DesignSync, plan/worktree tools, NotebookEdit, RemoteTrigger, SendMessage, TaskStop, WebFetch/WebSearch. These names prove catalogue visibility, not that every tool was exercised.

## Communication and attribution

| Route | Interface | Evidence / limitation |
|---|---|---|
| Parent → normal child | Creation/message/CLI continuation | Assistant result and retained codeword |
| Normal child → parent | `send_thread_message` | Receipt with source-thread envelope |
| Parent/Puck → external agent | Thread steering | User markers persisted; native report/callback updates |
| External → normal child | CLI | Child result, metadata and continuity verified |
| External → parent | CLI continuation | Deferred content receipt; no source-thread envelope |
| Cursor ↔ Claude | CLI continuation | Peer markers persisted; not a general conversation guarantee |
| External → Puck | Native `amp.puck.send` | Receipt; owner-authored, source not identified by envelope |
| Parent → Puck | Normal `send_thread_message` | Authenticated route and source-thread metadata |
| Parent → external → grandchild → parent | CLI + independent result/file retrieval | Verified without mandatory Puck mediation |

CLI exit status, destination persistence, execution and recipient receipt are distinct checkpoints. Cross-project communication was not tested. Deferred callback arrival did not establish an ordering or latency contract.

## Failure recovery

For blank, stuck-looking, UI-not-loading or unknown-state external threads, follow the [existing-thread wake-up procedure](../SKILL.md#wake-up-a-blank-stuck-or-unknown-external-thread) before recommending replacement. Inspect status/transcript read-only, then send one authorized harmless follow-up to the same ID asking for existing-context status and blockers without restart/reset/config/auth changes. Observe boundedly; reuse the thread if usable activity returns. Preserve it and only propose a separately authorized replacement after an unsuccessful wake-up check, not on silence alone.

| Observation | Safe interpretation / action |
|---|---|
| Blank or initial-prompt-only transcript; `agentState=unknown` | Server visibility alone does not establish execution/state; do not diagnose a dead orb, lost state or auth failure |
| UI does not load while server tools can inspect the thread | Record UI and server symptoms separately; a normal follow-up may restore usability without a restart |
| Wake-up accepted or appears as a user message | Submission/persistence only; look for renewed native activity, response, callback/report or owner-confirmed usability |
| Existing thread becomes usable after follow-up | Preserve and reuse it; label owner reports separately from independently observed execution |
| No renewed activity within the declared budget | Wake-up outcome unverified/unsuccessful within that window, not proof of permanent failure; retain evidence before a replacement recommendation |
| Explicit blocker, archive state or pending approval | Report the observed blocker; do not repair auth/configuration or bypass approvals. Unarchive only with authorization |

The [September 30 wake-up observation](verification-2026-09-30.md#existing-thread-wake-up-observation) combines Puck's recorded status/read/send with the owner's “oh it worked.” No restart/reset action appears in that sequence, but no resumed assistant output appears server-side either. Successful wake-up supports resumability/usability of that existing thread; it does **not** recover or prove missing prior transcript/state. This single observation is not a Cursor/Claude parity result or a universal UI recovery guarantee.

## Skills and origins

| Session/location | Observation | Untested |
|---|---|---|
| Parent, normal child, both normal grandchildren | 37 skills (27 personal + 10 official), managed global cache | Different accounts/projects |
| Fresh Cursor | Same 37 names under `~/.agents/skills`; product `~/.cursor/skills-cursor` | Reload and collision handling |
| Fresh Claude | Same 37 under `~/.agents/skills` and `~/.claude/skills`; additional native built-ins | Exhaustive native diff/reload |
| Workspace repository | Empty | Nonempty workspace inheritance |
| Project-local skills | Absent in no-project tests | Project precedence and inheritance |

The predecessor's contents matched across parent and both external agents. The internal copy/bootstrap mechanism was not inspected. Automatic predecessor inheritance is not proof that the renamed skill has been globally published. Discover path/origin/content before installing or replacing anything.

## MCP classification

For each server record: scope, registry listed, schemas readable, connection status, auth category, Amp invocation, native invocation, blocker, and evidence. A health check updates discovery metadata and does not prove tool invocation. Never treat registry credentials as native credentials.

| Layer/server | Registry/schema | Normal Amp read | Cursor-native | Claude-native |
|---|---|---|---|---|
| Personal Composio | Connected OAuth; 11 tools | Discovery, Exa extraction and Parallel research succeeded | Separate plugin `needsAuth` | Absent |
| Personal Devin | Connected bearer; 23 tools after check | Integrations read succeeded | Not inherited as native namespace | Absent |
| Personal Trybeacon | Connected bearer; 10 tools | No linked browser | Not inherited as native namespace | Absent |
| CLI `amp svc` | Help visible | Account-feature-gated | Same bridge is distinct from native MCP | Same distinction |
| External Amp profile | Connected native profile | Separate parent surface | Four tools | Four tools |
| Cursor Cloudflare docs | Native catalogue ready | Not applicable | Harmless search succeeded | Absent |
| Cursor other plugins | Native `needsAuth` | Not applicable | Composio, X, Drive, Cloudflare bindings/builds/observability blocked | Absent |

Workspace remote registry was empty; project registry was not applicable. Cursor local `amp mcp doctor` reported no local servers while the personal remote registry remained available. Those inventories cover different scopes.

Final cached tool names, not a permission to invoke write tools:

```text
Composio (11): COMPOSIO_GET_TOOL_SCHEMAS, COMPOSIO_MANAGE_CONNECTIONS,
COMPOSIO_MANAGE_SKILL, COMPOSIO_MULTI_EXECUTE_TOOL, COMPOSIO_REMOTE_BASH_TOOL,
COMPOSIO_REMOTE_WORKBENCH, COMPOSIO_SEARCH_SKILLS, COMPOSIO_SEARCH_TOOLS,
COMPOSIO_SUBMIT_FEEDBACK, COMPOSIO_USE_SKILL, COMPOSIO_WAIT_FOR_CONNECTIONS

Devin (23): ask_wiki_question, devin_automation_manage, devin_billing_tag_manage,
devin_blueprint_test, devin_code_scan_manage, devin_find_setting,
devin_knowledge_manage, devin_list_integrations, devin_mcp_server_manage,
devin_oncall_manage, devin_playbook_manage, devin_review_manage,
devin_schedule_manage, devin_session_create, devin_session_events,
devin_session_gather, devin_session_interact, devin_session_search,
devin_user_list, generate_wiki, list_wiki_repos, read_wiki_contents,
read_wiki_structure

Trybeacon (10): click, feedback, focus, navigate, observe, press, run,
scroll, stroke, type
```

Earlier Devin discovery reported 22 and had incomplete name enumeration. Final scoped listing resolved 23. Large Devin JSON output was incomplete; human-readable listing succeeded. Do not misclassify a formatting failure as authentication failure.

## Model and effort selection

| Surface | Cursor | Claude Code |
|---|---|---|
| Amp key | `external-agent:cursor` verified | `external-agent:claude-code` verified |
| Parent creation model/effort fields | None exposed | None exposed |
| Amp `--model` | Account gate before selection | Same |
| Amp `--effort` | Unknown option | Same |
| Picker model | Documented by management help; uninspected | Same |
| Picker effort | Not documented by inspected help | Per-thread documented; values uninspected |
| Native observed settings | Model/effort override files empty | Reported Sonnet 5.5, medium |
| External actual served usage | Unavailable | Unavailable |
| Native controls | Task model / SwitchMode do not select the main Amp thread model | Help exposes model and effort; no Amp override proof |
| Continuation override | Untested | Untested |

Claude native effort help listed `low`, `medium`, `high`, `xhigh`, `max`; model help listed aliases/full names. Native `loggedIn=false` coexisted with working access. Amp-managed access categories were observed, but exact native provider authentication was not established. Do not infer a missing credential from native login status alone.

## CLI inventory and limits

Inspected thread subcommands: new, continue, list, usage, context, visibility, search, color, label, share/multiplayer, import, rename, archive, delete, markdown, export, raw. Only the investigation's launch/read/export/steering/lifecycle paths were exercised. Do not imply all help-listed commands were tested.

Creation help exposed mode, features/fast, executor, project, orb size, title, attachment, and execute options. No external model/effort parameters appeared in the parent creation schema. Management exposed post-install hooks, not replacement of built-in agent launch commands. Never restore historical command templates as current setup.
