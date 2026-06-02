# Cadence (Codex)

Engineering workflow guardrails for Codex. Durable rules and command-mode skills ship in this package; edit the [cadence](https://github.com/abstractonion/cadence) repo and run `./scripts/sync.sh` to refresh.

## Install

```bash
codex plugin marketplace add abstractonion/cadence
codex plugin add cadence@cadence
```

## Command-mode skills

Slash-command primers from the main repo are exposed as skills named `cadence-<command>`. Invoke them by skill name or with natural-language prompts:

| Skill | Example prompt |
| --- | --- |
| `cadence-propose` | Use cadence-propose — give me 1–3 options before we change anything. |
| `cadence-investigate` | Run cadence-investigate on this failure; no patches yet. |
| `cadence-plan` | Use cadence-plan to break this task into verifiable steps. |
| `cadence-diff-check` | Use cadence-diff-check on my staged diff. |
| `cadence-verify` | Use cadence-verify before we call this done. |
| `cadence-ship` | Walk cadence-ship on the current change. |
| `cadence-audit` | Run cadence-audit on this file against cadence rules. |
| `cadence-reflect` | Use cadence-reflect to capture one lesson from this session. |
| `cadence-promote` | Use cadence-promote on the latest learnings entry. |

Durable workflow and stack rules load automatically from the other `skills/` entries when their descriptions match the task.

Subagent definitions and prompt templates from the main repo are not bundled in this Codex package; see [agents/](https://github.com/abstractonion/cadence/tree/main/agents) and [templates/](https://github.com/abstractonion/cadence/tree/main/templates) in the source repo.

## More

- Full command and rule catalog: [github.com/abstractonion/cadence](https://github.com/abstractonion/cadence)
- Privacy: [PRIVACY.md](./PRIVACY.md)
