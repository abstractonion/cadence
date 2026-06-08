---
name: cadence-workflow-from-chats
description: Mine recent chats for durable preferences and propose Cadence artifacts (rules, skills, commands, or subagents).
---

# Workflow From Chats

You are mining recent Cursor chats for durable working preferences this turn. Default to the last 7 days unless the user names a window. Do not summarize chats — extract reusable workflow guidance. Scan parent transcripts (use subagent content as internal evidence only; cite parent conversations). Look for explicit preferences, corrections, and markers like "always", "never", "stop", "review", "CI", "skill". Cluster by workflow shape: shipping, review, debugging, delegation, validation. Rate each atom strong, medium, weak, or contradicted. Apply Cadence's promotion flywheel: rule for broad always-on behavior, skill for recurring multi-step workflows, command for a single-turn mode, subagent for fresh-context delegation — or no artifact if situational. Return preference profile, adopt / consider / dismiss lists, and proposed Cadence artifacts. Do not write files without explicit approval.

## Anchored in

- capture-learnings
- promote-recurring-learnings
- promote
