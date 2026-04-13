---
description: Read a markdown note, generate a Mermaid diagram for it, validate via the Mermaid MCP, and insert it into the doc
argument-hint: <file-path> [section-to-insert-before]
allowed-tools: [Read, Edit, Grep, mcp__mermaid__validate_and_render_mermaid_diagram]
---

# Diagram Generator

The user wants a Mermaid architecture or flow diagram added to a markdown note.

## Arguments

$ARGUMENTS

- First argument: path to the markdown file (required)
- Second argument: heading name to insert the diagram before (optional — if omitted, ask the user)

## Instructions

1. **Read** the file at the given path
2. **Analyze** the content and determine the best diagram type:
   - `flowchart` — for architecture, service relationships, data flow
   - `sequenceDiagram` — for attack flows, request/response, step-by-step protocols
   - `graph` — for dependency or network topology
3. **Generate** the Mermaid code. Keep it clear and readable — label nodes with names, ports, and short descriptions where relevant. Use subgraphs to group related components. Add styling for dark theme readability when using flowcharts.
4. **Validate and render** via `mcp__mermaid__validate_and_render_mermaid_diagram` with clientName "claude" and the appropriate diagramType
5. If validation fails, fix the syntax and retry
6. **Show** the rendered diagram to the user and ask for approval
7. Once approved, **insert** the diagram into the file using Edit — place it in a `## Architecture` or `## Attack flow` or `## Traffic flow` section (whichever fits), before the heading the user specified (or ask where to place it)

## Important

- Do NOT add diagrams to short reference notes that are just descriptions with no flows or architecture to visualize
- Use `<br/>` for line breaks inside node labels, NOT `\n` in sequence diagrams
- Avoid parentheses in edge labels — Mermaid parses them as node syntax
- For sequence diagrams, use `rect rgb(40, 40, 60)` for highlighted sections
