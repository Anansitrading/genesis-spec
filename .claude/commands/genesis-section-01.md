---
allowed-tools: Read, Write, Task, Bash, mcp__perplexity-ask__perplexity_ask, mcp__firecrawl__firecrawl_search, mcp__exa__web_search_exa, mcp__context7__resolve-library-id, mcp__context7__query-docs
description: Generate Section 1 (Introduction) of the Genesis technical specification. Establishes project context, objectives, and scope.
model: opus
---

# Genesis Section 01: Introduction

You are generating the Introduction section of a technical specification.

**CRITICAL**: This section uses **ultrathink** for deep analysis. When you see "ultrathink:" engage extended thinking mode to analyze thoroughly before responding.

## Pre-Flight Checks

1. **Read Previous Handoff**:
   Read `genesis_output/handoffs/handoff_00_init.json` to get project context.

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_01_Introduction.md` for detailed instructions.
   If this file doesn't exist, use the embedded guide below.

3. **Check for Reference Materials**:
   Read any reference materials listed in the handoff.

4. **Verify Ultrathink Mode**:
   This section requires deep thinking. Confirm you will use ultrathink for:
   - Problem analysis
   - Success criteria definition
   - Scope boundary decisions

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

### Pre-Synthesis Analysis

ultrathink:
Before writing, deeply analyze this project:

1. What is the REAL problem being solved? (not the stated problem, the underlying need)
2. Why does this problem exist? What conditions created it?
3. Who experiences this pain most acutely? What's their current workaround?
4. What makes NOW the right time to build this?
5. What would failure look like? What are we really trying to avoid?
6. What would undeniable success look like from each stakeholder's perspective?

Think through each aspect thoroughly. The introduction sets the tone for the entire specification - it must be precise and compelling.

### 1.1 Executive Summary

ultrathink:
Craft an executive summary that:
- States the problem with evidence of its impact
- Describes the solution at a conceptual level
- Quantifies the expected business value
- Identifies key stakeholders and their stakes

Avoid marketing language. Be precise and technical.

Generate:
- Project Overview (2-3 paragraphs - precise, not promotional)
- Core Business Problem (with quantified impact)
- Key Stakeholders (with their specific concerns)
- Expected Business Impact (with measurable outcomes)

### 1.2 System Overview

ultrathink:
Analyze the system's place in the broader landscape:
1. What systems currently address this need? Why are they insufficient?
2. How will this system integrate with existing infrastructure?
3. What are the major technical capabilities required?
4. What major components are needed to deliver those capabilities?

Generate:
- Current System Limitations (specific, not vague)
- Integration with Existing Landscape (explicit integration points)
- Primary System Capabilities (derived from user needs)
- Major System Components (table format with responsibilities)
- Core Technical Approach (architecture philosophy)

### 1.3 Success Criteria

ultrathink:
Define success criteria that are:
- Specific: No ambiguity in what "success" means
- Measurable: Can be objectively evaluated
- Achievable: Realistic given constraints
- Relevant: Tied to business objectives
- Time-bound: Clear timelines

For each metric, consider:
- How will it be measured?
- What's the baseline?
- What's the target?
- What's the stretch goal?
- What happens if we miss it?

Generate:
- Measurable Objectives (table with metrics, current baseline, targets, timelines)
- Critical Success Factors (what must go right)
- Key Performance Indicators (how we'll track progress)
- Failure Conditions (explicitly what we're trying to avoid)

### 1.4 Scope

ultrathink:
Define scope boundaries with precision:

IN-SCOPE: What must be delivered for the project to be considered successful?
OUT-OF-SCOPE: What is explicitly NOT being built (and why)?
GRAY AREAS: What might be scope creep? How do we decide?

For each in-scope item, consider:
- Why is this necessary for success?
- What's the minimum viable implementation?
- What's the full implementation?

For each out-of-scope item, consider:
- Why is this being excluded?
- What's the impact of exclusion?
- When might this be reconsidered?

Generate:
- In-Scope: Core features with explicit boundaries
- Out-of-Scope: Excluded features with rationale
- Unsupported Use Cases: What this system will NOT do
- Scope Decision Framework: How to evaluate scope questions

## Output Requirements

### Section Output

Write to `genesis_output/sections/01_introduction.md`:
- Full markdown document
- All subsections complete
- Mermaid diagrams where helpful
- Tables properly formatted
- Every claim supported by evidence or explicit assumption

### Handoff Output

Create `genesis_output/handoffs/handoff_01_introduction.json`:

```json
{
  "section_number": 1,
  "section_name": "Introduction",
  "completed_at": "[timestamp]",
  "status": "complete",
  "ultrathink_enabled": true,

  "key_outputs": {
    "project_name": "[extracted]",
    "project_type": "[web app/mobile/API/etc]",
    "primary_users": ["user type 1", "user type 2"],
    "core_capabilities": ["capability 1", "capability 2"],
    "major_components": ["component 1", "component 2"],
    "success_metrics": [
      {"metric": "name", "baseline": "current", "target": "value", "timeline": "when"}
    ]
  },

  "ultrathink_analysis": {
    "core_problem": "[deep analysis of the real problem]",
    "success_definition": "[what undeniable success looks like]",
    "failure_risks": "[what could go wrong]"
  },

  "decisions_made": [
    {
      "decision": "description",
      "rationale": "why (from ultrathink analysis)",
      "alternatives_considered": ["alt1", "alt2"],
      "reversibility": "easy/medium/hard"
    }
  ],

  "assumptions": [
    {"assumption": "description", "confidence": "high/medium/low", "impact_if_wrong": "what happens"}
  ],

  "open_questions": [
    {"question": "description", "blocking": true, "suggested_owner": "who should answer"}
  ],

  "research_findings": {
    "market_context": "[summary]",
    "technical_insights": "[summary]",
    "codebase_analysis": "[summary if applicable]"
  },

  "next_section_context": {
    "for_section_02": "Key information Product Requirements needs from this introduction"
  }
}
```

### Research Artifacts

Save subagent outputs to `genesis_output/research/section_01/`:
- `market_research.md`
- `technical_context.md`
- `codebase_analysis.md` (if applicable)
- `ultrathink_analysis.md` - Capture key insights from extended thinking

## Quality Validation

ultrathink:
Before finalizing, critically review:

1. Would a new team member understand the project after reading this?
2. Are all success criteria measurable and unambiguous?
3. Is every scope decision justified?
4. Are there hidden assumptions that need to be explicit?
5. Would a hostile stakeholder find something to criticize?

If any answer raises concerns, refine before completing.

## Completion Message

After generating all outputs:

```
Section 01: Introduction - COMPLETE

Ultrathink Analysis:
- Core Problem: [summary of deep problem analysis]
- Success Definition: [what we're really trying to achieve]

Outputs created:
✓ genesis_output/sections/01_introduction.md
✓ genesis_output/handoffs/handoff_01_introduction.json
✓ genesis_output/research/section_01/

Key decisions made:
- [List decisions with brief rationale]

Assumptions requiring validation:
- [List assumptions with confidence levels]

Open questions for stakeholder review:
- [List questions with suggested owners]

Next steps:
1. Review the generated introduction
2. Validate assumptions with stakeholders
3. Start a NEW session
4. Run: /genesis-section-02

Alternatively:
$ ./genesis_orchestrator.sh --continue
```
