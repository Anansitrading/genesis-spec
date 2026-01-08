---
description: Check the status of Genesis specification generation. Shows which sections are complete and what's next.
---

# Genesis Status Check

Check the current state of the Genesis specification generation.

## Check All Handoffs

Read the following files and report their status:

1. `genesis_output/handoffs/handoff_00_init.json` - Initialization
2. `genesis_output/handoffs/handoff_01_introduction.json` - Section 1
3. `genesis_output/handoffs/handoff_02_product_requirements.json` - Section 2
4. `genesis_output/handoffs/handoff_03_technology_stack.json` - Section 3
5. `genesis_output/handoffs/handoff_04_process_flowcharts.json` - Section 4
6. `genesis_output/handoffs/handoff_05_architecture_design.json` - Section 5
7. `genesis_output/handoffs/handoff_06_data_models_schema.json` - Section 6
8. `genesis_output/handoffs/handoff_07_security_compliance.json` - Section 7
9. `genesis_output/handoffs/handoff_08_testing_strategy.json` - Section 8
10. `genesis_output/handoffs/handoff_09_monitoring_observability.json` - Section 9
11. `genesis_output/handoffs/handoff_10_deployment_operations.json` - Section 10
12. `genesis_output/handoffs/handoff_11_documentation_knowledge.json` - Section 11
13. `genesis_output/handoffs/handoff_12_raindrop_collections.json` - Section 12

## Check Final Output

Check if `genesis_output/final/technical_specification.md` exists.

## Generate Status Report

```
=========================================
         GENESIS PROJECT STATUS
=========================================

Project: [name from handoff_00]
Started: [timestamp from handoff_00]

SECTIONS:
  ✓ = Complete    ○ = Pending    ✗ = Error

[00] Initialization ................. [✓/○]
[01] Introduction ................... [✓/○]
[02] Product Requirements ........... [✓/○]
[03] Technology Stack ............... [✓/○]
[04] Process Flowcharts ............. [✓/○]
[05] Architecture & Design .......... [✓/○]
[06] Data Models & Schema ........... [✓/○]
[07] Security & Compliance .......... [✓/○]
[08] Testing Strategy ............... [✓/○]
[09] Monitoring & Observability ..... [✓/○]
[10] Deployment & Operations ........ [✓/○]
[11] Documentation & Knowledge ...... [✓/○]
[12] Raindrop.io Collections ........ [✓/○]

FINAL COMPILATION: [✓/○]

=========================================
NEXT STEP: [What to do next]
COMMAND: [Exact command to run]
=========================================
```

## Report Decisions and Open Questions

If any sections are complete, summarize:
- Total decisions made
- Total assumptions documented
- Open questions requiring stakeholder input
