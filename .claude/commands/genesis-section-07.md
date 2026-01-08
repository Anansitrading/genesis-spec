---
description: Generate Section 7 (Security & Compliance) of the Genesis technical specification. Documents authentication, authorization, encryption, and compliance requirements.
---

# Genesis Section 07: Security & Compliance

You are generating the Security & Compliance section of a technical specification.

## Pre-Flight Checks

1. **Read Previous Handoffs**:
   - `genesis_output/handoffs/handoff_00_init.json` (constraints)
   - `genesis_output/handoffs/handoff_05_architecture_design.json` (API design)
   - `genesis_output/handoffs/handoff_06_data_models_schema.json` (data to protect)

2. **Read Section Guide**:
   Read `genesis_sources/section_guides/Genesis_Section_07_Security_Compliance.md`

3. **Review Previous Sections**:
   - Read `genesis_output/sections/05_architecture_design.md`
   - Read `genesis_output/sections/06_data_models_schema.md`

## Research Phase (Parallel Subagents)

Launch the following subagents IN PARALLEL:

### Subagent 1: Authentication Patterns

```
Use genesis-researcher agent to research:
- OAuth 2.0 / OIDC implementation patterns
- JWT best practices 2025
- Session management strategies
- MFA implementation approaches

Return: Auth patterns, session strategies, MFA options
```

### Subagent 2: Compliance Requirements

```
Use genesis-perplexity agent to research:
- GDPR compliance for [application type]
- OWASP Top 10 2025 guidelines
- Data privacy requirements
- Industry-specific compliance (HIPAA, SOC2, etc.)

Return: Compliance checklists, required controls
```

### Subagent 3: Encryption & Security

```
Use genesis-documentation agent to research:
- Encryption at rest best practices
- TLS configuration standards
- API security patterns
- Secret management (Vault, cloud secrets)

Return: Encryption standards, API security, secret management
```

Wait for all subagents to complete before proceeding.

## Synthesis Phase

Generate the Security & Compliance section:

### 7.1 Authentication Strategy
- Authentication flow diagrams
- Provider integration (OAuth, OIDC)
- Token management
- Session handling
- MFA implementation

### 7.2 Authorization Model
- Role-based access control (RBAC)
- Permission structure
- Resource-level permissions
- Authorization middleware

### 7.3 Data Protection
- Encryption at rest
- Encryption in transit
- PII handling
- Data retention policies

### 7.4 API Security
- Rate limiting
- Input validation
- CORS configuration
- API key management
- Request signing

### 7.5 Compliance Requirements
- GDPR compliance checklist
- OWASP Top 10 mitigations
- Audit logging requirements
- Data subject rights implementation

### 7.6 Security Operations
- Secret management
- Vulnerability scanning
- Security monitoring
- Incident response plan

## Output Requirements

Write to `genesis_output/sections/07_security_compliance.md`

Create `genesis_output/handoffs/handoff_07_security_compliance.json`:

```json
{
  "section_number": 7,
  "section_name": "Security & Compliance",
  "completed_at": "[timestamp]",
  "status": "complete",

  "key_outputs": {
    "auth_strategy": "[OAuth/JWT/Session/etc]",
    "mfa_required": true,
    "authorization_model": "RBAC",
    "roles": ["admin", "user", "viewer"],
    "encryption": {
      "at_rest": "[algorithm]",
      "in_transit": "TLS 1.3"
    }
  },

  "compliance_requirements": [
    {"framework": "GDPR", "controls": ["control 1", "control 2"]},
    {"framework": "OWASP", "controls": ["control 1", "control 2"]}
  ],

  "security_controls": [
    {"control": "name", "implementation": "how"}
  ],

  "decisions_made": [],
  "assumptions": [],
  "open_questions": [],

  "next_section_context": {
    "for_section_08": "Security tests needed",
    "for_section_09": "Security monitoring requirements"
  }
}
```

## Completion Message

```
Section 07: Security & Compliance - COMPLETE

Summary:
- Auth Strategy: [strategy]
- Authorization: [model]
- Compliance Frameworks: [list]
- Security Controls: [count]

Next steps:
1. Review the security design
2. Start a NEW session
3. Run: /genesis-section-08
```
