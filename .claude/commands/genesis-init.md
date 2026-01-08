---
description: Initialize a new Genesis specification project. Creates directory structure and initial handoff file.
---

# Genesis Initialization

You are initializing a new Genesis specification project.

## Step 1: Create Directory Structure

Create the following directories:
- `genesis_output/sections/`
- `genesis_output/handoffs/`
- `genesis_output/research/`
- `genesis_output/final/`

## Step 2: Gather Project Information

Ask the user for:

1. **Project Name**: What is this project called?
2. **Project Description**: 1-2 paragraph overview
3. **Target Users**: Who will use this system?
4. **Key Technologies**: Any predetermined technology choices?
5. **Constraints**: Timeline, budget, team size, compliance requirements?
6. **Reference Materials**: Any existing documents, code, or research to reference?

## Step 3: Create Initial Handoff

Create `genesis_output/handoffs/handoff_00_init.json`:

```json
{
  "genesis_version": "1.0",
  "project": {
    "name": "[from user]",
    "description": "[from user]",
    "created_at": "[timestamp]",
    "target_users": "[from user]",
    "key_technologies": "[from user]",
    "constraints": "[from user]"
  },
  "reference_materials": [
    {
      "type": "[document/code/url]",
      "path": "[path or url]",
      "description": "[what it contains]"
    }
  ],
  "sections_completed": [],
  "current_section": null,
  "global_context": {
    "decisions": [],
    "assumptions": [],
    "open_questions": []
  }
}
```

## Step 4: Verify Reference Materials

If the user provided reference materials:

1. Read each one using the Read tool
2. Summarize key information
3. Add summaries to the handoff file

## Step 5: Output Instructions

Tell the user:

```
Genesis project initialized!

Next steps:
1. Start a NEW Claude Code session (for fresh context)
2. Run: /genesis-section-01

Or use the orchestrator:
$ ./genesis_orchestrator.sh

Your project files:
- Handoff: genesis_output/handoffs/handoff_00_init.json
- Sections will appear in: genesis_output/sections/

Tips:
- Run each section in a fresh session for best results
- Review each section before proceeding
- Use /genesis-status to check progress
```
