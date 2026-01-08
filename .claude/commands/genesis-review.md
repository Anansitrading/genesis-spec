---
allowed-tools: Read, Glob, Grep, Write, Edit, Task, WebFetch
argument-hint: [section-number]
description: Review and improve a generated Genesis section
model: opus
---

# Genesis Section Review

Review and improve a generated Genesis section for quality and completeness.

## Target Section
Section to review: $1

If no section specified, review the most recently generated section.

## Review Process

### 1. Load Section Content
Read `genesis_output/sections/$1*.md` (or find the latest if not specified).

### 2. Quality Checklist

Evaluate against these criteria:

**Completeness**
- [ ] All required subsections present
- [ ] No placeholder text or TODOs remaining
- [ ] Cross-references to other sections are accurate

**Specificity**
- [ ] No vague language ("various", "multiple", "etc.")
- [ ] All metrics have specific targets
- [ ] All features have acceptance criteria

**Technical Accuracy**
- [ ] Code examples are syntactically correct
- [ ] Mermaid diagrams render properly
- [ ] Technology versions are current and compatible

**Consistency**
- [ ] Terminology matches previous sections
- [ ] Feature IDs (F-XXX) are consistent
- [ ] Requirement IDs follow naming convention

**Professionalism**
- [ ] Clear, technical writing style
- [ ] Proper markdown formatting
- [ ] No typos or grammatical errors

### 3. Generate Improvement Report

Create a report listing:
1. **Critical Issues** - Must fix before proceeding
2. **Improvements** - Should fix for quality
3. **Suggestions** - Nice to have enhancements

### 4. Apply Fixes

If user approves, apply the improvements directly to the section file.

### 5. Update Handoff

If significant changes were made, update the corresponding handoff file.

Begin by loading the specified section and running the quality checklist.
