---
description: Generate Section 6 (Data Models & Schema) of the Genesis technical specification. Documents database schema, TypeScript types, and data validation.
---

# Genesis Section 06: Data Models & Schema

You are generating the Data Models & Schema section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_02_product_requirements.json` (data needs)
   - `genesis_output/handoffs/handoff_05_architecture_design.json` (architecture)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_06_Data_Models_Schema.md`

3. **Review Previous Sections**:
   - Read `genesis_output/sections/02_product_requirements.md`
   - Read `genesis_output/sections/05_architecture_design.md`

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Database Schema Patterns

```
Use genesis-researcher agent to research:
- Database schema patterns for [database type]
- Indexing strategies for [query patterns]
- Migration best practices

Return: Schema patterns, indexing recommendations, migration strategies
```

### Subagent 2: TypeScript Modeling

```
Use genesis-perplexity agent to research:
- TypeScript type modeling best practices
- Zod validation patterns
- Type-safe database queries (Prisma/Drizzle)

Return: Type modeling patterns, validation approaches
```

### Subagent 3: Existing Data Models (if applicable)

```
Use genesis-codebase-explorer agent to:
- Find existing data models
- Analyze current schema
- Identify type definitions

Return: Current models, schema analysis, type patterns
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Data Models & Schema section:

### 6.1 Entity Relationship Diagram
- Mermaid ER diagram
- Entity descriptions
- Relationship explanations

### 6.2 Database Schema
For each table:
- Table name and purpose
- Column definitions with types
- Constraints (PK, FK, unique, check)
- Indexes

### 6.3 TypeScript Interfaces
- Core domain types
- API request/response types
- Form data types
- State types

### 6.4 Validation Schemas
- Zod schemas for each type
- Validation rules
- Custom validators
- Error messages

### 6.5 Data Migrations
- Migration strategy
- Seed data approach
- Rollback procedures

### 6.6 Data Access Patterns
- Repository patterns
- Query optimization
- Caching layer

## Output Requirements

Write to `genesis_output/sections/06_data_models_schema.md`

Create `genesis_output/handoffs/handoff_06_data_models_schema.json`:

```json
{
  "section_number": 6,
  "section_name": "Data Models & Schema",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "total_entities": "[count]",
    "entities": ["Entity1", "Entity2"],
    "total_tables": "[count]",
    "typescript_types": "[count]",
    "validation_schemas": "[count]"
  },

  "entity_summary": [
    {
      "name": "EntityName",
      "table": "table_name",
      "fields": ["field1", "field2"],
      "relationships": ["relates to X"]
    }
  ],

  "indexing_strategy": [
    {"table": "name", "index": "description", "purpose": "why"}
  ],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_07": "Data that needs protection",
    "for_section_08": "Entities to test"
  }
}
```

## Completion Message

```
Section 06: Data Models & Schema - COMPLETE

Summary:
- Total Entities: [X]
- Database Tables: [X]
- TypeScript Types: [X]
- Validation Schemas: [X]

Next steps:
1. Review the data models
2. Start a NEW session
3. Run: /genesis-section-07
```
