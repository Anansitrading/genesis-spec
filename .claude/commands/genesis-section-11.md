---
description: Generate Section 11 (Documentation & Knowledge Management) of the Genesis technical specification. Documents documentation standards, ADRs, and onboarding.
---

# Genesis Section 11: Documentation & Knowledge Management

You are generating the Documentation & Knowledge Management section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_00_init.json` (project context)
   - `genesis_output/handoffs/handoff_10_deployment_operations.json` (ops docs)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_11_Documentation_Knowledge.md`

3. **Review All Previous Sections**:
   Skim all previous section outputs for documentation needs.

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Documentation Standards

```
Use genesis-researcher agent to research:
- Technical documentation best practices
- API documentation tools (Swagger, Redoc)
- Documentation site generators (Docusaurus, VitePress)
- README templates

Return: Documentation standards, tool recommendations
```

### Subagent 2: ADR Patterns

```
Use genesis-perplexity agent to research:
- Architecture Decision Records templates
- When to write ADRs
- ADR management tools
- Decision tracking practices

Return: ADR templates, best practices
```

### Subagent 3: Knowledge Management

```
Use genesis-documentation agent to research:
- Developer onboarding best practices
- Knowledge base organization
- Internal documentation strategies
- Runbook templates

Return: Onboarding guides, knowledge base structure
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Documentation & Knowledge Management section:

### 11.1 Documentation Standards
- Code documentation standards
- Inline comment guidelines
- JSDoc/TSDoc usage
- README requirements

### 11.2 API Documentation
- OpenAPI/Swagger setup
- API reference generation
- Example requests/responses
- Authentication documentation

### 11.3 Architecture Decision Records
- ADR template
- When to create ADRs
- ADR storage location
- Review process

### 11.4 Developer Guides
- Getting started guide
- Local development setup
- Contribution guidelines
- Code style guide

### 11.5 Onboarding Documentation
- New developer checklist
- Architecture overview
- Key concepts
- Common tasks

### 11.6 Knowledge Base Structure
- Documentation site structure
- Search configuration
- Versioning approach
- Update procedures

## Output Requirements

Write to `genesis_output/sections/11_documentation_knowledge.md`

Create `genesis_output/handoffs/handoff_11_documentation_knowledge.json`:

```json
{
  "section_number": 11,
  "section_name": "Documentation & Knowledge Management",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "documentation_tool": "[Docusaurus/VitePress/etc]",
    "api_documentation": "[Swagger/Redoc/etc]",
    "adr_location": "[path]"
  },

  "documentation_structure": [
    {"section": "Getting Started", "content": ["page 1", "page 2"]},
    {"section": "API Reference", "content": ["endpoints", "types"]}
  ],

  "adrs_to_create": [
    {"adr": "ADR-001", "title": "Technology Stack Selection"},
    {"adr": "ADR-002", "title": "Authentication Approach"}
  ],

  "onboarding_checklist": [
    "Environment setup",
    "Architecture overview",
    "First contribution"
  ],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_12": "Documentation resources to collect"
  }
}
```

## Completion Message

```
Section 11: Documentation & Knowledge Management - COMPLETE

Summary:
- Documentation Tool: [tool]
- API Docs: [tool]
- ADRs to Create: [count]
- Onboarding Guides: [count]

Next steps:
1. Review the documentation strategy
2. Start a NEW session
3. Run: /genesis-section-12
```
