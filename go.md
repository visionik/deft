# Go Standards

**⚠️ Generic: [warp.md](./warp.md) | Project: [project.md](./project.md)**

## 📋 Standards

**Docs**: [go.dev/doc/comment](https://go.dev/doc/comment) - all exported need doc comments (complete sentences)

**Testing**: Testify, ≥75% overall + per-pkg (mandatory), integration for critical paths, exclude main()/run()

**Coverage**: Count internal/* + pkg/*, exclude entry points/utilities/generated

## 🛠️ Commands

```bash
task build           # Build
task test            # Run tests
task test:coverage   # Coverage (≥75%)
task go:fmt          # Format
task go:vet          # Vet
task quality         # All quality checks
task check           # Pre-commit (fmt+vet+test)
go test -v ./pkg/X/  # Specific package
go doc ./pkg/X       # View docs
```

## 📝 Workflow

1. Write code following go.dev/doc/comment
2. `task go:fmt && task go:vet`
3. `task test:coverage` (≥75%)
4. `task check` before commit

**Tests**: Testify assert/require, `*_test.go`, `TestFuncName(t *testing.T)`, ≥75% per-pkg

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

## ⚠️ Compliance

- go.dev/doc/comment for all exported
- Testify, ≥75% coverage
- `task check` before commit
