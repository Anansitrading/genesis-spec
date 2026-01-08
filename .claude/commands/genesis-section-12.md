---
allowed-tools: Read, Write, Task, Bash, mcp__raindrop__create_collection, mcp__raindrop__create_bookmark, mcp__raindrop__get_bookmarks, mcp__raindrop__search_bookmarks, mcp__perplexity-ask__perplexity_ask, mcp__firecrawl__firecrawl_scrape, mcp__exa__get_code_context_exa, mcp__context7__resolve-library-id, mcp__context7__query-docs
description: Generate Section 12 (Raindrop.io Documentation Collections) of the Genesis technical specification. Creates curated documentation collections.
---

# Genesis Section 12: Raindrop.io Documentation Collections

You are generating the Raindrop.io Documentation Collections section of a technical specification.

**IMPORTANT**: This section uses the Raindrop MCP to create ACTUAL bookmark collections, not just documentation.

## Pre-Flight Checks

1. **Verify Raindrop MCP is Available**:
   Test with: `mcp__raindrop__get_bookmarks` (collectionId: 0)
   If not available, inform user to set up Raindrop MCP.

2. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_00_init.json` (project info)
   - `genesis_output/handoffs/handoff_03_technology_stack.json` (technologies to document)
   - `genesis_output/handoffs/handoff_11_documentation_knowledge.json` (documentation needs)

3. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_12_Raindrop_Collections.md`

4. **Review All Research Artifacts**:
   Read all files in `genesis_output/research/` to gather sources already found.

## Phase 1: Create Raindrop Collections

Use the Raindrop MCP to create collections for this project:

### Create Project Parent Collection
```
mcp__raindrop__create_collection
  title: "[Project Name] - Technical Documentation"
  description: "Curated documentation for [Project Name] technical specification"
```

### Create Sub-Collections
Create these collections using `mcp__raindrop__create_collection`:

1. **Core Technology**
   - Title: "[Project] - Core Technology"
   - Description: "Official documentation for primary frameworks and languages"

2. **Frontend Development**
   - Title: "[Project] - Frontend"
   - Description: "Frontend framework docs, component libraries, state management"

3. **Backend & API**
   - Title: "[Project] - Backend & API"
   - Description: "Server-side documentation, API design, database"

4. **DevOps & Infrastructure**
   - Title: "[Project] - DevOps"
   - Description: "Deployment, CI/CD, containerization, cloud services"

5. **Security & Auth**
   - Title: "[Project] - Security"
   - Description: "Authentication, authorization, security best practices"

6. **Testing & Quality**
   - Title: "[Project] - Testing"
   - Description: "Testing frameworks, coverage, E2E testing"

7. **Onboarding & Learning**
   - Title: "[Project] - Onboarding"
   - Description: "Essential reading for new team members"

Record the collection IDs returned for each.

## Phase 2: Research Documentation Sources

Launch parallel research using MCP tools:

### Research 1: Official Documentation
Use `mcp__context7__resolve-library-id` and `mcp__context7__query-docs` to get:
- Official docs for each technology in the stack
- API references
- Getting started guides

### Research 2: Current Best Practices
Use `mcp__perplexity-ask__perplexity_ask` to find:
- "[framework] official documentation 2025"
- "[library] best practices guide"
- "[technology] migration guide"

### Research 3: Code Examples
Use `mcp__exa__get_code_context_exa` to find:
- Example implementations
- Tutorial repositories
- Reference architectures

### Research 4: Verify URLs
Use `mcp__firecrawl__firecrawl_scrape` to verify documentation URLs are valid and extract key content.

## Phase 3: Create Bookmarks

For each documentation resource found, create a bookmark using `mcp__raindrop__create_bookmark`:

### Bookmark Template
```
mcp__raindrop__create_bookmark
  link: "[URL]"
  title: "[Descriptive Title]"
  collectionId: [collection ID from Phase 1]
  tags: ["[technology]", "[category]", "[priority]"]
  excerpt: "[1-2 sentence description and why it's important]"
  important: [true for must-read resources]
```

### Priority Tags
- `must-read` - Essential for all team members
- `reference` - Look up as needed
- `deep-dive` - For advanced understanding
- `onboarding` - New team member essentials

### Categories to Bookmark

**Core Technology (10-15 bookmarks)**
- Language documentation (TypeScript, Python, etc.)
- Framework official docs (Next.js, FastAPI, etc.)
- Runtime documentation (Node.js, Deno, etc.)

**Frontend (8-12 bookmarks)**
- UI component library docs
- State management guide
- Styling documentation (Tailwind, CSS-in-JS)
- Build tool documentation

**Backend (8-12 bookmarks)**
- API framework documentation
- Database documentation
- ORM/query builder docs
- Cache and queue documentation

**DevOps (6-10 bookmarks)**
- Cloud provider documentation
- CI/CD platform docs
- Containerization guides
- IaC tool documentation

**Security (5-8 bookmarks)**
- Authentication provider docs
- OWASP guidelines
- Encryption best practices
- Compliance guides (if applicable)

**Testing (5-8 bookmarks)**
- Test framework documentation
- Mocking library docs
- E2E testing guides
- Coverage tool documentation

**Onboarding (5-10 bookmarks)**
- Project-specific getting started
- Architecture overview resources
- Coding standards guide
- Team workflow documentation

## Phase 4: Create Learning Path

Create a recommended reading order in the Onboarding collection:

1. **Day 1: Core Concepts** (mark as important)
   - Language basics
   - Framework overview
   - Project architecture doc

2. **Week 1: Deep Fundamentals**
   - Full framework documentation
   - Database patterns
   - API design standards

3. **Month 1: Advanced Topics**
   - Performance optimization
   - Security hardening
   - Scaling patterns

## Output Requirements

### Section Output
Write to `genesis_output/sections/12_raindrop_collections.md`:

Include:
- List of all collections created with IDs
- All bookmarks organized by collection
- Learning path with reading order
- Instructions for accessing collections

### Handoff Output
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

  "raindrop_collections": [
    {
      "name": "Core Technology",
      "collection_id": "[ID from Raindrop]",
      "bookmark_count": "[count]",
      "url": "https://app.raindrop.io/my/[ID]"
    }
  ],

  "bookmarks_created": [
    {
      "title": "[title]",
      "url": "[url]",
      "collection": "[collection name]",
      "tags": ["tag1", "tag2"],
      "priority": "must-read"
    }
  ],

  "learning_path": [
    {"order": 1, "title": "[bookmark title]", "purpose": "why read first", "time": "30 min"}
  ],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": []
}
```

## Completion Message

```
Section 12: Raindrop.io Documentation Collections - COMPLETE

RAINDROP COLLECTIONS CREATED:
✓ [Project] - Core Technology ([X] bookmarks)
✓ [Project] - Frontend ([X] bookmarks)
✓ [Project] - Backend & API ([X] bookmarks)
✓ [Project] - DevOps ([X] bookmarks)
✓ [Project] - Security ([X] bookmarks)
✓ [Project] - Testing ([X] bookmarks)
✓ [Project] - Onboarding ([X] bookmarks)

Total: [X] collections, [X] bookmarks

ACCESS YOUR COLLECTIONS:
https://app.raindrop.io/my/[parent-collection-id]

LEARNING PATH:
1. [First resource] - [purpose]
2. [Second resource] - [purpose]
3. ...

ALL 12 SECTIONS COMPLETE!

Next steps:
1. Review your Raindrop collections
2. Share collection links with team
3. Start a NEW session
4. Run: /genesis-compile

This will compile all 12 sections into the final technical specification.
```

## Error Handling

If Raindrop MCP is not available:
1. Document the bookmarks in markdown format only
2. Provide instructions for manual import
3. Note in handoff that collections were not created automatically
