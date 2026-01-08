# Genesis Skill Auto-Trigger Rules

## When to Automatically Invoke /genesis

Invoke the `/genesis` skill immediately (without asking) when the user:

### Direct Requests
- "Create a technical specification"
- "Write a tech spec"
- "Design a system for..."
- "Architect a solution for..."
- "Plan a new application/feature/product"
- "Build prompt for..."
- "PRD for..."

### Implicit Requests
- "I want to build [something new]" - where [something] is a non-trivial application
- "Help me plan [a new system]"
- "I need to document requirements for..."
- "Spec out [feature/system]"

### Keywords That Trigger Genesis
When these appear in context of creating/planning:
- "technical specification"
- "tech spec"
- "system design"
- "architecture document"
- "PRD"
- "requirements document"
- "build prompt"
- "genesis"

## When NOT to Use /genesis

- Simple bug fixes or small code changes
- Questions about existing code
- Debugging sessions
- Quick prototypes (unless user asks for full spec)
- When user explicitly declines or asks for something else

## Invocation Pattern

When triggered, invoke like this:
```
/genesis "[user's core idea or request]"
```

Or with a file:
```
/genesis path/to/context.md
```

## After Genesis Completes

- Offer to run `/genesis-status` to check progress
- If sections are incomplete, offer to continue with `/genesis-section-XX`
- If all sections done, offer to compile with `/genesis-compile`
