---
allowed-tools: Bash(*), Read, Write, Edit, Glob, Grep, WebFetch, WebSearch, Task, AskUserQuestion, mcp__perplexity-ask__perplexity_ask, mcp__firecrawl__firecrawl_search, mcp__firecrawl__firecrawl_scrape, mcp__exa__web_search_exa, mcp__exa__get_code_context_exa, mcp__raindrop__create_collection, mcp__raindrop__create_bookmark, mcp__raindrop__search_bookmarks, mcp__context7__resolve-library-id, mcp__context7__query-docs
argument-hint: [build-prompt-or-file] [context-files...]
description: Genesis specification generator - structured intake for professional technical specs
model: opus
---

# Genesis Technical Specification Generator

You are initiating a Genesis specification project. Your goal is to gather comprehensive, specific information through a structured intake process that ensures the resulting technical specification is highly professional, detailed, and non-generic.

## Arguments Received
- Primary Input: $1
- Additional Context: $ARGUMENTS

## Phase 0: MCP Server Verification

Before starting, verify that required MCP servers are available. Check for these tools:

### Required MCP Tools
1. **Perplexity** (`mcp__perplexity-ask__perplexity_ask`) - Web research
2. **Firecrawl** (`mcp__firecrawl__firecrawl_search`) - Web scraping
3. **Raindrop** (`mcp__raindrop__create_collection`) - Documentation collections
4. **Exa** (`mcp__exa__web_search_exa`) - Code search

### If MCPs are missing:
Inform the user:
```
Genesis requires MCP servers for full functionality.

Missing: [list missing MCPs]

To install, run:
  claude mcp add perplexity-ask -- npx -y server-perplexity-ask
  claude mcp add firecrawl -- npx -y firecrawl-mcp
  claude mcp add raindrop -- npx -y @nicholasrq/raindrop-mcp
  claude mcp add exa -- npx -y @anthropic/exa-mcp

Required environment variables:
  PERPLEXITY_API_KEY, FIRECRAWL_API_KEY, RAINDROP_API_KEY, EXA_API_KEY

After setup, restart Claude Code and run /genesis again.
```

If all MCPs are available, proceed silently.

## Phase 1: Initial Context Analysis

First, analyze any provided inputs:

1. If `$1` is a file path (ends in .md, .txt, .json, etc.), read it:
   - Read the file content
   - Summarize what you learned
   - Identify gaps that need clarification

2. If `$1` is a text prompt, acknowledge the core idea.

3. For any additional context files in `$ARGUMENTS`, read them all and synthesize.

## Phase 2: Structured Intake Questionnaire

Guide the user through this structured intake. Ask ONE section at a time, wait for response, then proceed. Be conversational but thorough.

### Section A: Project Identity & Vision
Ask these questions (adapt based on what you already know):

1. **Project Name**: What should we call this project?
2. **One-Liner**: Describe it in one sentence for a developer.
3. **Problem Statement**: What specific problem does this solve? Who experiences this pain?
4. **Success Vision**: In 6 months, what does success look like? Be specific with metrics.

### Section B: Target Users & Use Cases
1. **Primary Users**: Who are the 2-3 main user types? (e.g., "Marketing managers at SaaS companies")
2. **User Goals**: For each user type, what are their top 3 goals?
3. **Key Use Cases**: Describe 3-5 critical user journeys in detail.
4. **Anti-Users**: Who is this NOT for?

### Section C: Technical Landscape
1. **Existing Systems**: What systems does this integrate with or replace?
2. **Data Sources**: What data will this system consume/produce?
3. **Technology Constraints**: Any mandated technologies, platforms, or restrictions?
4. **Team Expertise**: What's the team's strongest tech stack?

### Section D: Feature Prioritization
1. **Must-Have Features**: What 5-7 features are absolutely required for launch?
2. **Should-Have Features**: What features are important but could be Phase 2?
3. **Won't-Have Features**: What's explicitly out of scope?
4. **Differentiators**: What makes this different from existing solutions?

### Section E: Non-Functional Requirements
1. **Scale Expectations**: How many users/requests/data volume at launch? In 1 year?
2. **Performance**: Any specific latency, throughput, or availability targets?
3. **Security & Compliance**: GDPR, HIPAA, SOC2, or other requirements?
4. **Budget Constraints**: Infrastructure budget range? API cost sensitivity?

### Section F: Project Context
1. **Timeline**: Hard deadlines or milestones?
2. **Team Size**: How many developers? Specializations?
3. **Risk Tolerance**: Conservative (proven tech) or innovative (cutting edge)?
4. **Reference Projects**: Any existing systems or products to emulate?

## Phase 3: Clarification Round

After gathering initial answers:

1. **Identify Ambiguities**: List anything that's still unclear or too generic.
2. **Probe for Specifics**: Ask follow-up questions to eliminate vagueness.
3. **Surface Assumptions**: State your assumptions and ask user to confirm/correct.
4. **Conflict Resolution**: If any answers contradict, clarify with user.

Example probing questions:
- "You mentioned 'fast performance' - what specific latency target in milliseconds?"
- "For the user dashboard, what specific data visualizations are needed?"
- "When you say 'integrate with Slack', do you mean notifications, commands, or full workflow?"

## Phase 3.5: Skills & Tools Suggestions

Based on the gathered requirements, search for relevant skills and suggest them to the user.

### Step 1: Read Skills Registry
Read `skills-registry.json` to get the list of available skills.

### Step 2: Match Skills to Project
Analyze the project requirements and match against skill triggers:

| If Project Involves | Suggest Skill |
|---------------------|---------------|
| React, Next.js, frontend | `frontend-react` |
| Vue, Nuxt | `frontend-vue` |
| Node.js API, Express | `backend-node` |
| Python, FastAPI, Django | `backend-python` |
| PostgreSQL, database | `database-postgres` |
| AI, LLM, chatbot, RAG | `ai-langchain` |
| Autonomous agents | `ai-agents` |
| Docker, containers | `devops-docker` |
| CI/CD, GitHub Actions | `devops-cicd` |
| Testing, Vitest | `testing-vitest` |
| E2E, Playwright | `testing-playwright` |
| Authentication, OAuth | `auth-oauth` |
| Mobile app | `mobile-react-native` |
| GraphQL | `api-graphql` |
| Monitoring, logging | `monitoring-observability` |

### Step 3: Research Current Best Practices
Use MCP tools to research current best practices for the identified technologies:

```
Use mcp__perplexity-ask__perplexity_ask to research:
- "[technology] best practices 2025"
- "[framework] recommended patterns"
```

```
Use mcp__exa__get_code_context_exa to get:
- Current documentation for key libraries
- Code examples for identified patterns
```

### Step 4: Present Skills to User
Present matched skills to the user:

```
Based on your project, I recommend these Claude Code skills:

RECOMMENDED SKILLS:
┌─────────────────────────────────────────────────────────────┐
│ frontend-react                                               │
│ React Frontend Development                                   │
│ Helps with: Component patterns, hooks, state management     │
│ Install: claude skill install frontend-react                │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ backend-node                                                 │
│ Node.js Backend Development                                  │
│ Helps with: API design, middleware, Express patterns        │
│ Install: claude skill install backend-node                  │
└─────────────────────────────────────────────────────────────┘

Would you like me to note these in your specification for later installation?
```

### Step 5: Record Suggested Skills
Add suggested skills to the handoff file for reference during implementation.

## Phase 4: Synthesis & Confirmation

Create a structured summary document:

```markdown
# Genesis Build Prompt: [Project Name]

## Executive Summary
[2-3 paragraphs synthesizing the project vision]

## Target Users
| User Type | Primary Goal | Key Pain Point |
|-----------|--------------|----------------|
| [Type 1]  | [Goal]       | [Pain]         |

## Feature Priorities
### Critical (P0) - Must ship
1. [Feature]: [Specific acceptance criteria]

### Important (P1) - Should ship
1. [Feature]: [Description]

### Future (P2) - Phase 2+
1. [Feature]: [Description]

## Technical Requirements
- **Scale**: [Specific numbers]
- **Performance**: [Specific targets]
- **Security**: [Specific requirements]
- **Integrations**: [List with specifics]

## Constraints & Decisions
- **Technology**: [Mandated choices]
- **Timeline**: [Key dates]
- **Budget**: [Ranges]

## Open Questions
1. [Question needing stakeholder input]

## Assumptions
1. [Assumption]: [Impact if wrong]
```

Present this summary and ask: "Does this accurately capture your project? What needs correction or addition?"

## Phase 5: Initialize Genesis

Once the user confirms the summary:

### Step 1: Create Required Files

Execute these commands to set up the project:

```bash
# Ensure directories exist
mkdir -p genesis_output/handoffs genesis_output/sections genesis_output/research genesis_sources/reference_materials
```

### Step 2: Write the Build Prompt

Write the confirmed summary to `genesis_sources/build_prompt.md`

### Step 3: Create the Handoff File

Create `genesis_output/handoffs/handoff_00_init.json` with this structure:

```json
{
  "genesis_version": "1.0",
  "project": {
    "name": "[from intake]",
    "description": "[from intake]",
    "created_at": "[current timestamp]",
    "target_users": "[from intake]",
    "key_technologies": "[from intake]",
    "constraints": "[from intake]"
  },
  "reference_materials": [],
  "sections_completed": [],
  "current_section": null,
  "global_context": {
    "decisions": [],
    "assumptions": "[from intake]",
    "open_questions": "[from intake]"
  },
  "intake_summary": {
    "features_p0": "[critical features list]",
    "features_p1": "[important features list]",
    "scale_targets": "[from intake]",
    "performance_targets": "[from intake]",
    "security_requirements": "[from intake]",
    "timeline": "[from intake]",
    "team_size": "[from intake]"
  }
}
```

### Step 4: Copy Reference Materials

If user provided context files, copy them:
```bash
cp [provided files] genesis_sources/reference_materials/
```

### Step 5: Verify Initialization

Run this check:
```bash
ls -la genesis_output/handoffs/
cat genesis_output/handoffs/handoff_00_init.json | head -20
```

### Step 6: Ask User How to Proceed

Use the AskUserQuestion tool to ask:

**Question**: "Genesis initialization complete! How would you like to generate the specification?"

**Options**:
1. **Start Section 01 now** (Recommended) - Continue in this session with the Introduction section
2. **Run full automation** - Launch orchestrator to generate all 12 sections automatically (runs in background)
3. **Exit and run manually** - I'll run sections myself when ready

### Step 7: Execute Based on Choice

**If user chooses "Start Section 01 now":**
- Read the section guide: `genesis_sources/section_guides/Genesis_Section_01_Introduction.md`
- Read the handoff: `genesis_output/handoffs/handoff_00_init.json`
- Execute Section 01 following the guide instructions
- Launch parallel research subagents using Task tool
- Generate the Introduction section
- Create handoff_01_introduction.json
- Then ask if user wants to continue to Section 02

**If user chooses "Run full automation":**
Execute:
```bash
./genesis_orchestrator.sh --auto > genesis_output/logs/auto_run.log 2>&1 &
echo "Orchestrator started in background. Check progress with: ./genesis_orchestrator.sh --status"
```
Then inform user:
```
Genesis orchestrator is running in the background!

Monitor progress:
  ./genesis_orchestrator.sh --status
  tail -f genesis_output/logs/auto_run.log

The orchestrator will:
1. Run each section in a fresh Claude session
2. Create handoff files between sections
3. Compile the final specification when done

Estimated time: 30-60 minutes for full specification
Output: genesis_output/final/technical_specification.md
```

**If user chooses "Exit and run manually":**
```
Genesis initialization complete!

Your project files:
  - Build prompt: genesis_sources/build_prompt.md
  - Handoff: genesis_output/handoffs/handoff_00_init.json

When ready, run:
  ./genesis_orchestrator.sh --continue   # Automated with pauses for review
  ./genesis_orchestrator.sh --auto       # Fully automated, no pauses

Or manually:
  /genesis-section-01
  /genesis-section-02
  ... etc
```

## Quality Guidelines

Throughout the intake:

1. **Never accept vague answers** - Push for specifics
   - Bad: "fast performance" → Good: "< 200ms p95 latency"
   - Bad: "many users" → Good: "10,000 DAU, 100 concurrent"

2. **Validate consistency** - Ensure answers don't contradict

3. **Fill gaps proactively** - If user doesn't know, suggest reasonable defaults

4. **Document everything** - Every decision, assumption, and open question

5. **Professional tone** - This is a technical document, not marketing copy

Begin the intake process now. Start by analyzing any provided inputs, then proceed with Section A questions.
