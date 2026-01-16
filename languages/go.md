# Go Standards

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**⚠️ See also**: [main.md](../main.md) | [project.md](../core/project.md) | [telemetry.md](../tools/telemetry.md)

## Standards

### Documentation
- ! Follow [go.dev/doc/comment](https://go.dev/doc/comment)
- ! All exported symbols have doc comments (complete sentences)

### Testing
See [testing.md](../tools/testing.md) for universal requirements.

- ! Use Testify (assert/require)
- Files: `*_test.go`, functions: `TestFuncName(t *testing.T)`

### Coverage
- ! ≥85% coverage
- ! Count internal/\* + pkg/\*
- ! Exclude entry points, utilities, generated code

### Telemetry
- See [telemetry.md](../tools/telemetry.md) for recommendations
- ~ Structured logging (zerolog) for production
- ~ Sentry.io for error tracking
- ? OpenTelemetry for distributed tracing

## Commands

```bash
task build              # Build (or `task go:build` in multi-lang projects)
task test               # Run all tests (unit, integration, fuzzing)
task test:coverage      # Run tests with coverage report (! ≥85%)
task fmt                # Format (or `task go:fmt` in multi-lang projects)
task lint               # Vet (or `task go:vet` in multi-lang projects)
task quality            # All quality checks
task check              # Pre-commit (! run: fmt+lint+test)
```

**Note**: Single-language projects ! use generic names (`fmt`, `lint`). Multi-language projects ! use namespaced names (`go:fmt`, `py:fmt`). See [taskfile.md](./taskfile.md#naming-conventions).



## 🔧 Patterns

**Table-Driven Tests**:

```go
tests := []struct{name string; input, want Type; wantErr bool}{
    {"case1", input1, want1, false},
    {"error", input2, want2, true},
}
for _, tt := range tests {
    t.Run(tt.name, func(t *testing.T) {
        got, err := Fn(tt.input)
        if tt.wantErr { assert.Error(t, err); return }
        assert.NoError(t, err)
        assert.Equal(t, tt.want, got)
    })
}
```

**HTTP**: `w := httptest.NewRecorder(); req, _ := http.NewRequest("GET", "/path", nil); handler.ServeHTTP(w, req); assert.Equal(t, http.StatusOK, w.Code)`

**Interface**: Define consumer-side, mock with function fields

## Compliance Checklist

- ! Follow go.dev/doc/comment for all exported symbols
- ! See [testing.md](../tools/testing.md) for testing requirements
- ! Run `task check` before commit
