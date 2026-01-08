---
allowed-tools: Bash(*), Read, Write, Edit, Glob, Grep, WebFetch, WebSearch, Task, AskUserQuestion, mcp__perplexity-ask__perplexity_ask, mcp__firecrawl__firecrawl_search, mcp__firecrawl__firecrawl_scrape, mcp__exa__web_search_exa, mcp__exa__get_code_context_exa, mcp__raindrop__create_collection, mcp__raindrop__create_bookmark, mcp__raindrop__search_bookmarks, mcp__context7__resolve-library-id, mcp__context7__query-docs
argument-hint: [build-prompt-or-file] [context-files...]
description: Genesis specification generator - structured intake for professional technical specs
model: opus
---

# Genesis Technical Specification Generator

You are initiating a Genesis specification project. Your goal is to gather comprehensive, specific information through a structured intake process that ensures the resulting technical specification is highly professional, detailed, and non-generic.

**CRITICAL**: Genesis uses **ultrathink** for deep reasoning at key moments. When you see "ultrathink:" in a section, engage extended thinking mode to analyze thoroughly before responding.

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

ultrathink:
Before proceeding, deeply analyze any provided inputs. Consider:
- What is the user actually trying to build?
- What implicit requirements aren't stated?
- What clarifying questions would a 10x engineer ask?
- What constraints should we surface early?

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

## Phase 3: Deep Clarification Round

ultrathink:
After gathering initial answers, analyze deeply:
1. What implicit requirements exist that the user hasn't stated?
2. What edge cases will cause problems if not addressed now?
3. What technical constraints create tension with the stated requirements?
4. What assumptions am I making that could be wrong?
5. What would a hostile stakeholder criticize about this specification?

Think through each aspect thoroughly, then:

1. **Identify Ambiguities**: List anything that's still unclear or too generic.
2. **Probe for Specifics**: Ask follow-up questions to eliminate vagueness.
3. **Surface Assumptions**: State your assumptions and ask user to confirm/correct.
4. **Conflict Resolution**: If any answers contradict, clarify with user.

**CRITICAL**: Never accept vague answers. Push for specifics:
- Bad: "fast performance" → Good: "< 200ms p95 latency"
- Bad: "many users" → Good: "10,000 DAU, 100 concurrent"
- Bad: "handle errors appropriately" → Good: "retry 3x with exponential backoff, then alert via PagerDuty"
- Bad: "secure" → Good: "SOC2 Type II compliant, encrypted at rest with AES-256"

## Phase 3.5: Technology Research & Skills Suggestions

### Step 1: Deep Technology Research

ultrathink:
Based on the gathered requirements, perform comprehensive technology research:

For each major component (frontend, backend, database, etc.):
1. What are the 3 best technology options for this project's constraints?
2. How do they compare on: performance, learning curve, ecosystem, scalability?
3. What are the risks and mitigations for each option?
4. What is the recommended choice and why?

Launch parallel research using MCP tools:

**Research Thread 1: Technology Best Practices**
```
Use mcp__perplexity-ask__perplexity_ask to research:
- "[technology] production best practices 2025"
- "[framework] vs alternatives comparison"
- "[technology] common pitfalls and solutions"
```

**Research Thread 2: Architecture Patterns**
```
Use mcp__exa__get_code_context_exa to get:
- Current documentation for key libraries
- Reference architecture examples
- Code patterns for identified technologies
```

**Research Thread 3: Library Documentation**
```
Use mcp__context7__resolve-library-id and mcp__context7__query-docs:
- Get up-to-date docs for core frameworks
- Verify API patterns are current
- Check for breaking changes in recent versions
```

### Step 2: Read Skills Registry
Read `skills-registry.json` to get the list of available skills.

### Step 3: Match Skills to Project
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

### Step 4: Present Research Findings

Present technology recommendations with justifications:

```
TECHNOLOGY ANALYSIS:

FRONTEND:
┌─────────────────────────────────────────────────────────────┐
│ Recommendation: Next.js 15 with App Router                  │
│                                                             │
│ Alternatives Considered:                                    │
│ - Remix: Better data loading, but smaller ecosystem        │
│ - Vite + React: Faster builds, but less full-stack         │
│                                                             │
│ Justification:                                              │
│ - Best fit for team's React expertise                       │
│ - Strong TypeScript support                                 │
│ - Built-in API routes reduce infrastructure complexity      │
│                                                             │
│ Risks: Vercel lock-in | Mitigation: Self-host on Docker   │
└─────────────────────────────────────────────────────────────┘

RECOMMENDED SKILLS:
┌─────────────────────────────────────────────────────────────┐
│ frontend-react                                               │
│ React Frontend Development                                   │
│ Helps with: Component patterns, hooks, state management     │
│ Install: claude skill install frontend-react                │
└─────────────────────────────────────────────────────────────┘
```

### Step 5: Record Research in Handoff
Add technology decisions with full reasoning to the handoff file.

## Phase 4: Synthesis & Confirmation

ultrathink:
Synthesize all gathered information into a comprehensive build prompt:
1. Are all requirements specific and measurable?
2. Are there any contradictions between sections?
3. Is every feature tied to a user need?
4. Are constraints realistic given the timeline and team?
5. Would a developer have zero ambiguity reading this?

Create a structured summary document:

```markdown
# Genesis Build Prompt: [Project Name]

## Executive Summary
[2-3 paragraphs synthesizing the project vision - written with precision]

## Target Users
| User Type | Primary Goal | Key Pain Point | Success Metric |
|-----------|--------------|----------------|----------------|
| [Type 1]  | [Goal]       | [Pain]         | [Metric]       |

## Feature Priorities
### Critical (P0) - Must ship
1. [Feature]:
   - Acceptance Criteria: [Specific, testable criteria]
   - Edge Cases: [Explicit edge case handling]

### Important (P1) - Should ship
1. [Feature]: [Description with acceptance criteria]

### Future (P2) - Phase 2+
1. [Feature]: [Description]

## Technical Requirements
- **Scale**: [Specific numbers with growth projections]
- **Performance**: [Specific targets with measurement method]
- **Security**: [Specific requirements with compliance standards]
- **Integrations**: [List with API versions and authentication methods]

## Technology Stack (Justified)
| Layer | Technology | Justification | Alternatives Considered |
|-------|------------|---------------|-------------------------|
| Frontend | [Tech] | [Why] | [Alt1, Alt2] |
| Backend | [Tech] | [Why] | [Alt1, Alt2] |
| Database | [Tech] | [Why] | [Alt1, Alt2] |

## Constraints & Decisions
- **Technology**: [Mandated choices with reasons]
- **Timeline**: [Key dates with dependencies]
- **Budget**: [Ranges with cost drivers]

## Risks & Mitigations
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [Specific mitigation] |

## Open Questions
1. [Question needing stakeholder input] - Impact if unresolved: [consequence]

## Assumptions
1. [Assumption]: Impact if wrong: [consequence]
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
  "genesis_version": "2.0",
  "ultrathink_enabled": true,
  "project": {
    "name": "[from intake]",
    "description": "[from intake]",
    "created_at": "[current timestamp]",
    "target_users": "[from intake]",
    "key_technologies": "[from intake - with justifications]",
    "constraints": "[from intake]"
  },
  "technology_decisions": [
    {
      "component": "[e.g., Frontend]",
      "choice": "[e.g., Next.js 15]",
      "justification": "[reasoning from ultrathink analysis]",
      "alternatives_considered": ["[alt1]", "[alt2]"],
      "risks": "[identified risks]",
      "mitigations": "[specific mitigations]"
    }
  ],
  "reference_materials": [],
  "sections_completed": [],
  "current_section": null,
  "global_context": {
    "decisions": [],
    "assumptions": "[from intake with impact analysis]",
    "open_questions": "[from intake with priority]"
  },
  "intake_summary": {
    "features_p0": "[critical features with acceptance criteria]",
    "features_p1": "[important features list]",
    "scale_targets": "[from intake - specific numbers]",
    "performance_targets": "[from intake - measurable]",
    "security_requirements": "[from intake - specific standards]",
    "timeline": "[from intake with milestones]",
    "team_size": "[from intake with specializations]"
  },
  "suggested_skills": [
    {
      "name": "[skill name]",
      "reason": "[why relevant]",
      "install_command": "[command]"
    }
  ],
  "research_artifacts": {
    "technology_analysis": "[path to research file]",
    "best_practices": "[path to research file]"
  }
}
```

### Step 4: Save Research Artifacts

Write technology research to `genesis_output/research/section_00_intake/`:
- `technology_analysis.md` - Technology comparison and recommendations
- `best_practices.md` - Current best practices research
- `skills_recommendations.md` - Matched skills with justifications

### Step 5: Copy Reference Materials

If user provided context files, copy them:
```bash
cp [provided files] genesis_sources/reference_materials/
```

### Step 6: Verify Initialization

Run this check:
```bash
ls -la genesis_output/handoffs/
cat genesis_output/handoffs/handoff_00_init.json | head -30
```

### Step 7: Ask User How to Proceed

Use the AskUserQuestion tool to ask:

**Question**: "Genesis initialization complete! How would you like to generate the specification?"

**Options**:
1. **Start Section 01 now** (Recommended) - Continue in this session with the Introduction section
2. **Run full automation** - Launch orchestrator to generate all 12 sections automatically (runs in background)
3. **Exit and run manually** - I'll run sections myself when ready

### Step 8: Execute Based on Choice

**If user chooses "Start Section 01 now":**
- Read the section guide: `genesis_sources/section_guides/Genesis_Section_01_Introduction.md`
- Read the handoff: `genesis_output/handoffs/handoff_00_init.json`
- Execute Section 01 following the guide instructions with ultrathink at key moments
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
1. Run each section in a fresh Claude session with ultrathink enabled
2. Create handoff files between sections
3. Compile the final specification when done

Output: genesis_output/final/technical_specification.md
```

**If user chooses "Exit and run manually":**
```
Genesis initialization complete!

Your project files:
  - Build prompt: genesis_sources/build_prompt.md
  - Handoff: genesis_output/handoffs/handoff_00_init.json
  - Research: genesis_output/research/section_00_intake/

When ready, run:
  ./genesis_orchestrator.sh --continue   # Automated with pauses for review
  ./genesis_orchestrator.sh --auto       # Fully automated, no pauses

Or manually:
  /genesis-section-01
  /genesis-section-02
  ... etc
```

## Quality Standards (Ultrathink-Enforced)

Throughout the intake, use ultrathink to ensure:

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

Begin the intake process now. Start by analyzing any provided inputs with ultrathink, then proceed with Section A questions.
