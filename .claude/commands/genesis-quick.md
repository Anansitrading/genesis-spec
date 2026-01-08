---
allowed-tools: Bash(*), Read, Write, Edit, Glob, Grep, Task
argument-hint: <build-prompt-file>
description: Quick Genesis start - minimal intake for experienced users
model: opus
---

# Genesis Quick Start

Fast-track Genesis initialization for users who have a well-defined build prompt.

## Input
Build prompt file: @$1

## Process

1. **Read and validate the build prompt**:
   - Check it has: project name, description, target users, core features
   - Identify any critical missing information

2. **Quick clarification** (only if essential info is missing):
   - Ask maximum 3 targeted questions
   - Focus on: scale expectations, technology constraints, compliance needs

3. **Generate handoff immediately**:
   - Create `genesis_output/handoffs/handoff_00_init.json`
   - Copy build prompt to `genesis_sources/build_prompt.md`

4. **Start Section 01 automatically** after confirmation

## Quality Check

Before proceeding, verify the build prompt includes:
- [ ] Clear project name and description
- [ ] At least 2 defined user types
- [ ] 5+ specific features with acceptance criteria
- [ ] Performance/scale expectations
- [ ] Technology preferences or constraints

If any are missing, ask ONE consolidated question to gather them.

Begin by reading the provided file and assessing its completeness.
