# Genesis Section 07: Security & Compliance

**Purpose:** Guide for documenting security architecture, compliance requirements, and best practices.

---

## Section Overview

The Security & Compliance section documents how the system protects user data, authenticates users, authorizes actions, and meets regulatory requirements.

### Key Components

1. **Authentication & Authorization**: Strategy, provider, access control model
2. **Data Security**: Encryption, privacy, PII handling
3. **Security Best Practices**: Input validation, API security, dependency management

---

## 7.1 Authentication & Authorization

### Authentication Strategy

**Template:**
```markdown
#### Authentication Strategy

**Approach:** [OAuth, JWT, Session-based, etc.]

**Provider:** [Auth0, Supabase, Firebase, Custom, etc.]

**Authentication Flow:**
[Mermaid sequence diagram]

**Token Management:**
- **Access Token:** [Lifetime, storage, refresh strategy]
- **Refresh Token:** [Lifetime, storage, rotation policy]

**Session Management:**
- **Session Duration:** [How long sessions last]
- **Session Storage:** [Where session data is stored]
- **Session Invalidation:** [How sessions are terminated]
```

**Example:**
```markdown
#### Authentication Strategy

**Approach:** JWT-based authentication with OAuth 2.0

**Provider:** Supabase Auth (supports email/password, Google OAuth, GitHub OAuth)

**Authentication Flow:**

\`\`\`mermaid
sequenceDiagram
    participant User
    participant Frontend
    participant Supabase
    participant Backend
    
    User->>Frontend: Click "Sign In with Google"
    Frontend->>Supabase: Initiate OAuth Flow
    Supabase->>Google: Redirect to Google OAuth
    User->>Google: Authorize App
    Google->>Supabase: Return Auth Code
    Supabase->>Supabase: Exchange Code for Tokens
    Supabase-->>Frontend: Return JWT Access Token
    Frontend->>Frontend: Store Token in Memory
    Frontend->>Backend: API Request with Bearer Token
    Backend->>Supabase: Verify JWT
    Supabase-->>Backend: Token Valid + User Info
    Backend-->>Frontend: Protected Resource
\`\`\`

**Token Management:**
- **Access Token:** 
  - Lifetime: 1 hour
  - Storage: Memory only (not localStorage for security)
  - Refresh Strategy: Silent refresh 5 minutes before expiry
- **Refresh Token:** 
  - Lifetime: 30 days
  - Storage: HttpOnly cookie (not accessible to JavaScript)
  - Rotation Policy: Rotate on every refresh

**Session Management:**
- **Session Duration:** 30 days (refresh token lifetime)
- **Session Storage:** Server-side in PostgreSQL (session metadata)
- **Session Invalidation:** 
  - Explicit logout (delete refresh token)
  - Token expiry (automatic)
  - Password change (invalidate all sessions)
  - Suspicious activity (admin can revoke)
```

### Authorization Model

**Template:**
```markdown
#### Authorization Model

**Access Control:** [RBAC, ABAC, ACL, etc.]

**Roles:**
| Role | Permissions | Description |
|------|-------------|-------------|
| [Role] | [Permissions] | [Who gets this role] |

**Permission Matrix:**
| Resource | Create | Read | Update | Delete |
|----------|--------|------|--------|--------|
| [Resource] | [Roles] | [Roles] | [Roles] | [Roles] |

**Code Implementation:**
\`\`\`typescript
[Authorization middleware or function]
\`\`\`
```

**Example:**
```markdown
#### Authorization Model

**Access Control:** Resource-based with ownership

**Roles:**
| Role | Permissions | Description |
|------|-------------|-------------|
| User | Create/read/update/delete own resources | All authenticated users |
| Admin | Full access to all resources | System administrators |

**Permission Matrix:**
| Resource | Create | Read | Update | Delete |
|----------|--------|------|--------|--------|
| Projects | Owner | Owner | Owner | Owner |
| Video Assets | Owner | Owner | Owner | Owner |
| Conversations | Owner | Owner | Owner | Owner |
| Workflows | Owner | Owner | Owner | Owner |
| Jobs | Owner (via workflow) | Owner | - | Owner |
| User Profile | - | Owner, Admin | Owner | Admin |

**Ownership Rules:**
- Users can only access their own projects, assets, conversations
- Admin role has full access for support and debugging
- Sharing features (future): Resource-level permissions

**Code Implementation:**

\`\`\`typescript
// Middleware to verify resource ownership
export async function requireOwnership(
  req: Request,
  resourceType: 'project' | 'asset' | 'conversation',
  resourceId: string
): Promise<void> {
  const userId = req.user?.id;
  if (\!userId) {
    throw new UnauthorizedError('Authentication required');
  }
  
  let ownerId: string | null = null;
  
  switch (resourceType) {
    case 'project':
      const project = await db.projects.findById(resourceId);
      ownerId = project?.userId ?? null;
      break;
    case 'asset':
      const asset = await db.videoAssets.findById(resourceId);
      ownerId = asset?.userId ?? null;
      break;
    case 'conversation':
      const conversation = await db.conversations.findById(resourceId);
      ownerId = conversation?.userId ?? null;
      break;
  }
  
  if (\!ownerId || ownerId \!== userId) {
    throw new ForbiddenError('You do not have permission to access this resource');
  }
}

// Usage in API route
app.delete('/api/projects/:id', async (req, res) => {
  await requireOwnership(req, 'project', req.params.id);
  await projectService.deleteProject(req.params.id);
  res.status(204).send();
});
\`\`\`
```

---

## 7.2 Data Security

### Encryption Strategy

**Template:**
```markdown
#### Encryption Strategy

**Data at Rest:**
- **Sensitive Fields:** [What's encrypted, how]
- **File Storage:** [Encryption for uploaded files]
- **Database:** [Database-level encryption]

**Data in Transit:**
- **HTTPS/TLS:** [TLS version, cipher suites]
- **API Communication:** [Certificate pinning, etc.]

**Key Management:**
- **Encryption Keys:** [Where stored, rotation policy]
- **Secrets Management:** [How API keys, tokens are managed]
```

**Example:**
```markdown
#### Encryption Strategy

**Data at Rest:**
- **Sensitive Fields:** 
  - User email: Hashed with bcrypt before storage (not reversible)
  - API keys: Encrypted with AES-256-GCM, keys in environment variables
  - No credit cards stored (use Stripe tokens only)
- **File Storage:** 
  - OPFS is encrypted by browser (OS-level encryption)
  - Object storage (S3): Server-side encryption with AES-256
- **Database:** 
  - PostgreSQL: Transparent Data Encryption (TDE) enabled
  - Backups: Encrypted with AES-256 before upload to S3

**Data in Transit:**
- **HTTPS/TLS:** 
  - TLS 1.3 required (fallback to TLS 1.2)
  - Strong cipher suites only (ECDHE-RSA-AES256-GCM-SHA384)
  - HSTS enabled (max-age=31536000, includeSubDomains)
- **API Communication:** 
  - All API requests over HTTPS
  - Certificate validation enforced
  - No mixed content (all resources HTTPS)

**Key Management:**
- **Encryption Keys:** 
  - Stored in Railway environment variables (encrypted at rest)
  - Rotated every 90 days
  - Different keys for dev/staging/production
- **Secrets Management:** 
  - API keys in environment variables (never in code)
  - Access via secret manager (Railway/Vercel)
  - Audit log for secret access
```

### Privacy & Data Protection

**Template:**
```markdown
#### Privacy & Data Protection

**Privacy-First Principles:**
- [Principle 1]
- [Principle 2]

**Data Collection:**
- **What We Collect:** [Minimal data collection]
- **Why We Collect:** [Purpose for each data type]
- **Retention Policy:** [How long data is kept]

**Data Subject Rights:**
- **Right to Access:** [How users access their data]
- **Right to Delete:** [How users delete their data]
- **Right to Export:** [Data portability]

**PII Handling:**
| Data Type | Classification | Handling |
|-----------|----------------|----------|
| [Data] | [PII/Sensitive/Public] | [How it's protected] |

**Compliance:**
- **GDPR:** [Specific measures]
- **CCPA:** [Specific measures]
```

**Example:**
```markdown
#### Privacy & Data Protection

**Privacy-First Principles:**
- **Local-First:** All video processing happens client-side (no uploads)
- **No Tracking:** No analytics, telemetry, or usage tracking
- **Minimal Data:** Only collect what's necessary for functionality
- **User Control:** Users can delete all data anytime

**Data Collection:**
- **What We Collect:**
  - Account info: email, name, avatar URL (for authentication)
  - Project metadata: project names, timeline structures (for cloud sync)
  - Chat history: AI conversations (for continuity)
  - Error logs: Stack traces, browser info (for debugging)
- **Why We Collect:**
  - Account info: Required for login and identification
  - Project metadata: Enable cross-device sync
  - Chat history: Provide conversation context
  - Error logs: Fix bugs and improve stability
- **Retention Policy:**
  - Active accounts: Indefinite (until user deletes)
  - Deleted accounts: 30-day grace period, then permanent deletion
  - Error logs: 90 days, then automatic deletion

**Data Subject Rights:**
- **Right to Access:** Download all data via Settings > Export Data
- **Right to Delete:** Delete account via Settings > Delete Account (includes all projects, conversations, etc.)
- **Right to Export:** JSON export of all user data (projects, preferences, chat history)

**PII Handling:**
| Data Type | Classification | Handling |
|-----------|----------------|----------|
| Email | PII | Hashed in logs, encrypted in database |
| Name | PII | Displayed in UI, stored encrypted |
| Avatar URL | PII | Proxied through CDN (no direct links) |
| Video Files | Sensitive | Never uploaded (local-only processing) |
| Chat Messages | Sensitive | Encrypted at rest, user can delete |
| IP Address | PII | Not logged, not stored |
| User Agent | Non-PII | Logged for error tracking only |

**Compliance:**
- **GDPR (EU Users):**
  - Cookie consent banner (only essential cookies)
  - Privacy policy with clear data usage
  - Data processing agreement with third parties
  - 30-day data deletion after account deletion
  - Data export in machine-readable format
- **CCPA (California Users):**
  - "Do Not Sell My Data" honored (we don't sell data)
  - Right to know what data is collected
  - Right to delete all data
  - Disclosure of third-party sharing (Gemini API, error tracking)
```

---

## 7.3 Security Best Practices

### Input Validation

**Template:**
```markdown
#### Input Validation

**Validation Layers:**
1. **Client-Side:** [Type checking, format validation]
2. **Server-Side:** [Full validation, sanitization]

**Common Validations:**
| Input Type | Validation | Attack Prevention |
|------------|------------|-------------------|
| [Type] | [Rules] | [What this prevents] |

**Code Example:**
\`\`\`typescript
[Validation function]
\`\`\`
```

**Example:**
```markdown
#### Input Validation

**Validation Layers:**
1. **Client-Side:** TypeScript types, Zod schemas (user experience + early error detection)
2. **Server-Side:** Zod schemas, SQL parameterization (security boundary)

**Common Validations:**
| Input Type | Validation | Attack Prevention |
|------------|------------|-------------------|
| Project Name | Length 1-500, no special chars except -_. | XSS, injection |
| Email | RFC 5322 email format, lowercase | Injection, spoofing |
| URL | Valid HTTP/HTTPS URL, allowlist domains | SSRF, open redirect |
| File Upload | MIME type check, file extension, size limit | Malicious files, DoS |
| API Parameters | Type checking, range validation | Injection, logic errors |
| User Input (Chat) | Length limit, sanitize HTML | XSS, injection |

**Code Example:**

\`\`\`typescript
import { z } from 'zod';
import sanitizeHtml from 'sanitize-html';

// Validation schema
const CreateProjectSchema = z.object({
  name: z.string()
    .trim()
    .min(1, 'Project name is required')
    .max(500, 'Project name too long')
    .regex(/^[a-zA-Z0-9\s\-_.]+$/, 'Invalid characters in project name'),
  metadata: z.object({
    resolution: z.object({
      width: z.number().int().min(1).max(4096),
      height: z.number().int().min(1).max(2160),
    }),
    frameRate: z.number().int().min(1).max(120),
  }),
});

// API route with validation
export async function POST(req: Request) {
  try {
    // Parse and validate input
    const body = await req.json();
    const validated = CreateProjectSchema.parse(body);
    
    // Additional validation
    if (validated.metadata.resolution.width * validated.metadata.resolution.height > 8294400) {
      throw new Error('Resolution exceeds maximum pixel count');
    }
    
    // Create project (validated input is safe)
    const project = await projectService.createProject(validated);
    
    return Response.json(project, { status: 201 });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return Response.json(
        { error: 'Validation failed', details: error.errors },
        { status: 400 }
      );
    }
    throw error;
  }
}

// Sanitize user-generated HTML content
function sanitizeChatMessage(message: string): string {
  return sanitizeHtml(message, {
    allowedTags: ['b', 'i', 'em', 'strong', 'code', 'pre'],
    allowedAttributes: {},
  });
}
\`\`\`
```

### API Security

**Template:**
```markdown
#### API Security

**Rate Limiting:**
| Endpoint | Limit | Window | Action on Exceed |
|----------|-------|--------|------------------|
| [Endpoint] | [N requests] | [Time period] | [Response] |

**CORS Policy:**
- **Allowed Origins:** [Domains]
- **Allowed Methods:** [HTTP methods]
- **Credentials:** [Allowed or not]

**Security Headers:**
\`\`\`
[List of security headers]
\`\`\`

**API Key Management:**
- [How API keys are issued, rotated, revoked]
```

**Example:**
```markdown
#### API Security

**Rate Limiting:**
| Endpoint | Limit | Window | Action on Exceed |
|----------|-------|--------|------------------|
| POST /api/auth/login | 5 requests | 15 minutes | 429 Too Many Requests, 15-min lockout |
| POST /api/generate-video | 10 requests | 1 minute | 429 Too Many Requests, queue request |
| GET /api/projects | 100 requests | 1 minute | 429 Too Many Requests, retry after 60s |
| GET /api/jobs/:id | 60 requests | 1 minute | 429 Too Many Requests, use WebSocket instead |
| POST /api/* (general) | 100 requests | 1 minute | 429 Too Many Requests |

**Implementation:**
\`\`\`typescript
import rateLimit from 'express-rate-limit';

const apiLimiter = rateLimit({
  windowMs: 1 * 60 * 1000, // 1 minute
  max: 100,
  message: 'Too many requests, please try again later',
  standardHeaders: true,
  legacyHeaders: false,
});

const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5,
  skipSuccessfulRequests: true,
  message: 'Too many login attempts, please try again in 15 minutes',
});

app.use('/api/', apiLimiter);
app.use('/api/auth/', authLimiter);
\`\`\`

**CORS Policy:**
- **Allowed Origins:** 
  - Production: https://app.example.com
  - Staging: https://staging.example.com
  - Development: http://localhost:3000
- **Allowed Methods:** GET, POST, PUT, DELETE, OPTIONS
- **Allowed Headers:** Content-Type, Authorization
- **Credentials:** Allowed (cookies, auth headers)
- **Max Age:** 86400 seconds (24 hours)

\`\`\`typescript
import cors from 'cors';

const corsOptions = {
  origin: (origin, callback) => {
    const allowedOrigins = [
      'https://app.example.com',
      'https://staging.example.com',
      process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : null,
    ].filter(Boolean);
    
    if (\!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
  maxAge: 86400,
};

app.use(cors(corsOptions));
\`\`\`

**Security Headers:**
\`\`\`typescript
// Next.js config
const securityHeaders = [
  {
    key: 'X-DNS-Prefetch-Control',
    value: 'on'
  },
  {
    key: 'Strict-Transport-Security',
    value: 'max-age=31536000; includeSubDomains'
  },
  {
    key: 'X-Frame-Options',
    value: 'SAMEORIGIN'
  },
  {
    key: 'X-Content-Type-Options',
    value: 'nosniff'
  },
  {
    key: 'X-XSS-Protection',
    value: '1; mode=block'
  },
  {
    key: 'Referrer-Policy',
    value: 'strict-origin-when-cross-origin'
  },
  {
    key: 'Permissions-Policy',
    value: 'camera=(), microphone=(), geolocation=()'
  },
  {
    key: 'Content-Security-Policy',
    value: "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:; connect-src 'self' https://api.example.com wss://api.example.com;"
  }
];

module.exports = {
  async headers() {
    return [
      {
        source: '/:path*',
        headers: securityHeaders,
      },
    ];
  },
};
\`\`\`

**API Key Management:**
- **Issuance:** API keys not used (JWT tokens instead)
- **Third-Party Keys:** 
  - Stored in environment variables (Railway/Vercel secrets)
  - Rotated every 90 days
  - Access logged for audit
  - Never exposed to client
```

### Dependency Security

**Template:**
```markdown
#### Dependency Security

**Vulnerability Scanning:**
- **Tool:** [npm audit, Snyk, Dependabot, etc.]
- **Frequency:** [How often]
- **Action:** [What happens when vulnerability found]

**Dependency Update Policy:**
- **Security Updates:** [Immediate, weekly, etc.]
- **Minor Updates:** [Policy]
- **Major Updates:** [Policy]

**Supply Chain Security:**
- [Package verification, lock files, etc.]
```

**Example:**
```markdown
#### Dependency Security

**Vulnerability Scanning:**
- **Tool:** Dependabot (GitHub) + npm audit
- **Frequency:** 
  - Dependabot: Daily scans
  - npm audit: On every install, pre-commit hook
- **Action:** 
  - Critical vulnerabilities: Immediate PR, hotfix deploy within 24h
  - High vulnerabilities: PR within 3 days, deploy in next release
  - Medium/Low: Scheduled update in next sprint

**Dependency Update Policy:**
- **Security Updates:** Immediate (automated via Dependabot)
- **Minor Updates:** Weekly review, batch update
- **Major Updates:** Quarterly review, test in staging, manual migration

**Supply Chain Security:**
- **Package Verification:** 
  - Lock files committed (package-lock.json, pnpm-lock.yaml)
  - Verify package integrity (npm audit signatures)
  - Use npm/pnpm with strict mode
- **Trusted Sources:** 
  - Only install from npm registry
  - Verify package maintainer reputation
  - Review package permissions and scripts
- **CI/CD Security:** 
  - Dependencies installed in CI are cached and verified
  - No network access during build (except for installing deps)
  - Build artifacts checksummed

\`\`\`bash
# Pre-commit hook
#\!/bin/bash
npm audit --audit-level=high
if [ $? -ne 0 ]; then
  echo "âŒ High or critical vulnerabilities found. Fix before committing."
  exit 1
fi
\`\`\`
```

---

## Best Practices

1. **Defense in depth**: Multiple security layers
2. **Least privilege**: Minimal access by default
3. **Secure by default**: Security on by default, not opt-in
4. **Fail securely**: Errors don't expose sensitive info
5. **Validate everything**: Never trust input
6. **Encrypt sensitive data**: At rest and in transit
7. **Log security events**: Audit trail for investigations
8. **Regular updates**: Keep dependencies current
9. **Security testing**: Automated and manual security tests
10. **Incident response plan**: Know what to do when breached

---

## Perplexity Research Queries

- "OAuth 2.0 best practices 2025"
- "JWT security considerations and alternatives"
- "GDPR compliance checklist for [application type]"
- "API rate limiting strategies"
- "Content Security Policy for [framework]"
- "OWASP Top 10 mitigation techniques"

---

## Quality Checklist

- [ ] Authentication strategy documented
- [ ] Authorization model clearly defined
- [ ] Token management strategy documented
- [ ] Encryption at rest and in transit covered
- [ ] Privacy principles stated
- [ ] Data retention policy defined
- [ ] PII handling documented
- [ ] GDPR/CCPA compliance addressed
- [ ] Input validation rules documented
- [ ] Rate limiting configured
- [ ] CORS policy defined
- [ ] Security headers implemented
- [ ] Dependency scanning enabled
- [ ] Security update policy defined

---

## Version History

**v1.0** (2025-11-09): Initial section guide

