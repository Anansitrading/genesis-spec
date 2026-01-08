---
description: Generate Section 2 (Product Requirements) of the Genesis technical specification. Defines features, requirements, and traceability.
---

# Genesis Section 02: Product Requirements

You are generating the Product Requirements section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoff**:
   Read `genesis_output/handoffs/handoff_01_introduction.json` for context from Section 1.

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_02_Product_Requirements.md` for detailed instructions.

3. **Review Section 1 Output**:
   Read `genesis_output/sections/01_introduction.md` for continuity.

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL using the Task tool:

### Subagent 1: Feature Research

```
Use genesis-perplexity agent to research:
- Common features for [project type from handoff]
- Best practices for feature prioritization
- Requirements patterns for [domain]

Return: Feature ideas, prioritization frameworks, requirement templates
```

### Subagent 2: Technical Feasibility

```
Use genesis-researcher agent to research:
- Technical constraints for [major components from handoff]
- Performance requirements for [system type]
- Scalability considerations for [expected scale]

Return: Technical constraints, performance targets, scalability patterns
```

### Subagent 3: Existing Implementation (if applicable)

```
Use genesis-codebase-explorer agent to:
- Find existing feature implementations
- Analyze current data models
- Identify feature patterns

Return: Existing features, implementation patterns, technical debt
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Product Requirements section with these components:

### 2.1 Feature Catalog

For each major feature (F-001, F-002, etc.):
- Feature ID, Name, Category
- Priority Level (Critical/High/Medium/Low)
- Description: Overview, Business Value, User Benefits, Technical Context
- Dependencies: Prerequisites, System, External, Integration

### 2.2 Functional Requirements Tables

For each feature:
- Requirements table (F-XXX-RQ-YYY format)
- Columns: ID, Description, Acceptance Criteria, Priority, Complexity
- Technical Specifications: Input, Output, Performance, Data

### 2.3 Feature Relationships

- Dependency diagram (Mermaid)
- Integration points table
- Common services

### 2.4 Implementation Considerations

For each major feature:
- Technical Constraints
- Performance Requirements
- Scalability Considerations
- Security Implications

### 2.5 Traceability Matrix

- Business Requirement → Feature → Requirement → Test Case

### 2.6 Assumptions and Constraints

- Technical, User, Business, Data assumptions
- Regulatory, Resource, Platform constraints
- Risk mitigation strategies

## Output Requirements

### Section Output
Write to `genesis_output/sections/02_product_requirements.md`

### Handoff Output
Create `genesis_output/handoffs/handoff_02_product_requirements.json`:

```json
{
  "section_number": 2,
  "section_name": "Product Requirements",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "total_features": "[count]",
    "critical_features": ["F-001", "F-002"],
    "high_features": ["F-003", "F-004"],
    "total_requirements": "[count]",
    "must_have_requirements": "[count]"
  },

  "feature_summary": [
    {
      "id": "F-001",
      "name": "Feature Name",
      "priority": "Critical",
      "requirement_count": 5,
      "dependencies": ["F-002"]
    }
  ],

  "technology_implications": {
    "storage_needs": "[from requirements]",
    "performance_targets": "[from requirements]",
    "integration_points": ["external system 1", "external system 2"]
  },

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_03": "Technology requirements derived from features"
  }
}
```

## Completion Message

```
Section 02: Product Requirements - COMPLETE

Summary:
- Total Features: [X]
- Critical Features: [list]
- Total Requirements: [X]

Next steps:
1. Review the product requirements
2. Start a NEW session
3. Run: /genesis-section-03
```
