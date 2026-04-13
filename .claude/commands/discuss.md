---
description: Read a note or article and discuss it interactively
argument-hint: <name-or-path>
allowed-tools: [Read, Glob, Grep, WebFetch, WebSearch]
---

# Discuss

The user wants to discuss a note or article.

## Arguments

$ARGUMENTS

- A full path to a file, OR
- A filename, partial name, or keyword to search for

## Instructions

1. **Find** the file:
   - If the argument looks like a path (starts with `/`, `~`, or contains `/`), read it directly.
   - Otherwise, search `~/notes/articles/` first, then `~/notes/` recursively. Try exact match (`$ARGUMENTS.md`), then glob for partial matches (e.g. `*$ARGUMENTS*`). If multiple matches, list them and ask which one.
2. **Read** the full article.
3. **Recap** the key points in 3-4 sentences. Be direct — no filler.
4. **Ask** what the user wants to dig into.

Then answer follow-up questions based on the article content. If the user asks about something not covered in the article, say so and offer to research it.
