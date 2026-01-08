---
description: Generate Section 12 (Raindrop.io Documentation Collections) of the Genesis technical specification. Creates curated documentation collections.
---

# Genesis Section 12: Raindrop.io Documentation Collections

You are generating the Raindrop.io Documentation Collections section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_03_technology_stack.json` (technologies to document)
   - `genesis_output/handoffs/handoff_11_documentation_knowledge.json` (documentation needs)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_12_Raindrop_Collections.md`

3. **Review All Research Artifacts**:
   Read all files in `genesis_output/research/` to gather sources.

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Framework Documentation

```
Use genesis-documentation agent to research:
- Official documentation for [frontend framework]
- Official documentation for [backend framework]
- Official documentation for [database]
- Key tutorials and guides

Return: Documentation links with descriptions
```

### Subagent 2: Tool Documentation

```
Use genesis-perplexity agent to research:
- Documentation for [monitoring tools]
- Documentation for [testing tools]
- Documentation for [deployment tools]
- Best practice guides

Return: Tool documentation links
```

### Subagent 3: Pattern References

```
Use genesis-researcher agent to research:
- Design pattern references
- Architecture pattern guides
- Security best practice guides
- Performance optimization guides

Return: Pattern and guide references
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Raindrop.io Documentation Collections section:

### 12.1 Collection Structure
- Core Technology Collection
- Frontend Collection
- Backend Collection
- DevOps Collection
- Security Collection
- Testing Collection
- Design Patterns Collection

### 12.2 Bookmark Format
For each bookmark:
```
**Title:** [Descriptive title]
**URL:** [url]
**Tags:** [tag1, tag2, tag3]
**Collection:** [collection name]
**Description:** [1-2 sentences]
**Notes:** [Key takeaways, specific sections to read]
**Priority:** [Must Read / Reference / Deep Dive]
```

### 12.3 Core Technology Bookmarks
- Framework official docs
- Language references
- Database documentation

### 12.4 Development Practice Bookmarks
- Testing guides
- Code style guides
- Git workflow guides

### 12.5 Operations Bookmarks
- Deployment guides
- Monitoring setup
- Incident response

### 12.6 Learning Path
- Onboarding reading order
- Deep dive topics
- Advanced topics

## Output Requirements

Write to `genesis_output/sections/12_raindrop_collections.md`

Create `genesis_output/handoffs/handoff_12_raindrop_collections.json`:

```json
{
  "section_number": 12,
  "section_name": "Raindrop.io Documentation Collections",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "total_collections": "[count]",
    "total_bookmarks": "[count]",
    "must_read_count": "[count]"
  },

  "collections": [
    {
      "name": "Core Technology",
      "bookmark_count": "[count]",
      "tags": ["tag1", "tag2"]
    }
  ],

  "bookmarks_by_priority": {
    "must_read": "[count]",
    "reference": "[count]",
    "deep_dive": "[count]"
  },

  "learning_path": [
    {"order": 1, "bookmark": "title", "purpose": "why read first"}
  ],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": []
}
```

## Completion Message

```
Section 12: Raindrop.io Documentation Collections - COMPLETE

Summary:
- Total Collections: [X]
- Total Bookmarks: [X]
- Must-Read Resources: [X]

ALL SECTIONS COMPLETE!

Next steps:
1. Review the documentation collections
2. Start a NEW session
3. Run: /genesis-compile

This will compile all 12 sections into the final technical specification.

Alternatively:
$ ./genesis_orchestrator.sh --compile
```
