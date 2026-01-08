---
description: Generate Section 8 (Testing Strategy) of the Genesis technical specification. Documents testing pyramid, automation, and quality gates.
---

# Genesis Section 08: Testing Strategy

You are generating the Testing Strategy section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_02_product_requirements.json` (what to test)
   - `genesis_output/handoffs/handoff_03_technology_stack.json` (testing tools)
   - `genesis_output/handoffs/handoff_06_data_models_schema.json` (entities to test)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_08_Testing_Strategy.md`

3. **Review Previous Sections**:
   - Read `genesis_output/sections/02_product_requirements.md`
   - Read `genesis_output/sections/06_data_models_schema.md`

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Testing Frameworks

```
Use genesis-perplexity agent to research:
- Best testing frameworks for [technology stack]
- Vitest vs Jest comparison 2025
- E2E testing (Playwright vs Cypress)
- Component testing strategies

Return: Framework recommendations, configuration patterns
```

### Subagent 2: Testing Patterns

```
Use genesis-researcher agent to research:
- Testing pyramid best practices
- Test coverage strategies
- Mocking patterns for [services]
- Integration testing approaches

Return: Testing patterns, coverage targets, mocking strategies
```

### Subagent 3: AI Testing (if applicable)

```
Use genesis-documentation agent to research:
- Testing LLM integrations
- Prompt testing strategies
- AI output validation
- Determinism in AI testing

Return: AI testing patterns, evaluation approaches
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Testing Strategy section:

### 8.1 Testing Pyramid
- Unit test strategy
- Integration test strategy
- E2E test strategy
- Coverage targets by layer

### 8.2 Testing Frameworks & Tools
- Unit testing: Vitest/Jest
- Component testing: Testing Library
- E2E testing: Playwright
- API testing: Supertest
- Mocking: MSW

### 8.3 Test Categories
For each feature:
- Unit tests required
- Integration tests required
- E2E scenarios
- Edge cases

### 8.4 Test Data Management
- Fixtures strategy
- Database seeding
- Mock data generation
- Cleanup procedures

### 8.5 Quality Gates
- Pre-commit checks
- CI pipeline stages
- Coverage thresholds
- Performance budgets

### 8.6 Testing Environments
- Local development
- CI environment
- Staging environment
- Production validation

## Output Requirements

Write to `genesis_output/sections/08_testing_strategy.md`

Create `genesis_output/handoffs/handoff_08_testing_strategy.json`:

```json
{
  "section_number": 8,
  "section_name": "Testing Strategy",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "testing_frameworks": {
      "unit": "Vitest",
      "component": "Testing Library",
      "e2e": "Playwright",
      "api": "Supertest"
    },
    "coverage_targets": {
      "unit": "80%",
      "integration": "70%",
      "e2e": "critical paths"
    }
  },

  "test_counts": {
    "unit_tests": "[estimated count]",
    "integration_tests": "[estimated count]",
    "e2e_scenarios": "[estimated count]"
  },

  "quality_gates": [
    {"gate": "name", "threshold": "value", "blocking": true}
  ],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_09": "What to monitor based on tests",
    "for_section_10": "CI/CD integration requirements"
  }
}
```

## Completion Message

```
Section 08: Testing Strategy - COMPLETE

Summary:
- Unit Testing: [framework]
- E2E Testing: [framework]
- Coverage Target: [percentage]
- Quality Gates: [count]

Next steps:
1. Review the testing strategy
2. Start a NEW session
3. Run: /genesis-section-09
```
