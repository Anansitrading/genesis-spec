# Genesis Section 03: Technology Stack

**Purpose:** Guide for documenting comprehensive technology stack decisions with justifications and version constraints.

---

## Section Overview

The Technology Stack section documents all technical choices from languages to deployment platforms. Every choice should be justified and version-constrained for reproducibility.

### Key Components

1. **Programming Languages**: Frontend, backend, selection criteria
2. **Frameworks & Libraries**: Core framework, state management, specialized libraries
3. **Open Source Dependencies**: Organized by category with versions
4. **Third-Party Services**: AI providers, monitoring, deployment, auth, storage
5. **Databases & Storage**: Primary database, client-side storage, caching, persistence strategies
6. **Development & Deployment**: Tools, build system, CI/CD, platforms, optimizations

---

## 3.1 Programming Languages

### Purpose
Document primary and secondary languages with clear justification for each choice.

### Template

```markdown
#### Programming Languages

##### Frontend Languages
- **[Language Name + Version]**: [Primary use cases]
  - **Why Chosen:** [Type safety / ecosystem / performance / team expertise]
  - **Use Cases:** [Where this language is used]
  - **Alternatives Considered:** [What we didn't choose and why]

##### Backend Languages
- **[Language Name + Version]**: [Primary use cases]
  - **Why Chosen:** [Performance / ecosystem / concurrency / integration]
  - **Use Cases:** [Where this language is used]
  - **Alternatives Considered:** [What we didn't choose and why]

##### Selection Criteria
- **[Criterion 1]:** [Why this matters for the project]
- **[Criterion 2]:** [Impact on development]
- **[Criterion 3]:** [Long-term considerations]
```

### Best Practices

**Document:**
- Minimum version required (e.g., TypeScript 5.3+)
- Why that version (new features, bug fixes, performance)
- Compatibility requirements (Node.js version, browser support)
- Migration path if upgrading

**Example:**
```markdown
#### Programming Languages

##### Frontend Languages
- **TypeScript 5.3+**: Primary language for all frontend development
  - **Why Chosen:** Type safety crucial for complex video editing workflows, excellent IDE support, Next.js 14.2+ compatibility
  - **Use Cases:** React components, state management, API clients, utility functions
  - **Alternatives Considered:** JavaScript (rejected: lack of compile-time safety), Flow (rejected: smaller ecosystem)

- **JavaScript (ES2022)**: LangChain.js integration
  - **Why Chosen:** LangChain framework requires JavaScript/TypeScript, Node.js 18.x+ support
  - **Use Cases:** AI agent orchestration, LangGraph workflows
  - **Alternatives Considered:** Pure TypeScript (rejected: LangChain API design favors JS flexibility)

##### Backend Languages
- **Python 3.13+**: ComfyUI backend integration
  - **Why Chosen:** Full Python 3.13 compatibility, performance optimizations for AI workloads, rich ML ecosystem
  - **Use Cases:** ComfyUI workflows, video generation models, AI processing pipeline
  - **Alternatives Considered:** Node.js (rejected: ML ecosystem not as mature), Go (rejected: ComfyUI is Python-native)

- **TypeScript**: Next.js API routes and server-side logic
  - **Why Chosen:** Code sharing with frontend, type safety across stack, serverless compatibility
  - **Use Cases:** API endpoints, serverless functions, data validation
  - **Alternatives Considered:** Python (rejected: adds complexity of multi-language backend)

##### Selection Criteria
- **Type Safety**: TypeScript provides compile-time error detection crucial for complex video editing workflows
- **Ecosystem Compatibility**: LangChain framework requires JavaScript/TypeScript for building LLM-powered applications
- **Performance**: Python 3.13 offers enhanced performance optimizations for AI model execution
- **Team Expertise**: Team has strong TypeScript and Python experience
```

---

## 3.2 Frameworks & Libraries

### Core Framework

**Template:**
```markdown
##### Core Frontend Framework
- **[Framework Name + Version]**: [Brief description]
  - **Why Chosen:** [Specific features we're leveraging]
  - **Key Capabilities:** [What this enables]
  - **Version Justification:** [Why this specific version]
  - **Alternatives Considered:** [What we evaluated]

##### State Management
- **[Library Name + Version]**: [State management approach]
  - **Why Chosen:** [Simplicity / performance / developer experience]
  - **Use Cases:** [What state this manages]
  - **Integration:** [How it works with other systems]

##### Specialized Libraries
**[Category Name]:**
- **[Library 1]**: [Purpose]
- **[Library 2]**: [Purpose]

**[Another Category]:**
- **[Library 1]**: [Purpose]
```

### Example

```markdown
##### Core Frontend Framework
- **Next.js 14.2+**: Production-ready React framework
  - **Why Chosen:** App Router stability, Server Actions, Turbopack dev improvements, Vercel deployment optimization
  - **Key Capabilities:** SSR, SSG, ISR, API routes, middleware, image optimization
  - **Version Justification:** 14.2 includes Turbopack RC with 99.8% test passing rate, stable Server Actions
  - **Alternatives Considered:** Remix (rejected: smaller ecosystem), Vite+React (rejected: need built-in SSR)

- **React 18+**: Required for framework compatibility
  - **Why Chosen:** Zustand v5 requires React 18+ for native useSyncExternalStore
  - **Key Capabilities:** Concurrent features, automatic batching, transitions
  - **Version Justification:** Minimum version for Zustand v5 compatibility

##### State Management
- **Zustand 5.0.8**: Lightweight state management
  - **Why Chosen:** Bear necessities only, improved bundle size through native React 18 integration, simpler than Redux
  - **Use Cases:** Editor state, timeline state, media library, UI state, AI chat state
  - **Integration:** Middleware for IndexedDB persistence, middleware for PostgreSQL sync

##### Specialized Libraries

**AI & Agent Orchestration:**
- **LangChain.js 1.0.2**: Production-ready LLM framework with createAgent standard interface
- **LangGraph.js 0.2+**: Multi-agent workflows with streaming, checkpointing, human-in-the-loop

**Build System & Monorepo:**
- **Turborepo 2.4**: High-performance build system with Watch Mode, ESLint v9 support

**UI Components:**
- **shadcn/ui**: Modern React components built on Radix UI primitives
- **Tailwind CSS**: Utility-first CSS framework
- **Lucide React**: Icon library for consistent iconography
```

---

## 3.3 Open Source Dependencies

### Purpose
Document all dependencies organized by category with version constraints and justifications.

### Template

```markdown
#### Open Source Dependencies

##### Core Dependencies
\`\`\`json
{
  "dependency-name": "^version",
  "another-dependency": "^version"
}
\`\`\`

##### [Category Name]
- **[Package Name]**: [Purpose] - [Why this over alternatives]
- **[Package Name]**: [Purpose]

##### Version Constraints
- **[Constraint 1]:** [Impact and reason]
- **[Constraint 2]:** [Compatibility requirement]
```

### Categories

Organize dependencies:
- **Core Dependencies**: Essential framework packages
- **AI & ML Libraries**: LLM, agent, ML-related
- **Storage & Database**: ORMs, clients, storage adapters
- **UI & Styling**: Component libraries, CSS frameworks
- **Development Tools**: TypeScript, linters, formatters
- **Testing**: Test frameworks, utilities
- **Build & Bundle**: Compilers, bundlers, optimizers
- **Utilities**: Date handling, validation, etc.

### Example

```markdown
#### Open Source Dependencies

##### Core Dependencies
\`\`\`json
{
  "next": "^14.2.0",
  "react": "^18.2.0",
  "zustand": "^5.0.8",
  "langchain": "^1.0.2",
  "@langchain/langgraph": "^0.2.0",
  "turbo": "^2.4.0"
}
\`\`\`

##### AI & ML Libraries
- **@langchain/core**: Core LangChain abstractions and interfaces
- **@langchain/openai**: OpenAI integration for embeddings and chat models
- **@langchain/google-genai**: Gemini API for conversational AI
- **@langchain/community**: Community integrations (100+ tools)

##### Storage & Database
- **dexie**: Promise-based IndexedDB wrapper (easier than raw IndexedDB API)
- **drizzle-orm**: Type-safe ORM for PostgreSQL (lighter than Prisma)
- **@vercel/postgres**: PostgreSQL client optimized for serverless
- **ioredis**: Redis client for job queues and caching

##### UI & Styling
- **@radix-ui/react-***: Accessible component primitives (dropdown, dialog, tooltip, etc.)
- **tailwindcss**: Utility-first CSS (rapid development, small bundle)
- **lucide-react**: Icon library with 1000+ icons, tree-shakeable

##### Development Tools
- **typescript**: Type checking and compilation (minimum 4.5+)
- **eslint**: Code linting (v9+ with flat config)
- **prettier**: Code formatting consistency
- **@turbo/codemod**: Automated migration tools

##### Testing
- **vitest**: Fast unit test framework (Vite-powered)
- **@testing-library/react**: React component testing
- **playwright**: E2E testing across browsers

##### Version Constraints
- **React 18+ Required**: Zustand v5 requires React 18+ for native useSyncExternalStore support
- **TypeScript 4.5+**: Zustand v5 dropped support for TypeScript versions below 4.5
- **Node.js 18+**: Next.js 14 requires minimum Node.js version 18.17
- **Python 3.13+**: ComfyUI requires Python 3.13 for full feature support
```

---

## 3.4 Third-Party Services

### Template

```markdown
#### Third-Party Services

##### [Category Name]
- **[Service Name]**: [What it provides]
  - **Why Chosen:** [Specific benefits]
  - **Pricing Model:** [Cost structure]
  - **Integration Approach:** [How we connect]
  - **Alternatives:** [What we considered]
```

### Service Categories

- **AI Model Providers**: LLM APIs, embeddings, speech
- **Backend Services**: Specialized platforms (ComfyUI, etc.)
- **Monitoring & Observability**: Error tracking, performance, tracing
- **Development & Deployment**: CI/CD, hosting, infrastructure
- **Authentication & Security**: Auth providers, security services
- **Storage Services**: Object storage, CDN, media hosting
- **Analytics**: Product analytics, business intelligence

### Example

```markdown
#### Third-Party Services

##### AI Model Providers
- **Google Gemini API**: Conversational AI
  - **Why Chosen:** Competitive pricing, long context windows, multimodal support
  - **Pricing Model:** Pay-per-token ($0.07/1M input tokens, $0.21/1M output tokens for Gemini 1.5 Flash)
  - **Integration Approach:** @langchain/google-genai SDK
  - **Alternatives:** OpenAI GPT-4 (rejected: higher cost), Claude (rejected: availability)

- **OpenAI API**: Embeddings generation
  - **Why Chosen:** Best-in-class embeddings for semantic search
  - **Pricing Model:** Pay-per-token ($0.02/1M tokens for text-embedding-3-small)
  - **Integration Approach:** @langchain/openai SDK
  - **Alternatives:** Google embeddings (rejected: lower quality for our use case)

##### Video Generation Backend
- **ComfyUI**: AI video generation platform
  - **Why Chosen:** Open-source, extensible, supports latest models (Mochi, Kling V2)
  - **Pricing Model:** Self-hosted (GPU compute costs)
  - **Integration Approach:** REST API via custom gateway
  - **Alternatives:** Runway (rejected: expensive), Stability AI (rejected: limited video models)

- **Railway**: Backend hosting
  - **Why Chosen:** Simple GPU support, PostgreSQL hosting, reasonable pricing
  - **Pricing Model:** Usage-based ($0.000463/GB-hour RAM, $0.000231/vCPU-hour)
  - **Integration Approach:** Docker deployments, automatic scaling
  - **Alternatives:** AWS (rejected: complexity), Render (rejected: no GPU support)

##### Monitoring & Observability
- **Sentry**: Error tracking
  - **Why Chosen:** Best-in-class error tracking, source maps, release tracking
  - **Pricing Model:** $29/month for 50K errors
  - **Integration Approach:** @sentry/nextjs SDK
  - **Alternatives:** Rollbar (rejected: less features), Bugsnag (rejected: higher cost)

- **Langfuse**: AI agent tracing
  - **Why Chosen:** Open-source, self-hostable, cost tracking, multi-agent visibility
  - **Pricing Model:** Self-hosted (free) or cloud ($29/month)
  - **Integration Approach:** langfuse SDK with LangChain integration
  - **Alternatives:** LangSmith (rejected: expensive for our volume)
```

---

## 3.5 Databases & Storage

### Template

```markdown
#### Databases & Storage

##### Primary Database
- **[Database Type + Version]**: [Use cases]
  - **Why Chosen:** [Specific features we need]
  - **Extensions/Features:** [Special capabilities]
  - **Scaling Strategy:** [How we'll handle growth]
  - **Backup Strategy:** [Data protection]

##### Client-Side Storage
- **[Storage Type]**: [What we store here]
  - **Schema Design:** [How data is organized]
  - **Quota Management:** [How we handle limits]

##### Caching Solutions
- **[Cache Type]**: [What we cache]
  - **Eviction Policy:** [How we manage cache]
  - **TTL Strategy:** [Cache invalidation]

##### Storage Services
- **[Service Name]**: [What we store]
  - **Access Pattern:** [How we read/write]
  - **Cost Optimization:** [How we minimize costs]
```

### Example

```markdown
#### Databases & Storage

##### Primary Database
- **PostgreSQL 15+**: Primary database for all server-side data
  - **Why Chosen:** ACID compliance, JSON support, pgvector for semantic search, mature ecosystem
  - **Extensions/Features:** pgvector for embeddings, full-text search, JSONB for flexible schemas
  - **Scaling Strategy:** Read replicas for workflow queries, connection pooling via PgBouncer
  - **Backup Strategy:** Daily backups to S3, point-in-time recovery, 30-day retention

**Schema:**
- Users, projects, chat sessions, chat messages
- Workflows, workflow executions, job queue
- Asset metadata (not asset files)
- User preferences, settings

##### Client-Side Storage
- **IndexedDB**: Structured client-side storage
  - **Schema Design:** Dexie.js with versioned schema, compound indexes for efficient queries
  - **Quota Management:** Monitor usage via navigator.storage.estimate(), warn at 80% capacity
  - **Use Cases:** Project data, chat history, media metadata, user preferences

- **OPFS (Origin Private File System)**: Large file storage
  - **Use Cases:** Video files, audio files, generated assets (100MB-10GB per file)
  - **Access Pattern:** Streaming reads for playback, chunked writes for uploads
  - **Quota Management:** Request persistent storage, cleanup old files automatically

##### Caching Solutions
- **Redis**: Job queue and real-time updates
  - **Eviction Policy:** LRU for cache entries, no eviction for queue entries
  - **TTL Strategy:** Job status cached for 1 hour, workflow results for 24 hours
  - **Use Cases:** ComfyUI job queue, job status updates, API rate limiting

- **Turborepo Remote Cache**: Build artifact caching
  - **Use Cases:** Compiled packages, test results, lint results
  - **TTL Strategy:** 7 days for branch builds, 30 days for main branch
  - **Cost Optimization:** Vercel remote cache (included in Pro plan)

##### Storage Services
- **Railway Garage**: S3-compatible object storage
  - **Use Cases:** Generated video files, user uploads (after processing), media thumbnails
  - **Access Pattern:** Presigned URLs for direct client uploads/downloads
  - **Cost Optimization:** Lifecycle policies to delete temporary files after 7 days, compress thumbnails
```

---

## 3.6 Development & Deployment

### Template

```markdown
#### Development & Deployment

##### Development Tools
- **[Tool Name]**: [Purpose]
- **[Tool Name]**: [Purpose]

##### Build System
- **[Build Tool]**: [What it compiles/bundles]
- **[Compiler]**: [What it transforms]

##### Containerization
- **[Container Tech]**: [What we containerize]
- **[Orchestration]**: [How we manage containers]

##### CI/CD Pipeline
- **[CI Platform]**: [What it does]
- **[Pipeline Stages]**: [Lint â†’ Test â†’ Build â†’ Deploy]

##### Deployment Platforms

###### Frontend Deployment
- **[Platform]**: [What we deploy here]
- **[Features]**: [What platform provides]

###### Backend Deployment
- **[Platform]**: [What we deploy here]
- **[Features]**: [What platform provides]
```

### Example

```markdown
#### Development & Deployment

##### Development Tools
- **Turborepo 2.4**: Monorepo build system with Watch Mode, dependency-aware task watching
- **TypeScript 5.3+**: Type checking across all packages
- **ESLint 9+**: Flat config with Turborepo's eslint-config-turbo and eslint-plugin-turbo
- **Prettier**: Code formatting (integrated with ESLint via eslint-config-prettier)

##### Build System
- **Turbopack**: Next.js development bundler (99.8% test passing rate, faster than Webpack)
- **Vite**: Build tool for standalone packages and ComfyUI frontend
- **SWC**: Fast TypeScript/JavaScript compiler (used by Next.js, 20x faster than Babel)
- **esbuild**: TypeScript compilation for Node.js packages

##### Containerization
- **Docker**: Containerization for backend services (ComfyUI gateway, PostgreSQL, Redis)
- **Docker Compose**: Local development environment (one command to start all services)
- **Multi-stage Builds**: Optimized production images (builder stage + runtime stage = smaller images)

##### CI/CD Pipeline
- **CircleCI**: Automated testing, building, deployment
  - **Pipeline Stages:** Setup â†’ Lint â†’ Type Check â†’ Test â†’ Build â†’ Deploy
  - **Optimization:** Turborepo cache, path filtering (only test affected packages), parallel execution
  - **Branch Strategy:** Feature branches â†’ staging â†’ main â†’ production

##### Deployment Platforms

###### Frontend Deployment
- **Vercel**: Next.js optimized hosting
  - **Features:** Automatic deployments, preview deployments per PR, edge functions, image optimization
  - **Regions:** Global CDN, edge middleware in 100+ locations
  - **Performance:** Instant cache invalidation, <100ms Time to First Byte

###### Backend Deployment
- **Railway**: ComfyUI gateway and PostgreSQL
  - **Features:** GPU support (CUDA containers), PostgreSQL managed service, automatic scaling, Railway Garage (S3-compatible storage)
  - **Regions:** US-West (GPU instances), EU (database replicas)
  - **Scaling:** Auto-scale based on CPU/memory, min 1 instance, max 10 instances
```

---

## Best Practices

1. **Document versions explicitly**: Never say "latest" - use specific version ranges
2. **Justify every choice**: Explain why you chose this over alternatives
3. **Note compatibility requirements**: Version constraints, peer dependencies
4. **Include cost information**: Pricing models for services
5. **Plan for scale**: How choices will handle 10x growth
6. **Document tradeoffs**: What you're giving up with each choice

---

## Perplexity Research Queries

- "Comparison of [Technology A] vs [Technology B] for [use case] in 2025"
- "Best practices for [framework] version [X] in production"
- "Cost analysis for [service provider] vs [alternative]"
- "Scalability limits of [database/service]"
- "[Technology] version compatibility with [other technology]"

---

## Quality Checklist

- [ ] All languages documented with minimum versions
- [ ] Selection criteria explained for language choices
- [ ] Core framework choice justified
- [ ] State management approach documented
- [ ] All major dependencies listed with versions
- [ ] Dependencies organized by category
- [ ] Version constraints documented
- [ ] All third-party services documented
- [ ] Service pricing models included
- [ ] Database choice justified
- [ ] Client-side storage strategy explained
- [ ] Caching strategy documented
- [ ] Build tools documented
- [ ] CI/CD pipeline described
- [ ] Deployment platforms specified
- [ ] All alternatives considered are noted

---

## Version History

**v1.0** (2025-11-09): Initial section guide

