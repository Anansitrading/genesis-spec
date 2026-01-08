---
allowed-tools: Bash(*)
argument-hint: [--init | --continue | --status | --compile]
description: Run Genesis orchestrator with specified action
model: sonnet
---

# Genesis Orchestrator Control

Run the Genesis orchestrator script with the specified action.

## Arguments
Action: $ARGUMENTS

## Available Actions

- `--init` - Initialize a new Genesis project
- `--continue` - Continue from last completed section
- `--status` - Show project status
- `--section N` - Run specific section (01-12)
- `--auto` - Run all sections without pauses
- `--compile` - Compile final specification

## Execution

Run the orchestrator:
```bash
./genesis_orchestrator.sh $ARGUMENTS
```

Report the output to the user and suggest next steps based on the result.
