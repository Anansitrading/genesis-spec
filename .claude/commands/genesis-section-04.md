---
description: Generate Section 4 (Process Flowcharts) of the Genesis technical specification. Documents system workflows, validation rules, and state management.
---

# Genesis Section 04: Process Flowcharts

You are generating the Process Flowcharts section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_02_product_requirements.json` (features)
   - `genesis_output/handoffs/handoff_03_technology_stack.json` (technology context)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_04_Process_Flowcharts.md`

3. **Review Previous Sections**:
   - Read `genesis_output/sections/02_product_requirements.md`
   - Read `genesis_output/sections/03_technology_stack.md`

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Workflow Patterns

```
Use genesis-researcher agent to research:
- Workflow patterns for [application type]
- State machine best practices
- Mermaid diagram syntax for complex flows

Return: Workflow patterns, state machine examples, diagram syntax
```

### Subagent 2: Error Handling Patterns

```
Use genesis-perplexity agent to research:
- Error handling patterns for [technology stack]
- Retry and fallback strategies
- User-facing error messaging best practices

Return: Error handling patterns, recovery strategies
```

### Subagent 3: Existing Workflows (if applicable)

```
Use genesis-codebase-explorer agent to:
- Find existing workflow implementations
- Analyze state management patterns
- Identify error handling approaches

Return: Current workflows, state patterns, gaps
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Process Flowcharts section:

### 4.1 Core Application Workflows
For each major feature, create:
- Mermaid flowchart diagram
- Step-by-step process description
- Decision points and branches
- Error paths and recovery

### 4.2 Data Validation Workflows
- Input validation flows
- Business rule validation
- Cross-field validation
- Async validation patterns

### 4.3 Error Handling Flows
- Error detection points
- Error categorization
- Recovery strategies
- User notification flows

### 4.4 State Management Diagrams
- Application state machines
- Feature-specific state flows
- State transition rules
- Invalid state prevention

### 4.5 Integration Workflows
- External API call flows
- Webhook handling
- Async operation management
- Retry and circuit breaker patterns

## Output Requirements

Write to `genesis_output/sections/04_process_flowcharts.md`

Create `genesis_output/handoffs/handoff_04_process_flowcharts.json`:

```json
{
  "section_number": 4,
  "section_name": "Process Flowcharts",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "total_workflows": "[count]",
    "core_workflows": ["workflow 1", "workflow 2"],
    "state_machines": ["state machine 1"],
    "integration_flows": ["integration 1"]
  },

  "validation_rules": [
    {"field": "name", "rules": ["rule 1", "rule 2"]}
  ],

  "error_handling_patterns": [
    {"error_type": "name", "strategy": "description"}
  ],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_05": "Workflows to reflect in architecture",
    "for_section_06": "Data flows for schema design"
  }
}
```

## Completion Message

```
Section 04: Process Flowcharts - COMPLETE

Summary:
- Total Workflows: [X]
- State Machines: [X]
- Integration Flows: [X]

Next steps:
1. Review the process flowcharts
2. Start a NEW session
3. Run: /genesis-section-05
```
