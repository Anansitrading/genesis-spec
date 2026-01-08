---
description: Generate Section 5 (Architecture & Design) of the Genesis technical specification. Documents system architecture, design patterns, and API design.
---

# Genesis Section 05: Architecture & Design

You are generating the Architecture & Design section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_03_technology_stack.json` (technology)
   - `genesis_output/handoffs/handoff_04_process_flowcharts.json` (workflows)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_05_Architecture_Design.md`

3. **Review Previous Sections**:
   - Read `genesis_output/sections/03_technology_stack.md`
   - Read `genesis_output/sections/04_process_flowcharts.md`

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Architecture Patterns

```
Use genesis-researcher agent to research:
- Clean architecture patterns for [technology stack]
- Microservices vs monolith considerations
- API-first design approaches

Return: Architecture patterns, trade-offs, recommendations
```

### Subagent 2: API Design Standards

```
Use genesis-perplexity agent to research:
- REST API design best practices 2025
- GraphQL considerations for [use case]
- API versioning strategies
- OpenAPI/Swagger documentation

Return: API design standards, versioning approach, documentation practices
```

### Subagent 3: Design Patterns

```
Use genesis-documentation agent to research:
- Design patterns for [technology stack]
- State management patterns
- Error handling patterns
- Caching strategies

Return: Applicable design patterns with implementation examples
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Architecture & Design section:

### 5.1 System Architecture
- High-level architecture diagram (Mermaid)
- Component breakdown
- Layer descriptions
- Communication patterns

### 5.2 Component Architecture
For each major component:
- Component diagram
- Responsibilities
- Interfaces
- Dependencies

### 5.3 Design Patterns
- Applied patterns with justifications
- Pattern implementation details
- Anti-patterns to avoid

### 5.4 API Design
- Endpoint structure
- Request/response formats
- Authentication approach
- Error response format
- Rate limiting strategy

### 5.5 Integration Architecture
- External service integration points
- Data flow between systems
- Sync vs async decisions
- Fallback strategies

### 5.6 Scalability Architecture
- Horizontal scaling approach
- Caching strategy
- Database scaling
- CDN usage

## Output Requirements

Write to `genesis_output/sections/05_architecture_design.md`

Create `genesis_output/handoffs/handoff_05_architecture_design.json`:

```json
{
  "section_number": 5,
  "section_name": "Architecture & Design",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "architecture_style": "[monolith/microservices/serverless]",
    "major_components": ["component 1", "component 2"],
    "design_patterns": ["pattern 1", "pattern 2"],
    "api_style": "[REST/GraphQL/hybrid]"
  },

  "api_endpoints": [
    {"method": "GET", "path": "/api/v1/resource", "description": "..."}
  ],

  "integration_points": [
    {"system": "name", "type": "sync/async", "purpose": "description"}
  ],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_06": "Data requirements from architecture",
    "for_section_07": "Security considerations from API design"
  }
}
```

## Completion Message

```
Section 05: Architecture & Design - COMPLETE

Summary:
- Architecture Style: [style]
- Major Components: [count]
- Design Patterns: [list]
- API Style: [style]

Next steps:
1. Review the architecture design
2. Start a NEW session
3. Run: /genesis-section-06
```
