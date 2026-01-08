---
description: Generate Section 1 (Introduction) of the Genesis technical specification. Establishes project context, objectives, and scope.
---

# Genesis Section 01: Introduction

You are generating the Introduction section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoff**:
   Read `genesis_output/handoffs/handoff_00_init.json` to get project context.

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_01_Introduction.md` for detailed instructions.
   If this file doesn't exist, use the embedded guide below.

3. **Check for Reference Materials**:
   Read any reference materials listed in the handoff.

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL using the Task tool:

### Subagent 1: Market Research

```
Use genesis-perplexity agent to research:
- Market analysis for [project domain]
- Competitive landscape for [similar systems]
- Industry trends in [relevant technology area]

Return: Market context, competitor features, industry direction
```

### Subagent 2: Technical Context

```
Use genesis-researcher agent to research:
- Best practices for [system type]
- Success metrics for [application type]
- Common failure modes in [domain]

Return: Technical best practices, KPIs, anti-patterns to avoid
```

### Subagent 3: Existing Codebase (if applicable)

```
Use genesis-codebase-explorer agent to:
- Explore any existing codebase referenced in handoff
- Identify current architecture patterns
- Find existing documentation

Return: Current state analysis, patterns in use, gaps identified
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Using the research results, generate the Introduction section with these components:

### 1.1 Executive Summary
- Project Overview (2-3 paragraphs)
- Core Business Problem
- Key Stakeholders
- Expected Business Impact

### 1.2 System Overview
- Current System Limitations
- Integration with Existing Landscape
- Primary System Capabilities
- Major System Components (table format)
- Core Technical Approach

### 1.3 Success Criteria
- Measurable Objectives (table with metrics, targets, timelines)
- Critical Success Factors
- Key Performance Indicators

### 1.4 Scope
- In-Scope: Core features, implementation boundaries
- Out-of-Scope: Excluded features, future phases
- Unsupported Use Cases

## Output Requirements

### Section Output

Write to `genesis_output/sections/01_introduction.md`:
- Full markdown document
- All subsections complete
- Mermaid diagrams where helpful
- Tables properly formatted

### Handoff Output

Create `genesis_output/handoffs/handoff_01_introduction.json`:

```json
{
  "section_number": 1,
  "section_name": "Introduction",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "project_name": "[extracted]",
    "project_type": "[web app/mobile/API/etc]",
    "primary_users": ["user type 1", "user type 2"],
    "core_capabilities": ["capability 1", "capability 2"],
    "major_components": ["component 1", "component 2"],
    "success_metrics": [
      {"metric": "name", "target": "value", "timeline": "when"}
    ]
  },

  "decisions_made": [
    {"decision": "description", "rationale": "why"}
  ],

  "assumptions": [
    {"assumption": "description", "impact_if_wrong": "what happens"}
  ],

  "open_questions": [
    {"question": "description", "blocking": true}
  ],

  "research_findings": {
    "market_context": "[summary]",
    "technical_insights": "[summary]",
    "codebase_analysis": "[summary if applicable]"
  },

  "next_section_context": {
    "for_section_02": "Key information Product Requirements needs"
  }
}
```

### Research Artifacts

Save subagent outputs to `genesis_output/research/section_01/`:
- `market_research.md`
- `technical_context.md`
- `codebase_analysis.md` (if applicable)

## Completion Message

After generating all outputs:

```
Section 01: Introduction - COMPLETE

Outputs created:
✓ genesis_output/sections/01_introduction.md
✓ genesis_output/handoffs/handoff_01_introduction.json
✓ genesis_output/research/section_01/

Key decisions made:
- [List decisions]

Open questions for stakeholder review:
- [List questions]

Next steps:
1. Review the generated introduction
2. Start a NEW session
3. Run: /genesis-section-02

Alternatively:
$ ./genesis_orchestrator.sh --continue
```
