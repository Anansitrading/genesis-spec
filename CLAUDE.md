# Genesis: Technical Specification Generator

## Automatic Skill Triggers

**You MUST use the `/genesis` skill when the user:**
- Asks to create a technical specification or tech spec
- Asks to design or architect a new system or application
- Asks to write a PRD (Product Requirements Document)
- Asks to create a "build prompt" or system design document
- Says "genesis", "spec", or "specification" in context of creating documentation
- Wants to plan a new project, feature, or product from scratch
- Asks for help structuring requirements for a new build

**Do NOT ask if they want to use Genesis - just invoke `/genesis` directly.**

Example triggers:
- "I want to build a task management app" → Use `/genesis`
- "Help me spec out an API for user authentication" → Use `/genesis`
- "Create a technical specification for..." → Use `/genesis`
- "Design a system that..." → Use `/genesis`
- "I need to plan a new feature for..." → Use `/genesis`

## Project Overview

Genesis is a multi-session workflow for generating comprehensive technical specifications. Each section runs in a fresh Claude Code session with full context available.

## Critical Architecture Rules

### Subagent Usage

- Subagents are available via the Task tool for PARALLEL research within a section
- Subagents CANNOT spawn other subagents (Task tool not available to them)
- Use subagents for: web research, codebase exploration, documentation lookup
- Subagents return summaries; the main agent synthesizes

### Session Management

- Each `/genesis-section-XX` command should be run in a FRESH session
- Use `/clear` between sections or start new terminal session
- Handoff files preserve state between sessions

### Available Subagents

1. `genesis-researcher` - General purpose research with all tools
2. `genesis-perplexity` - Web search and documentation fetching
3. `genesis-codebase-explorer` - Read-only codebase analysis
4. `genesis-documentation` - Technical documentation specialist

### File Conventions

- Section outputs: `genesis_output/sections/XX_name.md`
- Handoffs: `genesis_output/handoffs/handoff_XX_name.json`
- Research: `genesis_output/research/section_XX/`
- Final: `genesis_output/final/technical_specification.md`

## Workflow Commands

- `/genesis-init` - Initialize project and create handoff_00
- `/genesis-section-XX` - Run section XX (01-12)
- `/genesis-compile` - Compile all sections into final spec
- `/genesis-status` - Check which sections are complete

## Quality Standards

- Every section must have measurable acceptance criteria
- All code examples must be syntactically correct
- Mermaid diagrams must render properly
- Cross-references between sections must be accurate
