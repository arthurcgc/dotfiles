---
description: Scaffold a SadServers scenario write-up with problem spec, concepts summary, and solution template
argument-hint: <scenario-url-or-name>
allowed-tools: [Read, Write, Edit, WebFetch, WebSearch, Grep, Glob]
---

# SadServers Scenario Scaffold

The user wants to start working on a SadServers scenario.

## Arguments

$ARGUMENTS

- A URL to the scenario on sadservers.com, or a scenario name

## Instructions

1. **Fetch** the scenario page from the URL (or search for it if only a name was given)
2. **Extract** the scenario name, difficulty, description, and what's being tested
3. **Create** the folder `~/notes/learning/sad-servers/<scenario-name>/` (kebab-case the name)
4. **Create `problem.md`:**
   ```
   ---
   tags: [learning, sad-servers, <relevant-tech-tags>]
   ---
   # <Scenario Name>
   
   **Difficulty:** <Easy/Medium/Hard>
   **URL:** <link to scenario>
   
   ## Problem
   <Full scenario description>
   
   ## Success criteria
   <What "solved" looks like — the check command or expected state>
   ```

5. **Create `concepts.md`:**
   ```
   ---
   tags: [learning, <relevant-tech-tags>]
   ---
   # Concepts: <Scenario Name>
   
   Summary of the key concepts needed for this scenario. Not a deep dive — just enough context to understand the problem and solution.
   
   ## <Concept 1> (e.g., TCP SYN backlog)
   <2-4 paragraph explanation>
   
   ## <Concept 2>
   <2-4 paragraph explanation>
   ```
   Keep it practical and relevant to the scenario. Link to deeper resources if useful.

6. **Create `solution.md`** as a template:
   ```
   ---
   tags: [learning, sad-servers, <relevant-tech-tags>]
   ---
   # Solution: <Scenario Name>
   
   ## Investigation
   <!-- What I checked first and what I found -->
   
   ## Root cause
   <!-- What was actually wrong -->
   
   ## Fix
   <!-- Commands I ran and why -->
   ```bash
   # commands here
   ```
   
   ## What I learned
   <!-- Key takeaway from this scenario -->
   ```

7. **Update** `~/notes/learning/sad-servers/index.md` — add a row to the table with the scenario name (linked), difficulty, key concepts, and status "In progress"

## Important
- Keep concepts.md concise — it's a study aid, not a textbook
- Tag everything with the relevant technologies (linux, systemd, nginx, tcp, kubernetes, etc.)
- The solution.md is a template — the user fills it in after solving
