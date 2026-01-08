---
description: Compile all Genesis sections into a single comprehensive technical specification.
---

# Genesis Compile: Final Specification

You are compiling all Genesis sections into a final technical specification.

## Pre-Flight Checks

1. **Verify All Sections Complete**:
   Check that all 12 handoff files exist:
   - handoff_01_introduction.json
   - handoff_02_product_requirements.json
   - ... through handoff_12_raindrop.json

2. **Read All Section Outputs**:
   Read all files in `genesis_output/sections/`

3. **Read All Handoffs**:
   Read all files in `genesis_output/handoffs/` for context

## Compilation Process

### Step 1: Create Document Structure

```markdown
# [Project Name] - Technical Specification

**Version:** 1.0
**Generated:** [timestamp]
**Status:** Complete

## Table of Contents
[Auto-generate from sections]

---

## Section 1: Introduction
[Content from 01_introduction.md]

## Section 2: Product Requirements
[Content from 02_product_requirements.md]

... [Continue for all 12 sections]

---

## Appendices

### Appendix A: Glossary
[Extract and define all technical terms]

### Appendix B: Decision Log
[Compile all decisions from handoffs]

### Appendix C: Assumptions Register
[Compile all assumptions from handoffs]

### Appendix D: Open Questions
[Compile all unresolved questions]

### Appendix E: Research Bibliography
[Compile all sources from research outputs]
```

### Step 2: Cross-Reference Validation

- Verify all feature IDs are consistent
- Verify all requirement IDs are referenced
- Check all internal links work
- Verify Mermaid diagrams render

### Step 3: Create Executive Summary

Generate a 2-page executive summary covering:
- Project overview
- Key architecture decisions
- Technology stack summary
- Implementation timeline
- Risk summary

### Step 4: Output Files

Create `genesis_output/final/technical_specification.md`
Create `genesis_output/final/executive_summary.md`
Create `genesis_output/final/compilation_report.json`:

```json
{
  "compiled_at": "[timestamp]",
  "total_sections": 12,
  "total_features": "[count from handoffs]",
  "total_requirements": "[count from handoffs]",
  "total_pages": "[estimated]",
  "all_decisions": [],
  "all_assumptions": [],
  "open_questions": [],
  "sources": []
}
```

## Completion Message

```
Genesis Compilation - COMPLETE

Final outputs:
✓ genesis_output/final/technical_specification.md
✓ genesis_output/final/executive_summary.md
✓ genesis_output/final/compilation_report.json

Specification Summary:
- Total Sections: 12
- Total Features: [X]
- Total Requirements: [X]
- Estimated Pages: [X]

Decisions Made: [X]
Assumptions: [X]
Open Questions: [X]

The technical specification is ready for review!
```
