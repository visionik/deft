# Telemetry Standards

Logging, tracing, metrics, and error tracking for production systems.

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**Scope:** Observability, monitoring, and debugging across all modes.

**⚠️ See also**: [main.md](../main.md) | [coding.md](../core/coding.md)

## Mode-Specific Requirements

### fun Mode (Learning/Prototyping)

**Logging:**
- ? Use print() or basic logging
- ? Structured logging optional

**Error Tracking:**
- ? Optional

**Tracing:**
- ? Optional

**Metrics:**
- ? Optional

### fast Mode (Development - Default)

**Logging:**
- ~ Structured logging (structlog, loguru, zerolog)
- ~ Log levels: DEBUG, INFO, WARN, ERROR
- ~ Include context: timestamp, level, message, request_id

**Error Tracking:**
- ~ Use Sentry.io or equivalent
- ~ Sample rate: 10-50% in dev, 100% errors
- ~ Capture stack traces

**Tracing:**
- ? Optional for debugging
- ~ Use for complex workflows

**Metrics:**
- ~ Basic metrics (request count, latency)
- ? Custom business metrics

### pro Mode (Production)

**Logging:**
- ! Structured logging mandatory
- ! Log levels: INFO, WARN, ERROR (⊗ DEBUG in production)
- ! Include: timestamp, level, message, trace_id, span_id, user_id, request_id
- ! Log rotation and retention policy

**Error Tracking:**
- ! Sentry.io or equivalent mandatory
- ! Sample rate: 100% errors, 10-20% transactions
- ! Release tracking and source maps
- ! User feedback integration

**Tracing:**
- ! Distributed tracing (OpenTelemetry, logfire, Sentry)
- ! Instrument critical paths
- ! Trace sampling: 1-10% in production
- ! Include: service name, operation name, duration, tags

**Metrics:**
- ! RED metrics (Rate, Error, Duration)
- ! System metrics (CPU, memory, disk)
- ! Business metrics (orders, users, revenue)
- ! Alerting on SLOs/SLIs

## Technology Choices

### Recommended Stacks

**Python:**
```python
# pro mode - Full OpenTelemetry
import logfire
logfire.configure(token="...", service_name="my-service")

@logfire.instrument()
def process_order(order: Order) -> Result:
    with logfire.span("validate_order", order_id=order.id):
        # ... validation
    return result

# fast mode - Sentry + structlog
import sentry_sdk
import structlog

sentry_sdk.init(
    dsn="https://...@sentry.io/...",
    traces_sample_rate=0.1,
    profiles_sample_rate=0.1,
)

log = structlog.get_logger()
log.info("order_processed", order_id=order.id, amount=order.total)
```

**Go:**
```go
// pro mode - OpenTelemetry
import (
    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/trace"
)

tracer := otel.Tracer("my-service")
ctx, span := tracer.Start(ctx, "process_order")
defer span.End()

// fast mode - zerolog + Sentry
import (
    "github.com/rs/zerolog/log"
    "github.com/getsentry/sentry-go"
)

sentry.Init(sentry.ClientOptions{
    Dsn: "https://...@sentry.io/...",
    TracesSampleRate: 0.1,
})

log.Info().Str("order_id", id).Msg("order processed")
```

**TypeScript:**
```typescript
// pro mode - OpenTelemetry
import { trace } from '@opentelemetry/api';
import * as Sentry from '@sentry/node';

const tracer = trace.getTracer('my-service');
const span = tracer.startSpan('process_order');
// ... work
span.end();

// fast mode - Sentry
Sentry.init({
  dsn: 'https://...@sentry.io/...',
  tracesSampleRate: 0.1,
});

Sentry.captureMessage('Order processed', {
  level: 'info',
  tags: { order_id: order.id },
});
```

**C++:**
```cpp
// pro mode - OpenTelemetry C++
#include <opentelemetry/trace/provider.h>

auto tracer = opentelemetry::trace::Provider::GetTracerProvider()
    ->GetTracer("my-service");
auto span = tracer->StartSpan("process_order");
// ... work
span->End();

// fast mode - spdlog
#include <spdlog/spdlog.h>

spdlog::info("Order processed: order_id={}", order_id);
```

## Logging Best Practices

**Structure:**
- ! JSON format for machine parsing
- ! Human-readable format for development
- ! Consistent field names across services

**Content:**
- ! Include context: timestamp, level, logger name, message
- ~ Include identifiers: user_id, request_id, trace_id, span_id
- ~ Include metadata: environment, version, host
- ⊗ Log sensitive data (PII, secrets, passwords)

**Levels:**
- **DEBUG**: Detailed diagnostic information (fun/fast only)
- **INFO**: General informational messages
- **WARN**: Warning messages, potentially harmful situations
- **ERROR**: Error events, but application continues
- **FATAL**: Severe errors causing shutdown

**Examples:**
```python
# Good
log.info("order_created", order_id=order.id, user_id=user.id, total=order.total)

# Bad
log.info(f"Order {order.id} created by {user.email} for ${order.total}")  # Not structured
log.debug(f"Password: {password}")  # Sensitive data
```

## Tracing Best Practices

**Span Naming:**
- ! Use verb + noun: `process_order`, `validate_user`, `fetch_data`
- ! Include operation type: `http.request`, `db.query`, `cache.get`
- ⊗ Generic names: `process`, `handle`, `do_work`

**Span Attributes:**
- ~ Add business context: order_id, user_id, amount
- ~ Add technical context: http.method, http.status_code, db.statement
- ~ Add errors: error=true, error.message, error.type
- ⊗ Add sensitive data

**Sampling:**
- ! Sample strategically to control costs
- ~ 100% errors, 1-10% success in production
- ~ Higher rate for critical paths
- ? Adaptive sampling based on latency

## Metrics Best Practices

**RED Metrics (Mandatory in pro):**
- **Rate**: Requests per second
- **Error**: Error rate (%)
- **Duration**: Latency (p50, p95, p99)

**Naming:**
- ! Use descriptive names: `http_requests_total`, `order_processing_duration_seconds`
- ! Include units: `_seconds`, `_bytes`, `_total`
- ! Use labels for dimensions: method, status, endpoint

**Types:**
- **Counter**: Monotonically increasing (requests, errors)
- **Gauge**: Current value (memory, queue depth)
- **Histogram**: Distribution (latency, size)
- **Summary**: Similar to histogram (p50, p95, p99)

## Error Tracking

**What to Track:**
- ! All unhandled exceptions
- ! Explicit error captures (validation failures, business logic errors)
- ~ Performance issues (slow queries, timeouts)
- ~ User feedback (bug reports, feature requests)

**Context:**
- ! Stack trace
- ! Request data (sanitized)
- ! User context (ID, not PII)
- ! Environment (version, host, OS)
- ~ Breadcrumbs (previous events)

**Sentry Configuration:**
```python
import sentry_sdk

sentry_sdk.init(
    dsn="https://...@sentry.io/...",
    environment="production",
    release="my-app@1.2.3",
    traces_sample_rate=0.1,
    profiles_sample_rate=0.1,
    before_send=sanitize_data,  # ! Remove PII
)
```

## Integration Patterns

**Context Propagation:**
- ! Propagate trace_id and span_id across service boundaries
- ! Use W3C Trace Context headers
- ! Include in logs for correlation

**Correlation:**
```python
# Link logs to traces
log = structlog.get_logger()
log.bind(
    trace_id=trace.get_current_span().get_span_context().trace_id,
    span_id=trace.get_current_span().get_span_context().span_id,
)
```

**Alerting:**
- ! Alert on error rate spikes
- ! Alert on latency degradation (p95 > threshold)
- ! Alert on critical business metrics
- ~ Use runbooks for common issues

## Anti-Patterns

- ⊗ Logging in tight loops (performance impact)
- ⊗ Logging sensitive data (PII, secrets, passwords)
- ⊗ Using string formatting instead of structured logging
- ⊗ No sampling in high-traffic production (cost explosion)
- ⊗ Ignoring errors silently
- ⊗ Missing context (no trace_id, request_id)
- ⊗ Generic span/metric names
- ⊗ Over-instrumenting (trace everything)

## Mode Decision Matrix

| Feature | fun | fast | pro |
|---------|-----|------|-----|
| Structured Logging | ? | ~ | ! |
| Error Tracking | ? | ~ | ! |
| Distributed Tracing | ? | ? | ! |
| Metrics (RED) | ? | ~ | ! |
| Log Rotation | ? | ~ | ! |
| Alerting | ? | ? | ! |
| PII Sanitization | ? | ~ | ! |
| Source Maps | ? | ~ | ! |
| Release Tracking | ? | ~ | ! |

## Testing Telemetry

**Development:**
- ~ Use local exporters (console, file)
- ~ Test with sampling=1.0
- ~ Verify context propagation

**Staging:**
- ~ Mirror production config
- ~ Test alerting thresholds
- ~ Validate dashboards

**Production:**
- ! Gradual rollout of telemetry changes
- ! Monitor telemetry overhead (<5% CPU)
- ! Validate data quality

## References

- OpenTelemetry: https://opentelemetry.io/
- Sentry.io: https://sentry.io/
- logfire: https://pydantic.dev/logfire
- structlog: https://www.structlog.org/
- zerolog: https://github.com/rs/zerolog
