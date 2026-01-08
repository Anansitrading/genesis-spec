# Genesis Usage Guide

**How to Use the Genesis System Prompt for Technical Specification Generation**

---

## Quick Start

### 1. Load the Genesis System Prompt

When starting a new specification generation session with an AI agent:

```
Load the Genesis.md system prompt. You are now Genesis, a technical specification architect.

I will provide you with the following materials for [Project Name]:
- [List your input materials]

Please generate a comprehensive technical specification following your standard structure.
```

### 2. Provide Your Input Materials

Organize your inputs clearly:

```
## Build Prompt
[Paste your build_prompt.md or describe the project]

## Research Materials
[Paste or link to research papers, articles, case studies]

## Code Examples
[Paste relevant code snippets or link to repositories]

## Documentation
[Link to API docs, framework guides, library references]

## Diagrams
[Describe or paste Mermaid diagrams, or link to visual materials]

## Reference Projects
[Link to similar implementations or competitive analysis]
```

### 3. Request Specification Generation

```
Using the materials above, generate a complete technical specification following the Genesis structure. 

Focus areas:
- [Specify any particular areas of emphasis]
- [Note any constraints or preferences]

Please also:
1. Use Perplexity to fill any knowledge gaps
2. Create a Raindrop.io collection structure
3. Flag any assumptions you make
```

---

## Example Workflow

### Scenario: Building a Video Editing Platform

**Step 1: Prepare Your Materials**

```markdown
## Project Overview
I want to build a web-based video editing platform that combines traditional timeline editing with AI-powered features.

## Build Prompt
[Paste build_prompt(1).md content]

## Reference Project
I have an existing technical spec for a similar project: target_tech_spec.md
Use this as a template for structure and detail level.

## Research Needs
- Best practices for browser-based video editing
- State management for complex editor applications
- AI integration patterns for video generation
- Performance optimization for timeline rendering
```

**Step 2: Invoke Genesis**

```markdown
@Genesis.md

Using the materials above, generate a comprehensive technical specification for my video editing platform.

Key requirements:
- Must work in browser (no desktop app initially)
- Privacy-first (local processing)
- AI features via external APIs
- Real-time collaboration support

Please use Perplexity to research:
1. Browser-based video processing best practices
2. Timeline virtualization techniques
3. WebSocket patterns for real-time collaboration
4. Client-side storage strategies for large media files

Also create a Raindrop.io collection structure for organizing all relevant documentation.
```

**Step 3: Review and Iterate**

```markdown
Thank you for the specification. I have some feedback:

1. Section 3 (Technology Stack): Can you add more detail about the state management approach? I'm considering Zustand vs Redux.

2. Section 4 (Process Flowcharts): Please add a flowchart for the AI video generation workflow.

3. Section 12 (Raindrop): Can you provide specific bookmark recommendations for the React and Next.js collections?

Please update the specification with these additions.
```

---

## Advanced Usage Patterns

### Pattern 1: Incremental Specification Building

Build the specification in phases:

```markdown
@Genesis.md

Phase 1: Generate sections 1-3 (Introduction, Requirements, Technology Stack) based on my build prompt.

I'll provide additional materials for the remaining sections after we finalize the foundation.
```

### Pattern 2: Specification from Multiple Sources

Synthesize from diverse inputs:

```markdown
@Genesis.md

I have the following materials for a new project:

1. Academic paper on distributed systems (attached)
2. Code repository of a similar open-source project (link)
3. API documentation for services we'll integrate (links)
4. Architectural diagrams from our design session (attached)
5. User research findings (attached)

Please synthesize these into a unified technical specification, noting where sources agree or conflict.
```

### Pattern 3: Updating Existing Specifications

Evolve specifications over time:

```markdown
@Genesis.md

I have an existing technical specification (attached). Please update it with:

1. New feature requirements (described below)
2. Updated technology stack (we're migrating from X to Y)
3. Additional security considerations (GDPR compliance)

Maintain version history and track what changed.
```

### Pattern 4: Specification Review and Enhancement

Improve existing documentation:

```markdown
@Genesis.md

Review the attached technical specification and:

1. Identify gaps or missing sections
2. Suggest improvements for clarity and completeness
3. Add missing diagrams (workflows, architecture, state management)
4. Enhance the Raindrop.io collection with additional resources
5. Ensure all requirements have acceptance criteria

Provide a summary of changes and recommendations.
```

---

## Tips for Best Results

### 1. Be Specific About Context

**Good:**
```
We're building a B2B SaaS platform for enterprise customers with strict compliance requirements (SOC 2, GDPR). The system needs to handle 10,000+ concurrent users with 99.9% uptime.
```

**Less Effective:**
```
We're building a web app.
```

### 2. Provide Examples When Possible

**Good:**
```
Here's a code snippet showing our current authentication approach:
[paste code]

And here's how we want to evolve it:
[describe desired state]
```

**Less Effective:**
```
We need better authentication.
```

### 3. Specify Constraints Upfront

**Good:**
```
Constraints:
- Must use TypeScript (team requirement)
- Must deploy on AWS (company policy)
- Budget: $5k/month for infrastructure
- Timeline: MVP in 3 months
- Team: 2 frontend, 2 backend, 1 DevOps
```

**Less Effective:**
```
We have some constraints.
```

### 4. Request Perplexity Research for Gaps

**Good:**
```
Please use Perplexity to research:
- Best practices for WebSocket scaling in Next.js
- Comparison of Zustand vs Jotai for our use case
- Security considerations for file upload handling
- Performance benchmarks for IndexedDB vs OPFS
```

**Less Effective:**
```
Research anything you think is relevant.
```

### 5. Iterate on Specific Sections

**Good:**
```
Section 4.2 (Error Handling) needs more detail. Please expand with:
- Specific error types we should handle
- Retry strategies with backoff algorithms
- User notification patterns
- Logging and monitoring integration
```

**Less Effective:**
```
Add more to the error handling section.
```

---

## Common Use Cases

### Use Case 1: New Project from Scratch

**Input:**
- High-level project description
- Business requirements
- Target users
- Rough technology preferences

**Output:**
- Complete technical specification
- Technology stack recommendations with justifications
- Architecture diagrams
- Raindrop.io collection structure

### Use Case 2: Migrating Existing System

**Input:**
- Current system documentation
- Migration goals and constraints
- New technology stack
- Timeline and resource constraints

**Output:**
- Migration specification
- Phased migration plan
- Risk assessment
- Updated architecture diagrams

### Use Case 3: Adding Major Feature

**Input:**
- Existing specification
- New feature requirements
- Integration points
- Performance requirements

**Output:**
- Updated specification with new feature
- Updated architecture diagrams
- Integration workflows
- Updated test strategy

### Use Case 4: Architecture Review

**Input:**
- Current specification
- Performance issues or concerns
- Scalability requirements
- Budget constraints

**Output:**
- Architecture recommendations
- Performance optimization strategies
- Scalability improvements
- Cost-benefit analysis

---

## Raindrop.io Workflow

### Setting Up Collections

1. **Create Main Collection**
   ```
   Create a new collection: "[Project Name] - Documentation"
   ```

2. **Add Sub-Collections**
   ```
   Based on Genesis recommendations, create:
   - Core Documentation
   - API References
   - Framework Docs
   - Design Patterns
   - Architecture References
   - Research & Articles
   ```

3. **Populate with Bookmarks**
   ```
   For each resource Genesis recommends:
   - Add to Raindrop with proper title
   - Write 1-2 sentence description
   - Apply relevant tags
   - Add notes with key takeaways
   ```

4. **Reference in Specification**
   ```
   In each relevant section of the spec, add:
   
   **ðŸ“š Documentation References (Raindrop Collection: [Name]):**
   - [Resource Title](link) - Description
   ```

### Maintaining Collections

**Weekly:**
- Review and update bookmarks
- Archive outdated resources
- Add new discoveries

**Per Sprint:**
- Add sprint-specific resources
- Tag with sprint number
- Update specification references

**Per Release:**
- Archive deprecated documentation
- Update version-specific resources
- Refresh best practices

---

## Quality Checklist

Before considering a specification complete:

### Completeness
- [ ] All 12 main sections addressed or marked N/A
- [ ] Every feature has requirements with acceptance criteria
- [ ] All dependencies documented with versions
- [ ] Architecture diagrams included
- [ ] Data models defined with validation rules
- [ ] Security considerations addressed
- [ ] Testing strategy defined
- [ ] Deployment process documented
- [ ] Raindrop.io collection created and referenced

### Clarity
- [ ] Terminology used consistently
- [ ] Technical jargon explained
- [ ] Diagrams clearly labeled
- [ ] Code examples provided where helpful
- [ ] Cross-references work correctly

### Actionability
- [ ] Requirements have measurable acceptance criteria
- [ ] Features can be broken into sprint-sized tasks
- [ ] Dependencies clearly identified
- [ ] Risks and mitigations documented
- [ ] Success metrics defined

### Traceability
- [ ] Business requirements link to features
- [ ] Features link to technical requirements
- [ ] Requirements link to test cases
- [ ] Assumptions documented
- [ ] Decisions have rationale

---

## Troubleshooting

### Issue: Specification Too Generic

**Solution:**
```
The specification feels too generic. Please:
1. Add more specific technical details for [section]
2. Include code examples for [feature]
3. Provide concrete numbers for performance requirements
4. Add more detailed acceptance criteria
```

### Issue: Missing Context

**Solution:**
```
I need more context on [topic]. Please use Perplexity to research:
- [Specific question 1]
- [Specific question 2]
- [Specific question 3]

Then update the specification with findings.
```

### Issue: Conflicting Information

**Solution:**
```
I notice conflicting information between:
- [Source A says X]
- [Source B says Y]

Please:
1. Research which approach is more appropriate for our use case
2. Document the decision and rationale
3. Update the specification accordingly
```

### Issue: Specification Too Long

**Solution:**
```
The specification is too detailed for an MVP. Please:
1. Mark features as Phase 1 (MVP) vs Phase 2 (Future)
2. Simplify architecture for MVP
3. Focus on core user flows only
4. Move advanced features to "Out of Scope" with future consideration
```

### Issue: Missing Diagrams

**Solution:**
```
Please add Mermaid diagrams for:
1. User onboarding flow
2. Data flow architecture
3. State management transitions
4. Error handling procedures
5. Deployment pipeline
```

---

## Integration with Development Workflow

### Sprint Planning

```
@Genesis.md

Based on the specification, generate a sprint plan for the next 2 weeks:
- Break features into sprint-sized tasks
- Identify dependencies
- Estimate complexity
- Suggest task order
- Flag risks
```

### Architecture Decision Records

```
@Genesis.md

Create an ADR for [specific decision]:
- Context: [describe situation]
- Decision: [what we decided]
- Consequences: [trade-offs]
- Alternatives: [what we didn't choose and why]

Add this to Section 11 of the specification.
```

### Documentation Updates

```
@Genesis.md

Update the specification to reflect:
- Implementation learnings from Sprint X
- Architecture changes made
- New dependencies added
- Performance optimizations applied

Maintain version history.
```

---

## Version Control

### Specification Versioning

Use semantic versioning:
- **Major (1.0.0)**: Significant architecture changes
- **Minor (1.1.0)**: New features or major updates
- **Patch (1.1.1)**: Clarifications, corrections, minor updates

### Change Log Format

```markdown
## [1.1.0] - 2025-11-09

### Added
- Section 4.3: New workflow for AI video generation
- Section 7.2: Additional security considerations for file uploads

### Changed
- Section 3.2: Updated state management from Redux to Zustand
- Section 8.1: Increased test coverage targets

### Removed
- Section 10.3: Deprecated deployment strategy (replaced with new approach)

### Fixed
- Section 6.1: Corrected database schema for user_preferences table
```

---

## Success Stories

### Example 1: Rapid MVP Development

**Scenario**: Team needed to build MVP in 6 weeks

**Approach**:
1. Used Genesis to generate comprehensive spec in 2 days
2. Focused on Phase 1 features only
3. Referenced Raindrop collection for quick answers
4. Agents used spec to generate implementation plans

**Result**: MVP delivered on time with clear architecture foundation for future phases

### Example 2: Complex System Migration

**Scenario**: Migrating monolith to microservices

**Approach**:
1. Genesis analyzed existing system documentation
2. Generated phased migration specification
3. Created detailed service boundaries and APIs
4. Documented rollback procedures

**Result**: Smooth migration with minimal downtime, clear communication across teams

### Example 3: AI-Enhanced Application

**Scenario**: Adding AI features to existing application

**Approach**:
1. Genesis synthesized AI research papers and code examples
2. Generated integration patterns and workflows
3. Documented observability and cost tracking
4. Created Raindrop collection for AI/ML resources

**Result**: Successful AI integration with proper monitoring and cost control

---

## Next Steps

After generating your specification:

1. **Review with Team**: Walk through specification with stakeholders
2. **Refine Based on Feedback**: Update sections as needed
3. **Set Up Raindrop**: Create and populate documentation collections
4. **Begin Sprint Planning**: Use specification to plan first sprint
5. **Maintain Living Document**: Update specification as project evolves

---

## Support and Resources

**Genesis System Prompt**: `Genesis.md`  
**Target Template Example**: `target_tech_spec.md`  
**Example Build Prompt**: `build_prompt(1).md`

For questions or improvements to Genesis, document them as issues or enhancement requests.

