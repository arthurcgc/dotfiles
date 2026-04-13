---
description: Spawn a fresh Opus agent to review uncommitted changes or a specific file/decision
argument-hint: [file-or-topic]
allowed-tools: [Agent, Read, Bash, Glob, Grep]
---

# Code Review Council

Spawn an independent Opus agent to review work with fresh eyes — no shared context or biases from the current session.

## Arguments

$ARGUMENTS

- If empty: review all uncommitted changes in the current repo
- If a file path: review that specific file
- If a topic/decision: challenge that decision (devil's advocate)

## Instructions

1. **Determine scope:**
   - No args → run `git diff` and `git diff --cached` to get all changes
   - File path → read that file
   - Topic → frame as a devil's advocate challenge

2. **Spawn reviewer agent** with `model: "opus"` and `subagent_type: "code-reviewer"` (or `general-purpose` for non-code decisions). The prompt MUST:
   - Include the full diff or file content — the agent has no context from this conversation
   - Ask it to be critical: find bugs, missed edge cases, security issues, broken assumptions
   - Ask it to check if changes actually work together (e.g. nginx config + app config + docker-compose all aligned)
   - For devil's advocate: present the decision and ask it to argue against it

3. **Report findings** — summarize what the reviewer found. If issues were caught, fix them. If clean, say so.
