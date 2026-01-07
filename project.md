# reminderbot.ai Project Guidelines

**⚠️ Generic: [warp.md](./warp.md) | Typescript: [typescript.md](./typescript.md) | Taskfile: [taskfile.md](./taskfile.md)**

**Tech Type**: Statis Web Site using TS + React + next.js + Shadcn/UI + tailwindcss

**Specification**: [specification.md](./specification.md)

## 📋 Workflow

```bash
task check         # Pre-commit (fmt, lint, test, test:coverage)
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

- **Pre-Commit**: ALWAYS RUN `task check`
- **Coverage**: ≥75% overall + per-module
- **Secrets**: `secrets/` dir with `.example` templates
