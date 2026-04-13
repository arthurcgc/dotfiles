---
name: Spawn reviewer before reporting completion
description: On non-trivial changes, spawn an independent Opus agent to review work before telling the user it's done
type: feedback
---

Before reporting completion on non-trivial work (new services, multi-file config changes, architecture decisions), spawn an independent Opus code-reviewer agent to audit the changes with fresh eyes.

**Why:** Multiple incidents of reporting "done" with broken changes — user had to catch issues that a second pair of eyes would have found. Iterating 5+ times on a fix while telling the user to "try now" each time wastes their time and trust.

**How to apply:** After completing work but before telling the user it's done, spawn an Agent with subagent_type "code-reviewer" or "general-purpose" (for non-code decisions), include the full diff/content in the prompt, and ask it to be critical. Fix any issues it finds, then report to the user. Skip this for trivial changes (single-line edits, commits, simple lookups).
