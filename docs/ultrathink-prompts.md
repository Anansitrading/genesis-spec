# Ultrathink Prompt Templates for Genesis Sections

This file contains ready-to-use ultrathink prompts for each Genesis section. Copy and adapt these templates when generating specifications.

## Section 01: Introduction

### Initial Analysis
```
ultrathink:
Analyze this project's context deeply before writing the introduction:

1. What is the core problem being solved? (not the solution, the problem)
2. Why does this problem exist? What market/technical conditions created it?
3. Who experiences this pain most acutely? What's their current workaround?
4. What makes NOW the right time to build this?
5. What would success look like from each stakeholder's perspective?

Synthesize into a compelling but precise introduction.
```

### Vision Statement
```
ultrathink:
Craft a vision statement that is:
- Specific enough to guide decisions
- Broad enough to allow innovation
- Measurable in its success criteria
- Inspiring without being vague

Consider: What would make this project undeniably successful in 1 year?
```

## Section 02: Product Requirements

### Feature Analysis
```
ultrathink:
For each P0 feature, analyze:

1. What user need does this address? (with evidence)
2. What is the minimum viable implementation?
3. What are the edge cases that could cause failure?
4. What dependencies exist with other features?
5. What acceptance criteria would prove this works?

Be ruthlessly specific. "Works correctly" is not an acceptance criterion.
```

### User Story Refinement
```
ultrathink:
Review these user stories as a hostile QA engineer would:

1. Is the "so that" actually the real motivation?
2. Are the acceptance criteria testable by automation?
3. What's missing that developers will discover mid-sprint?
4. What edge cases aren't covered?
5. Could a junior developer implement this without questions?

Refine until the answer to #5 is "yes".
```

## Section 03: Technology Stack

### Technology Decision Matrix
```
ultrathink:
For [component], evaluate technology options rigorously:

CRITERIA (weighted by project priorities):
- Team expertise (weight: [X])
- Ecosystem maturity (weight: [X])
- Performance characteristics (weight: [X])
- Operational complexity (weight: [X])
- Long-term viability (weight: [X])
- Cost implications (weight: [X])

CANDIDATES:
1. [Option A] - Score each criterion 1-5
2. [Option B] - Score each criterion 1-5
3. [Option C] - Score each criterion 1-5

RECOMMENDATION: [Winner] because [specific reasons]
RISKS: [Identified risks with mitigations]
```

### Integration Analysis
```
ultrathink:
Analyze how this technology stack integrates:

1. Where are the integration boundaries?
2. What data formats cross those boundaries?
3. Where are performance bottlenecks likely?
4. What happens when [component] fails?
5. How do we monitor the system end-to-end?

Map the complete request flow through all components.
```

## Section 04: Process Flowcharts

### Flow Validation
```
ultrathink:
For each process flow, validate:

1. What triggers this flow? (all entry points)
2. What are the happy path steps?
3. What error conditions exist at each step?
4. How does the flow recover from errors?
5. What timeouts and retries apply?
6. What state is persisted at each step?
7. What happens on partial failure?

Ensure every decision point has exactly 2+ explicit branches.
```

### Edge Case Discovery
```
ultrathink:
Think adversarially about this flow:

1. What if the user cancels mid-flow?
2. What if external service X is down?
3. What if data is corrupted/invalid?
4. What if this runs concurrently with itself?
5. What if the user has no permissions?
6. What if we're at scale (10x current)?

Document handling for each scenario.
```

## Section 05: Architecture & Design

### Architecture Tradeoffs
```
ultrathink:
Design the architecture considering these tradeoffs:

CONSISTENCY vs AVAILABILITY:
- What's our CAP theorem position?
- Where can we accept eventual consistency?
- What requires strong consistency?

COMPLEXITY vs FLEXIBILITY:
- Where should we abstract vs hardcode?
- What's likely to change vs stable?
- What's the cost of wrong abstractions?

PERFORMANCE vs MAINTAINABILITY:
- Where do we optimize prematurely?
- Where do we know we need performance?
- How do we measure and iterate?

Document explicit decisions with justifications.
```

### API Design
```
ultrathink:
Design APIs with these principles:

1. Is this intuitive for a new developer?
2. Are errors self-explanatory?
3. Is versioning strategy clear?
4. Are breaking changes obvious?
5. Is pagination consistent?
6. Are response shapes predictable?
7. How do we handle partial failures?

For each endpoint, define:
- Request/response shapes
- Error codes and meanings
- Rate limits and quotas
- Authentication requirements
```

## Section 06: Data Models

### Schema Design
```
ultrathink:
Design the data model considering:

1. What are the core entities? (not tables, domain entities)
2. What relationships exist between them?
3. What invariants must always hold?
4. What queries will be most common?
5. What data grows unbounded?
6. What requires audit trails?
7. What has compliance implications (PII, etc.)?

Start with domain model, then derive physical schema.
```

### Migration Strategy
```
ultrathink:
Plan data migrations considering:

1. What's the zero-downtime migration path?
2. What rollback strategy exists?
3. How long will migration take at scale?
4. What data validation is required?
5. What monitoring proves migration success?

Never migrate data without a proven rollback.
```

## Section 07: Security & Compliance

### Threat Modeling
```
ultrathink:
Model threats using STRIDE framework:

SPOOFING: How could someone impersonate a user?
TAMPERING: How could someone modify data maliciously?
REPUDIATION: How could someone deny actions?
INFORMATION DISCLOSURE: Where could data leak?
DENIAL OF SERVICE: How could availability be attacked?
ELEVATION OF PRIVILEGE: How could access be escalated?

For each threat:
- Likelihood: High/Medium/Low
- Impact: High/Medium/Low
- Mitigation: [Specific control]
```

### Compliance Checklist
```
ultrathink:
For [compliance standard], verify:

1. What data is in scope?
2. What controls are required?
3. What audit evidence is needed?
4. What gaps exist in current design?
5. What's the remediation plan for gaps?

Be specific about implementation, not aspirational.
```

## Section 08: Testing Strategy

### Test Coverage Analysis
```
ultrathink:
Design testing strategy with coverage matrix:

UNIT TESTS:
- What logic requires unit testing?
- What mocking strategy for dependencies?
- What coverage target and why?

INTEGRATION TESTS:
- What integration points need testing?
- What test data strategy?
- How do we test failure scenarios?

E2E TESTS:
- What user journeys are critical?
- What's the flakiness mitigation strategy?
- How do we maintain test speed?

Map each P0 feature to specific test types.
```

## Section 09: Monitoring & Observability

### Observability Design
```
ultrathink:
Design observability for operational excellence:

METRICS:
- What are the 4 golden signals for each service?
- What business metrics matter?
- What's the alerting threshold and why?

LOGGING:
- What log levels for what scenarios?
- What structured fields are required?
- How long to retain and where?

TRACING:
- What spans are needed for debugging?
- How do we correlate across services?
- What sampling rate and why?

Define dashboards for each operational scenario.
```

## Section 10: Deployment & Operations

### Deployment Strategy
```
ultrathink:
Design deployment for zero-downtime:

1. What's the deployment sequence?
2. How do we verify successful deployment?
3. What triggers automatic rollback?
4. How long should canary run?
5. What's the blast radius at each stage?
6. How do we handle database migrations during deploy?

Define the specific runbook for each scenario.
```

### Incident Response
```
ultrathink:
Design incident response for each severity level:

SEV1 (Service down):
- Who is paged?
- What's the first 5 minutes?
- What communication goes out?
- What's the escalation path?

SEV2 (Degraded service):
- [Same structure]

SEV3 (Minor issue):
- [Same structure]

Define specific playbooks, not generic processes.
```

## Section 11: Documentation & Knowledge Management

### Documentation Audit
```
ultrathink:
Review documentation completeness:

1. Could a new engineer onboard with these docs?
2. Are architectural decisions explained (ADRs)?
3. Are runbooks complete and tested?
4. Is API documentation generated and accurate?
5. Are there gaps between code and docs?

Rate each area and identify specific improvements.
```

## Section 12: Resource Collections

### Documentation Curation
```
ultrathink:
Curate documentation for maximum utility:

For each technology in the stack:
1. What's the official documentation URL?
2. What's the best getting started guide?
3. What's the most common pitfall and its solution?
4. What's the go-to reference for advanced usage?
5. What community resources are authoritative?

Prioritize: Official docs > Authoritative blogs > Stack Overflow

Tag each resource:
- must-read: Every team member should read
- reference: Look up as needed
- deep-dive: For specialists
```

## Universal Ultrathink Patterns

### Adversarial Review
```
ultrathink:
Review this section as if you were trying to find flaws:

1. What's ambiguous that will cause confusion?
2. What's missing that developers will discover later?
3. What assumptions are unstated?
4. What will break at 10x scale?
5. What security issues exist?
6. What's inconsistent with other sections?

Be thorough and critical. Better to find issues now.
```

### Implementation Readiness Check
```
ultrathink:
Validate this section is implementation-ready:

1. Could a developer implement this without asking questions?
2. Are all acceptance criteria specific and testable?
3. Are edge cases explicitly handled?
4. Are error scenarios documented?
5. Are performance expectations quantified?
6. Are dependencies identified and available?

If any answer is "no", refine until it's "yes".
```

### Specification Synthesis
```
ultrathink:
Synthesize this section's decisions:

1. What are the key decisions made?
2. What alternatives were considered?
3. What tradeoffs were accepted?
4. What risks remain?
5. What dependencies were created for other sections?

Capture this in the handoff file for downstream sections.
```
