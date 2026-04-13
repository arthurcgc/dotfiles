#!/bin/bash
cat <<'EOF'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "MEMPALACE WAKE-UP: Run the MemPalace protocol now. Call in parallel: 1) mempalace_status 2) mempalace_diary_read (agent_name: claude, last_n: 5) 3) mempalace_kg_query (entity: Arthur). Do this before responding to the user."
  }
}
EOF
exit 0
