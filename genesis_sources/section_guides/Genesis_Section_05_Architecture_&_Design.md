# Genesis Section 05: Architecture & Design

**Purpose:** Guide for documenting system architecture, design patterns, and API design decisions.

---

## Section Overview

The Architecture & Design section provides the technical blueprint for the system, showing how components interact, what patterns guide development, and how APIs are structured.

### Key Components

1. **System Architecture**: High-level diagrams, component breakdown, data flows
2. **Design Patterns**: Architectural patterns, code-level patterns, state management
3. **API Design**: REST endpoints, GraphQL schema, WebSocket events, versioning

---

## 5.1 System Architecture

### Purpose
Provide a clear technical architecture that shows how the system is structured and how components communicate.

### High-Level Architecture Diagram

Use Mermaid to show the overall system:

```mermaid
graph TB
    subgraph "Client Layer"
        Browser[Web Browser]
        WebApp[Next.js Application]
        WebWorkers[Web Workers]
    end
    
    subgraph "Client Storage"
        IndexedDB[(IndexedDB)]
        OPFS[(OPFS)]
        SessionStorage[(Session Storage)]
    end
    
    subgraph "API Layer"
        NextAPI[Next.js API Routes]
        Middleware[API Middleware]
    end
    
    subgraph "Backend Services"
        ComfyUI[ComfyUI Gateway]
        JobQueue[Redis Job Queue]
        Auth[Auth Service]
    end
    
    subgraph "Data Layer"
        PostgreSQL[(PostgreSQL)]
        RedisCache[(Redis Cache)]
        S3[Object Storage]
    end
    
    subgraph "External Services"
        Gemini[Google Gemini API]
        OpenAI[OpenAI API]
        Sentry[Sentry]
        Langfuse[Langfuse]
    end
    
    Browser --> WebApp
    WebApp --> WebWorkers
    WebApp --> IndexedDB
    WebApp --> OPFS
    WebApp --> SessionStorage
    WebApp --> NextAPI
    NextAPI --> Middleware
    Middleware --> ComfyUI
    Middleware --> Auth
    Middleware --> PostgreSQL
    Middleware --> RedisCache
    ComfyUI --> JobQueue
    JobQueue --> RedisCache
    NextAPI --> Gemini
    NextAPI --> OpenAI
    WebApp --> Sentry
    NextAPI --> Langfuse
    ComfyUI --> S3
```

### Component Breakdown

Document each major component:

```markdown
#### Component: [Component Name]

**Purpose:** [What this component does]

**Technology Stack:** [Frameworks, languages, key libraries]

**Responsibilities:**
- [Responsibility 1]
- [Responsibility 2]
- [Responsibility 3]

**Interactions:**
- **Depends On:** [Components this depends on]
- **Consumed By:** [Components that use this]
- **Data Exchanged:** [Types of data passed]

**Scaling Strategy:** [How this component scales]

**Failure Modes:** [What happens when this fails]
```

### Example Component Documentation

```markdown
#### Component: Next.js Application (Frontend)

**Purpose:** Provides the user-facing web application with video editing interface, AI chat, and media management.

**Technology Stack:**
- Next.js 14.2+ (App Router)
- React 18+
- TypeScript 5.3+
- Zustand 5.0.8 (state management)
- Tailwind CSS + shadcn/ui

**Responsibilities:**
- Render video editing interface (timeline, preview, tools)
- Manage client-side state (project data, media library, UI state)
- Handle user interactions and input validation
- Communicate with backend APIs
- Store data in IndexedDB and OPFS
- Execute video processing in Web Workers
- Display AI chat interface

**Interactions:**
- **Depends On:** Next.js API Routes, IndexedDB, OPFS, Web Workers
- **Consumed By:** Web Browser
- **Data Exchanged:** JSON (API requests), Binary (video files), State Objects (Zustand)

**Scaling Strategy:**
- Static generation for marketing pages
- Client-side rendering for editor (no SSR for performance)
- Edge middleware for auth checks
- CDN delivery via Vercel

**Failure Modes:**
- Browser crashes: Auto-save prevents data loss
- Network failures: Offline mode with queued operations
- Storage quota exceeded: Cleanup UI with warnings
- Performance degradation: Graceful quality reduction

---

#### Component: ComfyUI Gateway

**Purpose:** Manages AI video generation workflows by interfacing with ComfyUI backend.

**Technology Stack:**
- Python 3.13+
- FastAPI
- ComfyUI Python API
- Redis (job queue)

**Responsibilities:**
- Accept video generation requests via REST API
- Queue jobs in Redis
- Execute ComfyUI workflows
- Monitor job progress and status
- Store results in object storage
- Return job status and result URLs

**Interactions:**
- **Depends On:** ComfyUI, Redis, Object Storage
- **Consumed By:** Next.js API Routes
- **Data Exchanged:** Job requests (JSON), Job status (JSON), Video files (URLs)

**Scaling Strategy:**
- Horizontal scaling with multiple GPU workers
- Redis queue for load distribution
- Auto-scaling based on queue depth

**Failure Modes:**
- ComfyUI crash: Restart worker, requeue failed jobs
- GPU OOM: Reduce batch size, retry with lower quality
- Storage failure: Use fallback storage, retry upload
```

### Data Flow Diagrams

Show how data moves through the system:

```mermaid
sequenceDiagram
    participant User
    participant Frontend
    participant API
    participant ComfyUI
    participant Storage
    participant Redis
    
    User->>Frontend: Request AI Video Generation
    Frontend->>Frontend: Validate Input
    Frontend->>API: POST /api/generate-video
    API->>API: Authenticate User
    API->>Redis: Enqueue Job
    Redis-->>API: Job ID
    API-->>Frontend: {jobId, status: "queued"}
    Frontend->>Frontend: Show Progress UI
    
    loop Poll Status
        Frontend->>API: GET /api/jobs/{jobId}
        API->>Redis: Get Job Status
        Redis-->>API: Status Update
        API-->>Frontend: {status, progress}
    end
    
    Note over ComfyUI: Worker picks up job
    ComfyUI->>Redis: Update Status: "processing"
    ComfyUI->>ComfyUI: Execute Workflow
    ComfyUI->>Storage: Upload Result
    Storage-->>ComfyUI: Result URL
    ComfyUI->>Redis: Update Status: "complete"
    
    Frontend->>API: GET /api/jobs/{jobId}
    API->>Redis: Get Job Status
    Redis-->>API: {status: "complete", resultUrl}
    API-->>Frontend: Result Data
    Frontend->>Storage: Download Video
    Storage-->>Frontend: Video File
    Frontend->>User: Display Generated Video
```

---

## 5.2 Design Patterns

### Purpose
Document the patterns used across the codebase to ensure consistency and maintainability.

### Pattern Template

```markdown
#### Pattern: [Pattern Name]

**Category:** [Architectural / Code-Level / State Management / Integration]

**Intent:** [What problem this pattern solves]

**Applicability:** [When to use this pattern]

**Structure:** [Diagram or code example]

**Implementation Example:** [Code snippet]

**Benefits:**
- [Benefit 1]
- [Benefit 2]

**Tradeoffs:**
- [Tradeoff 1]
- [Tradeoff 2]

**Usage in System:** [Where this pattern is used]
```

### Example Patterns

```markdown
#### Pattern: Repository Pattern

**Category:** Code-Level

**Intent:** Abstract data access logic from business logic, provide a clean API for data operations regardless of storage backend.

**Applicability:** Use when you need to:
- Support multiple storage backends (IndexedDB, PostgreSQL, localStorage)
- Test business logic without actual storage
- Swap storage implementations without changing business code

**Structure:**

\`\`\`typescript
interface Repository<T> {
  findById(id: string): Promise<T | null>;
  findAll(): Promise<T[]>;
  create(item: Omit<T, 'id'>): Promise<T>;
  update(id: string, updates: Partial<T>): Promise<T>;
  delete(id: string): Promise<void>;
}

class IndexedDBProjectRepository implements Repository<Project> {
  constructor(private db: IDBDatabase) {}
  
  async findById(id: string): Promise<Project | null> {
    // IndexedDB-specific implementation
  }
  
  async findAll(): Promise<Project[]> {
    // IndexedDB-specific implementation
  }
  
  // ... other methods
}

class PostgreSQLProjectRepository implements Repository<Project> {
  constructor(private client: PostgresClient) {}
  
  async findById(id: string): Promise<Project | null> {
    // PostgreSQL-specific implementation
  }
  
  // ... other methods
}
\`\`\`

**Implementation Example:**

\`\`\`typescript
// Service layer uses repository interface
class ProjectService {
  constructor(private repository: Repository<Project>) {}
  
  async getProject(id: string): Promise<Project | null> {
    return this.repository.findById(id);
  }
  
  async createProject(name: string): Promise<Project> {
    return this.repository.create({ name, createdAt: new Date() });
  }
}

// Inject appropriate repository based on context
const clientProjectService = new ProjectService(
  new IndexedDBProjectRepository(db)
);

const serverProjectService = new ProjectService(
  new PostgreSQLProjectRepository(client)
);
\`\`\`

**Benefits:**
- Storage implementation can be swapped without changing business logic
- Easy to test with mock repositories
- Consistent API across different storage backends
- Separation of concerns (business logic vs. data access)

**Tradeoffs:**
- Additional abstraction layer adds complexity
- May hide storage-specific features
- Requires more boilerplate code

**Usage in System:**
- Project management (IndexedDB on client, PostgreSQL on server)
- Media library (OPFS for files, IndexedDB for metadata)
- Chat history (IndexedDB for cache, PostgreSQL for persistence)

---

#### Pattern: Command Pattern

**Category:** Code-Level

**Intent:** Encapsulate editing operations as objects to enable undo/redo functionality.

**Applicability:** Use for any user action that modifies timeline state.

**Structure:**

\`\`\`typescript
interface Command {
  execute(): void;
  undo(): void;
  redo(): void;
}

class AddElementCommand implements Command {
  constructor(
    private timeline: Timeline,
    private element: TimelineElement,
    private trackId: string
  ) {}
  
  execute(): void {
    this.timeline.addElement(this.trackId, this.element);
  }
  
  undo(): void {
    this.timeline.removeElement(this.element.id);
  }
  
  redo(): void {
    this.execute();
  }
}

class CommandManager {
  private undoStack: Command[] = [];
  private redoStack: Command[] = [];
  
  execute(command: Command): void {
    command.execute();
    this.undoStack.push(command);
    this.redoStack = []; // Clear redo stack
  }
  
  undo(): void {
    const command = this.undoStack.pop();
    if (command) {
      command.undo();
      this.redoStack.push(command);
    }
  }
  
  redo(): void {
    const command = this.redoStack.pop();
    if (command) {
      command.redo();
      this.undoStack.push(command);
    }
  }
}
\`\`\`

**Benefits:**
- Undo/redo functionality comes naturally
- Operations are encapsulated and testable
- Easy to add new command types
- Enables command history and macro recording

**Tradeoffs:**
- Increases number of classes
- Commands must store state for undo
- Memory usage grows with undo stack

**Usage in System:**
- All timeline editing operations (add/remove/move elements)
- Track modifications (add/remove/reorder tracks)
- Property changes (volume, opacity, effects)

---

#### Pattern: Observer Pattern (via Zustand)

**Category:** State Management

**Intent:** Notify components automatically when state changes.

**Applicability:** Use for any shared state that multiple components need to react to.

**Structure:**

\`\`\`typescript
// Zustand store is the observable
const useEditorStore = create<EditorStore>((set, get) => ({
  playbackPosition: 0,
  isPlaying: false,
  
  setPlaybackPosition: (position: number) => {
    set({ playbackPosition: position });
  },
  
  play: () => {
    set({ isPlaying: true });
    // Start playback interval
  },
  
  pause: () => {
    set({ isPlaying: false });
    // Stop playback interval
  }
}));

// Components are observers
function Timeline() {
  // Component subscribes to playbackPosition changes
  const playbackPosition = useEditorStore(state => state.playbackPosition);
  
  return <TimelineMarker position={playbackPosition} />;
}

function PlaybackControls() {
  // Component subscribes to isPlaying changes
  const { isPlaying, play, pause } = useEditorStore(
    state => ({ isPlaying: state.isPlaying, play: state.play, pause: state.pause })
  );
  
  return (
    <button onClick={isPlaying ? pause : play}>
      {isPlaying ? 'Pause' : 'Play'}
    </button>
  );
}
\`\`\`

**Benefits:**
- Automatic re-rendering when state changes
- Decoupled components (don't need direct references)
- Selective subscription (only re-render when used state changes)
- Easy to debug with dev tools

**Tradeoffs:**
- Can lead to excessive re-renders if not careful
- State changes are implicit (harder to trace)

**Usage in System:**
- Editor state (playback, timeline, selection)
- Media library state (assets, thumbnails)
- AI chat state (messages, conversations)
- UI state (modals, sidebars, tooltips)
```

---

## 5.3 API Design

### Purpose
Document all APIs (REST, GraphQL, WebSocket) with endpoints, request/response formats, authentication, and versioning.

### REST API Documentation

#### Endpoint Template

```markdown
##### Endpoint: [HTTP Method] [Path]

**Description:** [What this endpoint does]

**Authentication:** [Required / Optional / None]

**Rate Limiting:** [Limit per time period]

**Request:**
- **Path Parameters:** [Parameter list]
- **Query Parameters:** [Parameter list]
- **Request Body:** [JSON schema]

**Response:**
- **Success (200):** [JSON schema]
- **Error (4xx/5xx):** [Error schema]

**Example Request:**
\`\`\`http
[HTTP request]
\`\`\`

**Example Response:**
\`\`\`json
[JSON response]
\`\`\`

**Error Codes:**
| Code | Message | Description |
|------|---------|-------------|
| 400 | [Message] | [When this happens] |
| 401 | [Message] | [When this happens] |
```

#### Example API Documentation

```markdown
### REST API Endpoints

#### Video Generation API

##### Endpoint: POST /api/generate-video

**Description:** Submit a video generation request using ComfyUI workflows.

**Authentication:** Required (Bearer token)

**Rate Limiting:** 10 requests per minute per user

**Request:**
- **Path Parameters:** None
- **Query Parameters:** None
- **Request Body:**
\`\`\`typescript
{
  workflow: string;          // ComfyUI workflow JSON
  prompt: string;            // Text prompt for generation
  settings: {
    width: number;           // Video width (512-1920)
    height: number;          // Video height (512-1080)
    duration: number;        // Duration in seconds (1-10)
    fps: number;             // Frames per second (24-60)
  };
  priority?: "low" | "normal" | "high"; // Default: "normal"
}
\`\`\`

**Response:**
- **Success (202 Accepted):**
\`\`\`typescript
{
  jobId: string;
  status: "queued";
  estimatedWaitTime: number; // Seconds
  queuePosition: number;
}
\`\`\`

- **Error (400 Bad Request):**
\`\`\`typescript
{
  error: string;
  details: {
    field: string;
    message: string;
  }[];
}
\`\`\`

**Example Request:**
\`\`\`http
POST /api/generate-video HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
Content-Type: application/json

{
  "workflow": "mochi_txt2vid",
  "prompt": "A cat playing piano in cyberpunk city",
  "settings": {
    "width": 1280,
    "height": 720,
    "duration": 5,
    "fps": 30
  },
  "priority": "normal"
}
\`\`\`

**Example Response:**
\`\`\`json
{
  "jobId": "job_abc123def456",
  "status": "queued",
  "estimatedWaitTime": 120,
  "queuePosition": 3
}
\`\`\`

**Error Codes:**
| Code | Message | Description |
|------|---------|-------------|
| 400 | Invalid workflow | Workflow JSON is malformed or unsupported |
| 400 | Invalid dimensions | Width/height outside allowed range |
| 401 | Unauthorized | Missing or invalid auth token |
| 429 | Rate limit exceeded | Too many requests, try again later |
| 503 | Service unavailable | ComfyUI backend is down |

---

##### Endpoint: GET /api/jobs/:jobId

**Description:** Get the status and result of a video generation job.

**Authentication:** Required (Bearer token)

**Rate Limiting:** 60 requests per minute per user

**Request:**
- **Path Parameters:**
  - \`jobId\` (string, required): Job ID returned from POST /api/generate-video
- **Query Parameters:** None
- **Request Body:** None

**Response:**
- **Success (200 OK):**
\`\`\`typescript
{
  jobId: string;
  status: "queued" | "processing" | "complete" | "failed";
  progress?: number;           // 0-100 (only for "processing")
  resultUrl?: string;          // Only for "complete"
  error?: string;              // Only for "failed"
  createdAt: string;           // ISO 8601 timestamp
  startedAt?: string;          // ISO 8601 timestamp
  completedAt?: string;        // ISO 8601 timestamp
  metadata?: {
    width: number;
    height: number;
    duration: number;
    fps: number;
    fileSize: number;          // Bytes
  };
}
\`\`\`

**Example Request:**
\`\`\`http
GET /api/jobs/job_abc123def456 HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
\`\`\`

**Example Response (Complete):**
\`\`\`json
{
  "jobId": "job_abc123def456",
  "status": "complete",
  "resultUrl": "https://storage.example.com/videos/abc123.mp4",
  "createdAt": "2025-11-09T13:00:00Z",
  "startedAt": "2025-11-09T13:02:00Z",
  "completedAt": "2025-11-09T13:05:30Z",
  "metadata": {
    "width": 1280,
    "height": 720,
    "duration": 5,
    "fps": 30,
    "fileSize": 15728640
  }
}
\`\`\`

**Error Codes:**
| Code | Message | Description |
|------|---------|-------------|
| 404 | Job not found | Invalid job ID or job expired |
| 401 | Unauthorized | Missing or invalid auth token |
```

### WebSocket API Documentation

```markdown
#### WebSocket: Job Status Updates

**Endpoint:** \`wss://api.example.com/ws/jobs/:jobId\`

**Authentication:** Query parameter \`token=[Bearer token]\`

**Purpose:** Receive real-time status updates for a job instead of polling.

**Connection:**
\`\`\`javascript
const ws = new WebSocket(
  \`wss://api.example.com/ws/jobs/\${jobId}?token=\${authToken}\`
);

ws.onopen = () => {
  console.log('Connected to job status updates');
};

ws.onmessage = (event) => {
  const update = JSON.parse(event.data);
  console.log('Job update:', update);
};

ws.onerror = (error) => {
  console.error('WebSocket error:', error);
};

ws.onclose = () => {
  console.log('Connection closed');
};
\`\`\`

**Message Format:**
\`\`\`typescript
{
  type: "status_update" | "progress_update" | "complete" | "error";
  jobId: string;
  status: "queued" | "processing" | "complete" | "failed";
  progress?: number;           // 0-100
  message?: string;
  resultUrl?: string;          // Only for type: "complete"
  error?: string;              // Only for type: "error"
  timestamp: string;           // ISO 8601
}
\`\`\`

**Example Messages:**

*Status Update:*
\`\`\`json
{
  "type": "status_update",
  "jobId": "job_abc123def456",
  "status": "processing",
  "message": "Started video generation",
  "timestamp": "2025-11-09T13:02:00Z"
}
\`\`\`

*Progress Update:*
\`\`\`json
{
  "type": "progress_update",
  "jobId": "job_abc123def456",
  "status": "processing",
  "progress": 45,
  "message": "Generating frames...",
  "timestamp": "2025-11-09T13:04:00Z"
}
\`\`\`

*Complete:*
\`\`\`json
{
  "type": "complete",
  "jobId": "job_abc123def456",
  "status": "complete",
  "resultUrl": "https://storage.example.com/videos/abc123.mp4",
  "timestamp": "2025-11-09T13:05:30Z"
}
\`\`\`

*Error:*
\`\`\`json
{
  "type": "error",
  "jobId": "job_abc123def456",
  "status": "failed",
  "error": "GPU out of memory",
  "timestamp": "2025-11-09T13:03:45Z"
}
\`\`\`
```

### API Versioning Strategy

```markdown
#### API Versioning Strategy

**Approach:** URI versioning (\`/api/v1/...\`, \`/api/v2/...\`)

**Rationale:** 
- Clear and explicit
- Easy to route and test
- Compatible with caching and CDNs

**Version Support Policy:**
- Current version (v1): Fully supported
- Previous version: Supported for 6 months after new version release
- Deprecated version: 3-month sunset period with warnings

**Breaking Changes:**
- Require new major version
- Documented in changelog
- Migration guide provided

**Non-Breaking Changes:**
- Can be added to current version
- Optional parameters
- New endpoints
- Additional response fields

**Deprecation Process:**
1. Announce deprecation 6 months in advance
2. Add deprecation warnings to API responses
3. Provide migration guide and tooling
4. Support both versions during transition
5. Sunset old version after 3-month warning period
```

---

## Best Practices

1. **Architecture diagrams should be clear**: Use consistent notation, limit complexity
2. **Document component responsibilities**: Clear separation of concerns
3. **Show data flows**: Sequence diagrams for complex interactions
4. **Explain pattern choices**: Why this pattern fits the use case
5. **Provide code examples**: Show implementation, not just theory
6. **Document APIs completely**: Every endpoint, every parameter, every error code
7. **Version your APIs**: Plan for evolution, document breaking changes

---

## Perplexity Research Queries

- "Clean architecture patterns for [framework]"
- "Repository pattern implementation in [language]"
- "REST API design best practices 2025"
- "WebSocket vs polling for real-time updates"
- "API versioning strategies comparison"
- "Microservices communication patterns"

---

## Quality Checklist

- [ ] High-level architecture diagram included
- [ ] All major components documented
- [ ] Component responsibilities clearly defined
- [ ] Data flows visualized with sequence diagrams
- [ ] Design patterns explained with examples
- [ ] Pattern tradeoffs documented
- [ ] REST API endpoints fully documented
- [ ] Request/response schemas provided
- [ ] Error codes documented
- [ ] Authentication requirements specified
- [ ] Rate limiting documented
- [ ] WebSocket protocols defined (if applicable)
- [ ] API versioning strategy documented
- [ ] Breaking change policy defined

---

## Version History

**v1.0** (2025-11-09): Initial section guide

