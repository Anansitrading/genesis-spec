# Genesis Section 09: Monitoring & Observability

**Purpose:** Guide for documenting monitoring, logging, tracing, and alerting strategies.

---

## Section Overview

Monitoring & Observability ensures you can detect issues, diagnose problems, and understand system behavior in production.

### Key Components

1. **Application Monitoring**: Error tracking, performance monitoring, logging
2. **AI/Agent Observability**: LLM tracing, token usage, cost tracking (if applicable)
3. **Business Metrics**: User analytics, feature usage, conversion tracking

---

## 9.1 Application Monitoring

### Error Tracking

**Tool:** Sentry

**Configuration:**
```typescript
// sentry.client.config.ts
import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  environment: process.env.NODE_ENV,
  
  // Performance Monitoring
  tracesSampleRate: 0.1, // 10% of transactions
  
  // Session Replay
  replaysSessionSampleRate: 0.1,
  replaysOnErrorSampleRate: 1.0,
  
  // Error Filtering
  ignoreErrors: [
    'ResizeObserver loop limit exceeded',
    'Non-Error promise rejection captured',
  ],
  
  beforeSend(event, hint) {
    // Filter sensitive data
    if (event.request) {
      delete event.request.cookies;
      if (event.request.headers) {
        delete event.request.headers['Authorization'];
      }
    }
    return event;
  },
});
```

**Error Context:**
```typescript
// Add user context
Sentry.setUser({
  id: user.id,
  email: user.email, // Will be hashed by Sentry
});

// Add tags for filtering
Sentry.setTag('feature', 'video-editor');
Sentry.setTag('browser', navigator.userAgent);

// Add breadcrumbs for context
Sentry.addBreadcrumb({
  category: 'video',
  message: 'Video upload started',
  level: 'info',
  data: {
    fileSize: file.size,
    fileName: file.name,
  },
});

// Capture exception with context
try {
  await processVideo(file);
} catch (error) {
  Sentry.captureException(error, {
    tags: { operation: 'video-processing' },
    extra: { fileSize: file.size, duration: file.duration },
  });
}
```

**Alerting Rules:**
- **Critical:** Error rate > 5% for 5 minutes â†’ PagerDuty
- **High:** New error type with > 10 occurrences â†’ Slack #alerts
- **Medium:** Performance degradation > 2x baseline â†’ Slack #monitoring
- **Low:** Warning logs spike â†’ Email digest

### Performance Monitoring

**Frontend Performance:**
```typescript
// Web Vitals tracking
import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals';

function sendToAnalytics(metric) {
  // Send to analytics service
  fetch('/api/analytics/vitals', {
    method: 'POST',
    body: JSON.stringify(metric),
    headers: { 'Content-Type': 'application/json' },
  });
}

getCLS(sendToAnalytics);
getFID(sendToAnalytics);
getFCP(sendToAnalytics);
getLCP(sendToAnalytics);
getTTFB(sendToAnalytics);

// Custom performance marks
performance.mark('video-upload-start');
// ... upload logic
performance.mark('video-upload-end');
performance.measure('video-upload', 'video-upload-start', 'video-upload-end');

// Report custom metrics
const uploadMeasure = performance.getEntriesByName('video-upload')[0];
Sentry.captureMessage('Video Upload Performance', {
  level: 'info',
  extra: { duration: uploadMeasure.duration },
});
```

**Backend Performance:**
```typescript
// API route instrumentation
import { withSentry } from '@sentry/nextjs';

export default withSentry(async function handler(req, res) {
  const transaction = Sentry.startTransaction({
    op: 'api',
    name: `${req.method} ${req.url}`,
  });
  
  try {
    // Database query span
    const dbSpan = transaction.startChild({
      op: 'db.query',
      description: 'Fetch projects',
    });
    const projects = await db.projects.findAll({ userId });
    dbSpan.finish();
    
    // External API span
    const apiSpan = transaction.startChild({
      op: 'http.client',
      description: 'Gemini API call',
    });
    const response = await fetch('https://api.gemini.com/...');
    apiSpan.finish();
    
    res.json(projects);
  } catch (error) {
    transaction.setStatus('internal_error');
    throw error;
  } finally {
    transaction.finish();
  }
});
```

**Performance Targets:**
| Metric | Target | Monitoring |
|--------|--------|------------|
| First Contentful Paint | < 1.5s | Lighthouse CI |
| Largest Contentful Paint | < 2.5s | Web Vitals |
| First Input Delay | < 100ms | Web Vitals |
| Cumulative Layout Shift | < 0.1 | Web Vitals |
| Time to Interactive | < 3.5s | Lighthouse CI |
| API Response Time (p95) | < 500ms | Sentry Performance |
| API Response Time (p99) | < 1s | Sentry Performance |
| Database Query Time (p95) | < 100ms | PostgreSQL logs |

### Logging Strategy

**Log Levels:**
- **ERROR:** Application errors, exceptions, failures
- **WARN:** Degraded functionality, fallbacks activated
- **INFO:** Important business events (user actions, job completions)
- **DEBUG:** Detailed diagnostic information (dev/staging only)

**Structured Logging:**
```typescript
// logger.ts
import pino from 'pino';

const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  formatters: {
    level(label) {
      return { level: label };
    },
  },
  redact: {
    paths: ['req.headers.authorization', 'req.headers.cookie', '*.password', '*.token'],
    remove: true,
  },
});

export default logger;

// Usage
logger.info({ userId, projectId }, 'Project created');
logger.error({ err, userId, operation: 'video-upload' }, 'Upload failed');
logger.warn({ jobId, attempts: 3 }, 'Job retry limit reached');
```

**Log Aggregation:**
- **Platform:** Vercel Logs + Railway Logs
- **Retention:** 7 days (production), 3 days (staging)
- **Search:** Full-text search by level, user ID, operation
- **Exporting:** Export to S3 for long-term storage (90 days)

### Infrastructure Monitoring

**Metrics to Track:**
| Metric | Tool | Alert Threshold |
|--------|------|-----------------|
| CPU Usage | Railway Dashboard | > 80% for 10 min |
| Memory Usage | Railway Dashboard | > 85% for 5 min |
| Disk Usage | Railway Dashboard | > 90% |
| Database Connections | PostgreSQL | > 80% of max |
| Redis Memory | Redis | > 75% of max |
| API Request Rate | Vercel Analytics | > 10,000/min |
| Error Rate | Sentry | > 5% for 5 min |
| Response Time (p95) | Sentry | > 1s for 10 min |

**Dashboard:**
```typescript
// Custom Grafana dashboard (if self-hosted)
{
  "dashboard": {
    "title": "Application Health",
    "panels": [
      {
        "title": "Request Rate",
        "targets": [
          { "expr": "rate(http_requests_total[5m])" }
        ]
      },
      {
        "title": "Error Rate",
        "targets": [
          { "expr": "rate(http_requests_total{status=~'5..'}[5m])" }
        ]
      },
      {
        "title": "Response Time (p95)",
        "targets": [
          { "expr": "histogram_quantile(0.95, http_request_duration_seconds_bucket)" }
        ]
      }
    ]
  }
}
```

---

## 9.2 AI/Agent Observability

### LLM Tracing

**Tool:** Langfuse

**Integration:**
```typescript
// langfuse.ts
import { Langfuse } from 'langfuse';

export const langfuse = new Langfuse({
  publicKey: process.env.LANGFUSE_PUBLIC_KEY,
  secretKey: process.env.LANGFUSE_SECRET_KEY,
  baseUrl: process.env.LANGFUSE_URL,
});

// Trace AI conversation
const trace = langfuse.trace({
  name: 'ai-chat',
  userId: user.id,
  metadata: {
    conversationId,
    userPrompt: message,
  },
});

// Trace LLM call
const generation = trace.generation({
  name: 'gemini-chat',
  model: 'gemini-1.5-flash',
  modelParameters: {
    temperature: 0.7,
    maxTokens: 1000,
  },
  input: message,
});

const response = await geminiChat(message);

generation.end({
  output: response,
  metadata: {
    tokensUsed: response.usage.totalTokens,
    latency: response.latency,
  },
});

trace.update({
  output: response.content,
});
```

**Metrics to Track:**
| Metric | Purpose | Alert Threshold |
|--------|---------|-----------------|
| Token Usage (per user) | Cost control | > 100K tokens/day |
| Token Usage (total) | Budget tracking | > 1M tokens/day |
| Average Latency | Performance | > 3s for p95 |
| Error Rate | Reliability | > 2% |
| Cost per Conversation | Profitability | > $0.10 |
| Prompt Length | Optimization | > 2000 tokens |
| Response Length | Quality | < 50 tokens (too short) |

### Agent Workflow Tracing

**LangGraph Observability:**
```typescript
// Trace multi-agent workflow
const workflowTrace = langfuse.trace({
  name: 'video-generation-workflow',
  userId: user.id,
  metadata: {
    workflowId,
    prompt: userPrompt,
  },
});

// Trace each agent step
const step1 = workflowTrace.span({
  name: 'prompt-enhancement',
  input: userPrompt,
});

const enhancedPrompt = await promptEnhancerAgent(userPrompt);
step1.end({ output: enhancedPrompt });

const step2 = workflowTrace.span({
  name: 'workflow-selection',
  input: enhancedPrompt,
});

const workflowType = await workflowSelectorAgent(enhancedPrompt);
step2.end({ output: workflowType });

const step3 = workflowTrace.span({
  name: 'video-generation',
  input: { prompt: enhancedPrompt, workflow: workflowType },
});

const videoUrl = await videoGenerationAgent(enhancedPrompt, workflowType);
step3.end({ output: videoUrl });

workflowTrace.update({
  output: videoUrl,
  metadata: {
    totalDuration: step1.duration + step2.duration + step3.duration,
    success: true,
  },
});
```

### Cost Tracking

**Budget Monitoring:**
```typescript
// Track costs per user
async function trackAICost(userId: string, model: string, tokens: number) {
  const costPerToken = {
    'gemini-1.5-flash': 0.00000007, // $0.07 per 1M tokens
    'gpt-4': 0.00003,               // $30 per 1M tokens
    'text-embedding-3-small': 0.00000002, // $0.02 per 1M tokens
  };
  
  const cost = tokens * costPerToken[model];
  
  await db.userUsage.increment(userId, {
    tokensUsed: tokens,
    costAccrued: cost,
  });
  
  // Check budget limits
  const usage = await db.userUsage.findByUserId(userId);
  if (usage.costAccrued > 10.00) { // $10 daily limit
    await notifyUser(userId, 'AI usage limit reached');
    throw new Error('Daily AI usage limit exceeded');
  }
  
  // Log to analytics
  logger.info({
    userId,
    model,
    tokens,
    cost,
    dailyTotal: usage.costAccrued,
  }, 'AI cost tracked');
}
```

**Cost Dashboard:**
- Total cost per day/week/month
- Cost per user (identify heavy users)
- Cost per model (optimize model selection)
- Cost per feature (video gen vs chat)
- Cost trends and projections

---

## 9.3 Business Metrics

### User Analytics

**Events to Track:**
```typescript
// analytics.ts
export const trackEvent = (event: string, properties?: Record<string, any>) => {
  // Send to analytics (privacy-respecting)
  if (typeof window \!== 'undefined' && window.plausible) {
    window.plausible(event, { props: properties });
  }
};

// Usage examples
trackEvent('project_created', { projectType: 'video' });
trackEvent('video_uploaded', { fileSize, duration });
trackEvent('ai_message_sent', { messageLength });
trackEvent('video_exported', { resolution, duration, format });
trackEvent('feature_used', { featureName: 'timeline-zoom' });
```

**Key Metrics:**
| Metric | Definition | Target |
|--------|------------|--------|
| Daily Active Users (DAU) | Unique users per day | 500+ by month 3 |
| Weekly Active Users (WAU) | Unique users per week | 2000+ by month 3 |
| Monthly Active Users (MAU) | Unique users per month | 5000+ by month 3 |
| DAU/MAU Ratio | Stickiness (DAU/MAU) | > 20% |
| Retention (Day 1) | Users who return next day | > 40% |
| Retention (Day 7) | Users who return in 7 days | > 25% |
| Retention (Day 30) | Users who return in 30 days | > 15% |
| Avg Session Duration | Time spent per session | > 10 minutes |
| Projects per User | Avg projects created | > 2 |
| Videos per Project | Avg videos per project | > 3 |
| AI Messages per User | AI engagement | > 5 per week |

### Feature Usage Analytics

**Funnel Analysis:**
```typescript
// Track user journey
trackEvent('funnel_step', { funnel: 'video-export', step: 'start' });
trackEvent('funnel_step', { funnel: 'video-export', step: 'settings' });
trackEvent('funnel_step', { funnel: 'video-export', step: 'processing' });
trackEvent('funnel_step', { funnel: 'video-export', step: 'complete' });

// Conversion rates
// - Sign up â†’ First project: 70%
// - First project â†’ First video upload: 85%
// - First video upload â†’ First export: 60%
// - First export â†’ Second project: 40%
```

**A/B Testing:**
```typescript
// Feature flags for A/B tests
const variant = await getExperimentVariant(userId, 'new-timeline-ui');

if (variant === 'treatment') {
  // Show new UI
  trackEvent('experiment_exposure', { 
    experiment: 'new-timeline-ui', 
    variant: 'treatment' 
  });
} else {
  // Show old UI
  trackEvent('experiment_exposure', { 
    experiment: 'new-timeline-ui', 
    variant: 'control' 
  });
}

// Track outcomes
trackEvent('timeline_interaction', { 
  experiment: 'new-timeline-ui',
  variant,
  action: 'element-moved',
});
```

### Alerting Strategy

**Alert Channels:**
- **Critical:** PagerDuty (24/7 on-call)
- **High:** Slack #alerts (immediate attention)
- **Medium:** Slack #monitoring (review in 1 hour)
- **Low:** Email digest (daily summary)

**Alert Rules:**
```yaml
# alerts.yml
alerts:
  - name: High Error Rate
    condition: error_rate > 5% for 5 minutes
    severity: critical
    channel: pagerduty
    
  - name: Slow API Response
    condition: p95_response_time > 1s for 10 minutes
    severity: high
    channel: slack
    
  - name: Database Connection Pool Exhausted
    condition: db_connections > 80% for 5 minutes
    severity: high
    channel: slack
    
  - name: AI Cost Spike
    condition: hourly_ai_cost > $50
    severity: medium
    channel: slack
    
  - name: User Signups Dropped
    condition: signups < 10 per hour for 2 hours
    severity: medium
    channel: slack
    
  - name: Low Disk Space
    condition: disk_usage > 85%
    severity: high
    channel: slack
```

---

## Best Practices

1. **Monitor what matters:** Focus on user-impacting metrics
2. **Set up alerts early:** Don't wait for production
3. **Avoid alert fatigue:** Tune thresholds to reduce noise
4. **Context is key:** Add metadata to logs and errors
5. **Track costs:** AI costs can grow quickly
6. **Respect privacy:** Don't log PII
7. **Dashboard for on-call:** Single pane of glass
8. **Postmortem process:** Learn from incidents
9. **Monitor the monitors:** Ensure monitoring is working
10. **Regular review:** Update alerts and dashboards

---

## Perplexity Research Queries

- "Sentry vs Datadog vs New Relic comparison 2025"
- "LLM observability best practices"
- "Web Vitals optimization techniques"
- "Cost tracking for AI applications"
- "Alert fatigue prevention strategies"
- "Privacy-respecting analytics alternatives to Google Analytics"

---

## Quality Checklist

- [ ] Error tracking configured (Sentry or similar)
- [ ] Performance monitoring enabled
- [ ] Logging strategy documented
- [ ] Log levels and structured logging implemented
- [ ] Infrastructure metrics tracked
- [ ] Alerting rules configured
- [ ] LLM tracing enabled (if AI features exist)
- [ ] Cost tracking implemented (if AI features exist)
- [ ] User analytics configured (privacy-respecting)
- [ ] Key business metrics defined
- [ ] Dashboards created for monitoring
- [ ] On-call runbooks prepared

---

## Version History

**v1.0** (2025-11-09): Initial section guide

