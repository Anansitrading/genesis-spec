---
description: Generate Section 10 (Deployment & Operations) of the Genesis technical specification. Documents deployment process, infrastructure, and runbooks.
---

# Genesis Section 10: Deployment & Operations

You are generating the Deployment & Operations section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_03_technology_stack.json` (infrastructure)
   - `genesis_output/handoffs/handoff_08_testing_strategy.json` (CI/CD needs)
   - `genesis_output/handoffs/handoff_09_monitoring_observability.json` (monitoring)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_10_Deployment_Operations.md`

3. **Review Previous Sections**:
   - Read `genesis_output/sections/03_technology_stack.md`
   - Read `genesis_output/sections/09_monitoring_observability.md`

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Deployment Strategies

```
Use genesis-researcher agent to research:
- Blue-green deployment patterns
- Canary release strategies
- Feature flag implementation
- Rollback procedures

Return: Deployment patterns, rollback strategies
```

### Subagent 2: Infrastructure as Code

```
Use genesis-perplexity agent to research:
- IaC tools for [cloud provider]
- Terraform vs Pulumi comparison
- Environment management
- Secret injection patterns

Return: IaC recommendations, environment patterns
```

### Subagent 3: CI/CD Pipelines

```
Use genesis-documentation agent to research:
- GitHub Actions best practices
- Pipeline optimization
- Caching strategies
- Parallel job execution

Return: CI/CD patterns, optimization techniques
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Deployment & Operations section:

### 10.1 Deployment Strategy
- Deployment approach (blue-green, canary, etc.)
- Environment progression
- Release process
- Feature flags

### 10.2 CI/CD Pipeline
- Pipeline stages diagram
- Build stage
- Test stage
- Deploy stage
- Post-deploy validation

### 10.3 Infrastructure Configuration
- IaC approach
- Environment definitions
- Resource provisioning
- Scaling configuration

### 10.4 Environment Management
- Development environment
- Staging environment
- Production environment
- Environment parity

### 10.5 Operational Runbooks
- Deployment runbook
- Rollback runbook
- Incident response runbook
- Scaling runbook

### 10.6 Disaster Recovery
- Backup strategy
- Recovery procedures
- RTO/RPO targets
- Failover procedures

## Output Requirements

Write to `genesis_output/sections/10_deployment_operations.md`

Create `genesis_output/handoffs/handoff_10_deployment_operations.json`:

```json
{
  "section_number": 10,
  "section_name": "Deployment & Operations",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "deployment_strategy": "[blue-green/canary/rolling]",
    "ci_cd_tool": "GitHub Actions",
    "iac_tool": "[Terraform/Pulumi/etc]",
    "environments": ["development", "staging", "production"]
  },

  "pipeline_stages": [
    {"stage": "build", "duration": "~2min"},
    {"stage": "test", "duration": "~5min"},
    {"stage": "deploy", "duration": "~3min"}
  ],

  "runbooks": ["deployment", "rollback", "incident", "scaling"],

  "disaster_recovery": {
    "rto": "[time]",
    "rpo": "[time]",
    "backup_frequency": "[frequency]"
  },

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_11": "Documentation for operations"
  }
}
```

## Completion Message

```
Section 10: Deployment & Operations - COMPLETE

Summary:
- Deployment Strategy: [strategy]
- CI/CD Tool: [tool]
- Environments: [count]
- Runbooks: [count]

Next steps:
1. Review the deployment strategy
2. Start a NEW session
3. Run: /genesis-section-11
```
