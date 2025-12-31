# OuraCLI Project Guidelines

**⚠️ Generic: [warp.md](./warp.md) | Python: [warp-python.md](./warp-python.md) | Taskfile: [warp-taskfile.md](./warp-taskfile.md)**

**Tech Type**: CLI

**Specification**: [warp-specification.md](./warp-specification.md)

## 📋 Workflow

```bash
task check         # Pre-commit (fmt, lint, test)
task test:coverage # Coverage (≥75%)
task build         # Build CLI
task clean         # Clean artifacts
```

## 🔐 Secrets

```bash
ls secrets/
cp secrets/oura.example secrets/oura  # Oura API token
```

## ⚠️ Standards

- **Pre-Commit**: `task check`
- **Coverage**: ≥75% overall + per-module
- **Secrets**: `secrets/` dir with `.example` templates
