# Taskfile Guidelines

**⚠️ Generic: [warp.md](./warp.md) | Migration: [taskfile-migration.md](./taskfile-migration.md)**

## Task-Centric Workflow

**ALWAYS use `task` targets** for repeatable tasks. Add new tasks instead of shell scripts.

```bash
task --list  # See all tasks
```

## Core Principles

- **Entrypoint**: Task as single entry for common flows (`task dev`, `task test`, `task build`)
- **Composable**: Keep tasks small, move logic to scripts, Task orchestrates
- **Naming**: Clear verbs (`lint`, `test`, `build`), namespaces (`docker:build`, `db:migrate`)
- **Default**: Define default task that lists available tasks
- **Split**: Large setups → included Taskfiles (`Taskfile.dev.yml`, `Taskfile.ci.yml`)

## Dependencies & Performance

- **deps**: Use `deps` for task ordering/reuse
- **Caching**: `sources`/`generates` + `method: checksum` for incremental builds
- **Idempotent**: `status`/`preconditions` to skip completed steps

## Robustness

- **Shell options**: `set: [errexit, nounset, pipefail]`
- **Validation**: `requires: vars: [VAR]` to fail early
- **Cleanup**: `defer` for cleanup even on failure

## UX

- **desc**: Add `desc` for all user-facing tasks, `internal: true` for wiring
- **Templates**: Use `vars`, `env`, `{{.CLI_ARGS}}`, `{{.USER_WORKING_DIR}}`
- **Artifacts**: Keep ephemeral in temp dir via `TASK_TEMP_DIR`

