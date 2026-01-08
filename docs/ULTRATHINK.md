# Ultrathink Integration for Genesis

## Overview

**Ultrathink** is a Claude Code feature that triggers extended thinking mode, allocating significantly more internal reasoning tokens before producing a response. This document describes how Genesis leverages ultrathink to produce world-class technical specifications.

## The Thinking Hierarchy

Claude Code recognizes these keywords that map to increasing thinking budgets:

```
"think" < "think hard" < "think harder" < "ultrathink"
```

Each level allocates progressively more computation time for internal reasoning.

## Why Ultrathink Matters for Genesis

Genesis aims to produce specifications so comprehensive that even open-source models can implement them in a single shot with SOTA results. This requires:

1. **Deep Analysis** - Understanding problem spaces thoroughly before prescribing solutions
2. **Tradeoff Evaluation** - Comparing multiple approaches and justifying choices
3. **Edge Case Discovery** - Anticipating failure modes and boundary conditions
4. **Architecture Reasoning** - Designing systems that scale and remain maintainable
5. **Requirement Precision** - Writing unambiguous, implementation-ready specifications

Ultrathink enables Claude to perform this level of analysis before committing to outputs.

## Strategic Ultrathink Deployment

Genesis uses ultrathink selectively at critical reasoning moments:

### Phase 1: Intake & Analysis (genesis.md)
```
ultrathink:
Analyze the user's project requirements deeply. Consider:
- What problem are they actually trying to solve?
- What are the implicit requirements not stated?
- What constraints should we surface?
- What clarifying questions would a 10x engineer ask?
```

### Phase 2: Research Synthesis (section subagents)
```
ultrathink:
Synthesize the research findings. For each technology choice:
- Compare at least 3 alternatives
- Evaluate against project constraints
- Consider team expertise and learning curve
- Identify risks and mitigations
```

### Phase 3: Architecture Design (sections 3, 5)
```
ultrathink:
Design the system architecture by:
- Analyzing all requirements and constraints
- Considering 3+ architectural patterns
- Evaluating scalability implications
- Identifying integration points and failure modes
- Justifying each major design decision
```

### Phase 4: Specification Writing (all sections)
```
ultrathink:
Write this specification section with the precision that:
- A junior developer could implement from it alone
- No ambiguity exists in requirements
- All edge cases are explicitly addressed
- Acceptance criteria are testable and measurable
```

### Phase 5: Review & Refinement (genesis-review.md)
```
ultrathink:
Critically review this specification for:
- Internal consistency across sections
- Missing requirements or edge cases
- Overly complex or underspecified areas
- Assumptions that need validation
- Implementation feasibility
```

## Ultrathink Prompt Patterns

### Pattern 1: Deep Problem Analysis
```
ultrathink:
Before we proceed, deeply analyze this problem space:

1. What is the core problem being solved?
2. Who are the stakeholders and what do they actually need?
3. What are the constraints (time, budget, team, technology)?
4. What are the risks if we get this wrong?
5. What does success look like in 6 months? 1 year?

Think through each aspect thoroughly before summarizing.
```

### Pattern 2: Technology Decision Matrix
```
ultrathink:
Evaluate technology options for [component]:

For each option, analyze:
- Maturity and community support
- Learning curve for the team
- Performance characteristics
- Operational complexity
- Cost implications
- Lock-in risks

Compare: [Option A] vs [Option B] vs [Option C]

Provide a justified recommendation with tradeoffs acknowledged.
```

### Pattern 3: Architecture Tradeoff Analysis
```
ultrathink:
Design the [component] architecture:

Consider these patterns:
1. [Pattern A] - when it works, when it fails
2. [Pattern B] - when it works, when it fails
3. [Pattern C] - when it works, when it fails

Given our constraints:
- Scale: [requirements]
- Team: [expertise]
- Timeline: [deadline]

Which pattern best fits? Justify with specific tradeoffs.
```

### Pattern 4: Requirement Precision
```
ultrathink:
Write implementation-ready requirements for [feature]:

For each requirement:
- State it unambiguously (no "should handle appropriately")
- Define specific acceptance criteria
- Specify error handling behavior
- Include performance expectations
- Note dependencies and assumptions

A developer reading this should have zero questions about what to build.
```

### Pattern 5: Adversarial Review
```
ultrathink:
Review this section as a hostile stakeholder would:

1. What's missing that will cause problems later?
2. What's ambiguous that developers will interpret differently?
3. What assumptions are unstated?
4. What edge cases aren't covered?
5. What will break at scale?
6. What security issues exist?

Be thorough and critical. Better to find issues now.
```

## When NOT to Use Ultrathink

Ultrathink consumes more tokens and adds latency. Don't use it for:

- Simple formatting or restructuring
- Copying content between sections
- Generating boilerplate
- Making minor edits
- Standard CRUD operations

Reserve ultrathink for moments requiring genuine deep reasoning.

## Implementation in Genesis Skills

### In Slash Commands

Commands use ultrathink at critical junctures:

```markdown
## Phase 2: Deep Analysis

ultrathink:
Before writing this section, deeply analyze:
[specific analysis instructions]

Then proceed with structured output.
```

### In Subagents

Research subagents use ultrathink for synthesis:

```markdown
After gathering sources, use ultrathink to:
- Synthesize findings into actionable insights
- Identify patterns across sources
- Resolve conflicting information
- Extract best practices relevant to our constraints
```

### In Handoff Files

Handoff files capture ultrathink reasoning:

```json
{
  "key_decisions": [
    {
      "decision": "Use PostgreSQL over MongoDB",
      "reasoning": "[ultrathink analysis captured here]",
      "alternatives_considered": ["MongoDB", "DynamoDB"],
      "tradeoffs": "[specific tradeoffs]"
    }
  ]
}
```

## Measuring Ultrathink Effectiveness

Genesis specifications should be evaluated on:

1. **Implementability** - Can a developer implement from the spec alone?
2. **Completeness** - Are all requirements and edge cases covered?
3. **Precision** - Is every requirement unambiguous?
4. **Justification** - Are decisions explained with tradeoffs?
5. **Consistency** - Do sections align without contradictions?

## Configuration

### Environment Variables

```bash
# Do NOT set MAX_THINKING_TOKENS if using per-request ultrathink
# unset MAX_THINKING_TOKENS

# If you want global thinking control instead:
# export MAX_THINKING_TOKENS=32000
```

### CLAUDE.md Integration

```markdown
## Thinking Guidelines

For complex reasoning tasks, use the thinking hierarchy:
- "think" - Light analysis
- "think hard" - Moderate complexity
- "think harder" - Complex problems
- "ultrathink" - Critical decisions requiring deep analysis

Genesis uses ultrathink for:
- Problem analysis
- Technology decisions
- Architecture design
- Requirement writing
- Specification review
```

## Best Practices

1. **Be Explicit About What to Analyze**
   Don't just say "ultrathink" - specify exactly what aspects to reason about.

2. **Request Structured Output After Thinking**
   Ultrathink should lead to well-organized deliverables, not stream-of-consciousness.

3. **Capture Reasoning in Handoffs**
   Key decisions and their justifications should persist between sessions.

4. **Use Subagents for Parallel Research**
   Let ultrathink synthesize findings from multiple research threads.

5. **Iterate with Review Passes**
   Use ultrathink for both generation and critical review.

## References

- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Extended Thinking Documentation](https://platform.claude.com/docs/en/build-with-claude/extended-thinking)
- [Claude Code Common Workflows](https://code.claude.com/docs/en/common-workflows)
