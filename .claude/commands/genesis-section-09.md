---
description: Generate Section 9 (Monitoring & Observability) of the Genesis technical specification. Documents logging, metrics, tracing, and alerting.
---

# Genesis Section 09: Monitoring & Observability

You are generating the Monitoring & Observability section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_03_technology_stack.json` (monitoring tools)
   - `genesis_output/handoffs/handoff_05_architecture_design.json` (what to monitor)
   - `genesis_output/handoffs/handoff_07_security_compliance.json` (security monitoring)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_09_Monitoring_Observability.md`

3. **Review Previous Sections**:
   - Read `genesis_output/sections/05_architecture_design.md`
   - Read `genesis_output/sections/07_security_compliance.md`

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Monitoring Tools

```
Use genesis-perplexity agent to research:
- Application monitoring tools (Datadog, New Relic, etc.)
- Open-source alternatives (Prometheus, Grafana)
- Log aggregation (Loki, ELK stack)
- Cost comparison for [expected scale]

Return: Tool recommendations with cost estimates
```

### Subagent 2: AI Observability (if applicable)

```
Use genesis-researcher agent to research:
- LLM observability tools (LangSmith, Langfuse, etc.)
- Prompt tracing and debugging
- AI cost tracking
- Quality evaluation metrics

Return: AI observability patterns, tools, metrics
```

### Subagent 3: Alerting Patterns

```
Use genesis-documentation agent to research:
- Alerting best practices
- On-call rotation patterns
- Incident management workflows
- Runbook templates

Return: Alerting strategies, incident management approaches
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Monitoring & Observability section:

### 9.1 Logging Strategy
- Log levels and usage
- Structured logging format
- Log aggregation
- Log retention policies

### 9.2 Metrics Collection
- Infrastructure metrics
- Application metrics
- Business metrics
- Custom metrics definition

### 9.3 Distributed Tracing
- Tracing implementation
- Span definitions
- Trace context propagation
- Sampling strategy

### 9.4 AI/LLM Observability (if applicable)
- Prompt tracing
- Token usage tracking
- Response quality metrics
- Cost monitoring

### 9.5 Alerting Configuration
- Alert definitions
- Severity levels
- Escalation procedures
- On-call rotation

### 9.6 Dashboards
- Operations dashboard
- Business metrics dashboard
- AI performance dashboard
- Cost dashboard

## Output Requirements

Write to `genesis_output/sections/09_monitoring_observability.md`

Create `genesis_output/handoffs/handoff_09_monitoring_observability.json`:

```json
{
  "section_number": 9,
  "section_name": "Monitoring & Observability",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "monitoring_stack": {
      "apm": "[tool]",
      "logging": "[tool]",
      "metrics": "[tool]",
      "tracing": "[tool]"
    },
    "ai_observability": "[tool if applicable]"
  },

  "metrics_defined": [
    {"name": "metric_name", "type": "counter/gauge/histogram", "purpose": "description"}
  ],

  "alerts_defined": [
    {"name": "alert_name", "condition": "threshold", "severity": "critical/warning"}
  ],

  "dashboards": ["dashboard 1", "dashboard 2"],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_10": "Monitoring integration in deployment"
  }
}
```

## Completion Message

```
Section 09: Monitoring & Observability - COMPLETE

Summary:
- APM Tool: [tool]
- Logging: [tool]
- Alerts Defined: [count]
- Dashboards: [count]

Next steps:
1. Review the monitoring strategy
2. Start a NEW session
3. Run: /genesis-section-10
```
