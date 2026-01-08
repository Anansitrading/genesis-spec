---
allowed-tools: Read, Write, Task, mcp__perplexity-ask__perplexity_ask, mcp__firecrawl__firecrawl_search, mcp__firecrawl__firecrawl_scrape, mcp__exa__web_search_exa, mcp__exa__get_code_context_exa, mcp__context7__resolve-library-id, mcp__context7__query-docs
argument-hint: <research-topic>
description: Deep research mode using ultrathink for comprehensive analysis on any topic
model: opus
---

# Genesis Ultrathink: Deep Research Mode

You are entering deep research mode. This skill uses ultrathink (extended thinking) combined with multiple research sources to produce world-class analysis on any topic.

## Research Topic
$ARGUMENTS

## Phase 1: Problem Decomposition

ultrathink:
Before researching, deeply decompose this topic:

1. What is the core question being asked?
2. What sub-questions must be answered to address the core?
3. What domains of knowledge are relevant?
4. What are the likely sources of authoritative information?
5. What biases might exist in available sources?
6. What would a world-class expert want to know?

Decompose into 5-10 specific, researchable sub-questions.

## Phase 2: Multi-Source Research

Launch parallel research threads using all available MCP tools:

### Thread 1: Academic & Expert Sources (Perplexity)
```
Use mcp__perplexity-ask__perplexity_ask with queries like:
- "[topic] best practices 2025"
- "[topic] expert recommendations"
- "[topic] research findings"
- "[topic] industry standards"
- "[topic] common mistakes to avoid"
```

### Thread 2: Technical Documentation (Context7)
```
Use mcp__context7__resolve-library-id to find relevant libraries
Then use mcp__context7__query-docs to get:
- Official documentation
- API references
- Best practice guides
- Migration guides
```

### Thread 3: Code Context (Exa)
```
Use mcp__exa__get_code_context_exa to find:
- Implementation examples
- Reference architectures
- Tutorial code
- Production patterns
```

### Thread 4: Deep Web Content (Firecrawl)
```
Use mcp__firecrawl__firecrawl_search to find:
- In-depth articles
- Case studies
- Technical blogs
- Comparison guides

Then use mcp__firecrawl__firecrawl_scrape for full content.
```

## Phase 3: Synthesis & Analysis

ultrathink:
Synthesize all research findings:

1. What are the consistent themes across sources?
2. Where do sources disagree? Why?
3. What is the current consensus (if any)?
4. What is emerging vs established knowledge?
5. What gaps exist in available information?
6. What would change our conclusions?

Produce a synthesis that:
- Weighs evidence by source quality
- Acknowledges uncertainty explicitly
- Distinguishes fact from opinion
- Identifies actionable insights

## Phase 4: Structured Output

Present findings in this format:

```markdown
# Deep Research: [Topic]

## Executive Summary
[2-3 paragraph synthesis of key findings]

## Key Findings

### Finding 1: [Title]
**Confidence: High/Medium/Low**
**Sources: [list sources]**

[Detailed explanation with evidence]

### Finding 2: [Title]
[Same structure]

## Areas of Consensus
- [Point 1]: Supported by [X] sources
- [Point 2]: Supported by [X] sources

## Areas of Debate
- [Controversy 1]: [Position A] vs [Position B]
  - Evidence for A: [summary]
  - Evidence for B: [summary]
  - Assessment: [which is more credible and why]

## Best Practices Identified
1. [Practice 1]: [Justification]
2. [Practice 2]: [Justification]

## Common Pitfalls to Avoid
1. [Pitfall 1]: [Why it's problematic]
2. [Pitfall 2]: [Why it's problematic]

## Recommendations
Based on this research:

| Priority | Recommendation | Rationale | Risk if Ignored |
|----------|---------------|-----------|-----------------|
| 1 | [Rec] | [Why] | [Risk] |
| 2 | [Rec] | [Why] | [Risk] |

## Knowledge Gaps
- [Gap 1]: What we don't know and why it matters
- [Gap 2]: What we don't know and why it matters

## Sources
- [Source 1]: [URL] - [Brief description of value]
- [Source 2]: [URL] - [Brief description of value]

## Methodology
Research conducted using:
- Perplexity AI for expert synthesis
- Context7 for library documentation
- Exa for code context
- Firecrawl for deep web content

Date: [current date]
Model: Claude Opus 4.5 with ultrathink enabled
```

## Phase 5: Save Artifacts

Write research output to `genesis_output/research/ultrathink_research_[topic-slug].md`

## Usage Examples

### Technology Evaluation
```
/genesis-ultrathink "Compare PostgreSQL vs MongoDB for a high-write analytics workload with 1M events/day"
```

### Architecture Decision
```
/genesis-ultrathink "Best practices for microservices authentication in 2025"
```

### Implementation Guidance
```
/genesis-ultrathink "How to implement rate limiting in Node.js at scale"
```

### Best Practices Research
```
/genesis-ultrathink "React Server Components best practices and common pitfalls"
```

## Quality Standards

This research should be:

1. **Authoritative** - Based on credible sources, not opinions
2. **Current** - Reflecting 2025 best practices, not outdated advice
3. **Actionable** - Providing specific recommendations, not vague guidance
4. **Balanced** - Acknowledging tradeoffs, not dogmatic
5. **Comprehensive** - Covering the topic thoroughly, not superficially

The goal is research quality that would satisfy a Staff+ engineer making a critical technology decision.

Begin deep research now on: $ARGUMENTS
