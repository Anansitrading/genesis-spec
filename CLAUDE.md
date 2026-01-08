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

**Genesis v2.0 uses Ultrathink** - extended thinking mode for deep analysis, producing specifications so precise that even open-source models can implement them in a single shot with SOTA results.

## Ultrathink Integration

### What is Ultrathink?

Ultrathink is a Claude Code feature that triggers extended thinking mode. Genesis uses it strategically for:
- Deep problem analysis
- Technology decision making
- Architecture design
- Requirement precision
- Adversarial review

### Thinking Hierarchy

Claude Code recognizes these keywords with increasing thinking budgets:
```
"think" < "think hard" < "think harder" < "ultrathink"
```

### When to Use Ultrathink

**USE ultrathink for:**
- Initial problem analysis
- Technology tradeoff evaluation
- Architecture pattern selection
- API design decisions
- Security threat modeling
- Scope boundary decisions
- Quality validation reviews

**DO NOT use ultrathink for:**
- Simple formatting
- Copying content between sections
- Generating boilerplate
- Minor edits

### Ultrathink Prompt Pattern

When a section says "ultrathink:", engage deep thinking:

```
ultrathink:
Before proceeding, deeply analyze:
1. [Specific question to reason about]
2. [Another aspect to consider]
3. [Tradeoffs to evaluate]

Think through each aspect thoroughly before responding.
```

### Ultrathink Resources

- Design document: `docs/ULTRATHINK.md`
- Prompt templates: `docs/ultrathink-prompts.md`
- Deep research skill: `/genesis-ultrathink <topic>`

## Critical Architecture Rules

### Subagent Usage

- Subagents are available via the Task tool for PARALLEL research within a section
- Subagents CANNOT spawn other subagents (Task tool not available to them)
- Use subagents for: web research, codebase exploration, documentation lookup
- Subagents return summaries; the main agent synthesizes with ultrathink

### Session Management

- Each `/genesis-section-XX` command should be run in a FRESH session
- Use `/clear` between sections or start new terminal session
- Handoff files preserve state between sessions
- Ultrathink analysis is captured in handoff files for continuity

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

- `/genesis` - Start intake with ultrathink-enhanced questionnaire
- `/genesis-init` - Initialize project and create handoff_00
- `/genesis-section-XX` - Run section XX (01-12) with ultrathink
- `/genesis-compile` - Compile all sections into final spec
- `/genesis-status` - Check which sections are complete
- `/genesis-ultrathink <topic>` - Deep research on any topic

## Quality Standards (Ultrathink-Enforced)

1. **Precision Over Vagueness**
   - Every metric is specific and measurable
   - Every feature has testable acceptance criteria
   - Every constraint has a concrete value

2. **Adversarial Validation**
   - What would break this specification?
   - What would a hostile reviewer criticize?
   - What assumptions could be wrong?

3. **Implementation Readiness**
   - Could a developer implement from this alone?
   - Is every decision justified?
   - Are edge cases explicitly addressed?

4. **Consistency Checks**
   - Do sections contradict each other?
   - Are technology choices aligned with constraints?
   - Are timelines realistic given scope?

5. **Professional Excellence**
   - Would this impress a Staff+ engineer?
   - Is the writing precise and unambiguous?
   - Are trade-offs explicitly acknowledged?

## MCP Tools Available

Genesis uses these MCP tools for research:

| Tool | Purpose |
|------|---------|
| `mcp__perplexity-ask__perplexity_ask` | Web research, current best practices |
| `mcp__firecrawl__firecrawl_search` | Deep web search with content |
| `mcp__firecrawl__firecrawl_scrape` | Extract content from URLs |
| `mcp__exa__web_search_exa` | Code-focused search |
| `mcp__exa__get_code_context_exa` | Library and SDK documentation |
| `mcp__context7__resolve-library-id` | Find library documentation |
| `mcp__context7__query-docs` | Query up-to-date library docs |
| `mcp__raindrop__create_collection` | Create bookmark collections |
| `mcp__raindrop__create_bookmark` | Save documentation bookmarks |

## Example Ultrathink Usage

```
## Phase 3: Technology Selection

ultrathink:
Evaluate technology options for the backend framework:

For each option, analyze:
- Maturity and community support
- Learning curve for the team
- Performance characteristics
- Operational complexity
- Cost implications
- Lock-in risks

Compare: Express.js vs Fastify vs NestJS

Given our constraints:
- Scale: 10,000 concurrent users
- Team: 3 engineers with React experience
- Timeline: MVP in 8 weeks

Which pattern best fits? Justify with specific tradeoffs.
```

This produces deep analysis that results in well-justified technology decisions captured in the specification.
