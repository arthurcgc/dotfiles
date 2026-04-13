#!/bin/bash
NOTES="$HOME/notes"

INDEX_FILES=(
  "$NOTES/index.md"
  "$NOTES/homelab/index.md"
  "$NOTES/homelab/todo.md"
  "$NOTES/dotfiles/index.md"
  "$NOTES/design-system/index.md"
  "$NOTES/learning/index.md"
)

KB_CONTEXT=""
for f in "${INDEX_FILES[@]}"; do
  if [[ -f "$f" ]]; then
    relative="${f#$NOTES/}"
    KB_CONTEXT+="--- ${relative} ---"$'\n'
    KB_CONTEXT+="$(cat "$f")"$'\n\n'
  fi
done

MEMPALACE_MSG="MEMPALACE WAKE-UP: Run the MemPalace protocol now. Call in parallel: 1) mempalace_status 2) mempalace_diary_read (agent_name: claude, last_n: 5) 3) mempalace_kg_query (entity: Arthur). Do this before responding to the user."

FULL_CONTEXT="${MEMPALACE_MSG}

--- KNOWLEDGE BASE (~/notes indexes) ---
${KB_CONTEXT}"

jq -n --arg ctx "$FULL_CONTEXT" '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $ctx}}'
exit 0
