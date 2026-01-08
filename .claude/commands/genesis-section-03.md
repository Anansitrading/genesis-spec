---
description: Generate Section 3 (Technology Stack) of the Genesis technical specification. Documents all technology choices with justifications.
---

# Genesis Section 03: Technology Stack

You are generating the Technology Stack section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_00_init.json` (initial constraints)
   - `genesis_output/handoffs/handoff_02_product_requirements.json` (feature requirements)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_03_Technology_Stack.md`

3. **Review Previous Sections**:
   - Read `genesis_output/sections/01_introduction.md`
   - Read `genesis_output/sections/02_product_requirements.md`

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Frontend Technologies

```
Use genesis-perplexity agent to research:
- Best frontend framework for [project requirements]
- State management comparison (Zustand vs Redux vs Jotai)
- UI component library options
- Current best practices for [framework] in 2025

Return: Framework recommendations with pros/cons, version info
```

### Subagent 2: Backend Technologies

```
Use genesis-perplexity agent to research:
- Best backend approach for [requirements]
- Database comparison for [data requirements]
- API design patterns for [use case]
- Caching and queue technologies

Return: Backend stack recommendations with justifications
```

### Subagent 3: Infrastructure & DevOps

```
Use genesis-researcher agent to research:
- Deployment platform comparison (Vercel, Railway, AWS, etc.)
- CI/CD best practices for [stack]
- Monitoring and observability tools
- Cost analysis for [expected scale]

Return: Infrastructure recommendations with cost estimates
```

### Subagent 4: AI/ML Technologies (if applicable)

```
Use genesis-researcher agent to research:
- LLM integration patterns (LangChain, direct API, etc.)
- AI model provider comparison (OpenAI, Anthropic, Google)
- Observability for AI applications
- Cost optimization for AI APIs

Return: AI stack recommendations with cost projections
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Technology Stack section:

### 3.1 Programming Languages
- Frontend Languages (with versions, justifications)
- Backend Languages (with versions, justifications)
- Selection Criteria

### 3.2 Frameworks & Libraries
- Core Frontend Framework
- State Management
- Specialized Libraries (by category)

### 3.3 Open Source Dependencies
- Core dependencies with versions
- Organized by category
- Version constraints documented

### 3.4 Third-Party Services
- AI Model Providers
- Backend Services
- Monitoring & Observability
- Authentication
- Storage Services

### 3.5 Databases & Storage
- Primary Database
- Client-Side Storage
- Caching Solutions
- Storage Services

### 3.6 Development & Deployment
- Development Tools
- Build System
- Containerization
- CI/CD Pipeline
- Deployment Platforms

## Output Requirements

Write to `genesis_output/sections/03_technology_stack.md`

Create `genesis_output/handoffs/handoff_03_technology_stack.json`:

```json
{
  "section_number": 3,
  "section_name": "Technology Stack",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "frontend_stack": {
      "framework": "Next.js 14.2+",
      "state": "Zustand 5.0.8",
      "styling": "Tailwind CSS + shadcn/ui"
    },
    "backend_stack": {
      "runtime": "Node.js 20.x",
      "framework": "Next.js API Routes",
      "additional": ["Python 3.13 for AI/ML"]
    },
    "database_stack": {
      "primary": "PostgreSQL 15+",
      "cache": "Redis 7+",
      "client": "IndexedDB via Dexie.js"
    },
    "infrastructure": {
      "frontend_hosting": "Vercel",
      "backend_hosting": "Railway",
      "ci_cd": "GitHub Actions"
    }
  },

  "version_constraints": [
    {"package": "name", "version": "^x.y.z", "reason": "why"}
  ],

  "cost_estimates": {
    "infrastructure_monthly": "$X",
    "ai_api_monthly": "$X",
    "total_monthly": "$X"
  },

  "next_section_context": {
    "for_section_04": "Technology choices that affect workflows",
    "for_section_05": "Stack details for architecture diagrams"
  }
}
```

## Completion Message

```
Section 03: Technology Stack - COMPLETE

Stack Summary:
- Frontend: [framework + state + styling]
- Backend: [runtime + framework]
- Database: [primary + cache + client]
- Infrastructure: [hosting + CI/CD]
- Estimated Monthly Cost: $X

Next steps:
1. Review technology choices
2. Start a NEW session
3. Run: /genesis-section-04
```
