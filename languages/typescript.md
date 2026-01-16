# TypeScript Standards

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**⚠️ See also**: [main.md](../main.md) | [project.md](../core/project.md) | [telemetry.md](../tools/telemetry.md)

**Stack**: TypeScript 5.0+, Vitest/Jest; Web: React 18+/Next.js; CLI: commander; Build: Vite/tsup

## Standards

### Documentation
- ! TSDoc comments for all exported APIs

### Testing
See [testing.md](../tools/testing.md) for universal requirements.

- ! Use Vitest (or Jest) + coverage
- Files: `*.spec.ts` or `*.test.ts`

### Coverage
- ! ≥85% coverage
- ! Count src/\*
- ! Exclude entry points, scripts, generated code

### Style
- ! Use ESLint + Prettier
- ~ Prefer functional over classes where practical

### Types
- ! Use strict mode
- ⊗ Use `any`
- ~ Prefer `unknown` for type-safe unknowns

### Telemetry
- See [telemetry.md](../tools/telemetry.md) for recommendations
- ~ Structured logging (pino, winston) for production
- ~ Sentry.io for error tracking
- ? OpenTelemetry for distributed tracing

## Commands

```bash
task fmt                # Format (or `task ts:fmt` in multi-lang projects)
task lint               # Lint (or `task ts:lint` in multi-lang projects)
task test               # Run all tests (unit, integration, fuzzing)
task test:coverage      # Run tests with coverage report (! ≥85%)
task quality            # All quality checks
task check              # Pre-commit (! run: fmt+lint+type+test)
```

**Note**: Single-language projects ! use generic names (`fmt`, `lint`). Multi-language projects ! use namespaced names (`ts:fmt`, `py:fmt`). See [taskfile.md](./taskfile.md#naming-conventions).


### Test Organization
- ~ Place integration tests in `tests/integration/`

## Patterns

**Parameterized Tests**: `test.each([[1,2],[3,4]])('case %s', (a,b) => {...})`
**Setup/Teardown**: `beforeEach(() => {})`, `afterEach(() => {})`, `beforeAll`, `afterAll`
**Mocking**: `vi.fn()`, `vi.mock('module')`, `vi.spyOn(obj, 'method')`
**React Testing**: `@testing-library/react` - `render()`, `screen`, `fireEvent`, `waitFor`
**Async**: `await` in tests, `waitFor(() => expect(...))` for async UI

## tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "moduleResolution": "bundler",
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.spec.ts"]
}
```

## package.json

```json
{
  "type": "module",
  "scripts": {
    "test": "vitest",
    "test:coverage": "vitest --coverage",
    "typecheck": "tsc --noEmit",
    "lint": "eslint src --ext .ts,.tsx",
    "fmt": "prettier --write 'src/**/*.{ts,tsx}'",
    "build": "tsup src/index.ts --format esm,cjs --dts"
  },
  "devDependencies": {
    "@typescript-eslint/eslint-plugin": "^7.0.0",
    "@typescript-eslint/parser": "^7.0.0",
    "@vitest/coverage-v8": "^1.0.0",
    "eslint": "^8.56.0",
    "prettier": "^3.2.0",
    "tsup": "^8.0.0",
    "typescript": "^5.3.0",
    "vitest": "^1.0.0"
  }
}
```

## vitest.config.ts

```typescript
import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    globals: true,
    environment: "node", // or 'jsdom' for React
    coverage: {
      provider: "v8",
      reporter: ["text", "html", "lcov"],
      include: ["src/**/*.ts"],
      exclude: ["src/**/*.spec.ts", "src/**/*.test.ts", "src/index.ts"],
      thresholds: {
        lines: 85,
        functions: 85,
        branches: 85,
        statements: 85,
      },
    },
  },
});
```

## .eslintrc.json

```json
{
  "parser": "@typescript-eslint/parser",
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking"
  ],
  "parserOptions": {
    "project": "./tsconfig.json"
  },
  "rules": {
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/no-unused-vars": [
      "error",
      { "argsIgnorePattern": "^_" }
    ],
    "@typescript-eslint/explicit-function-return-type": [
      "warn",
      {
        "allowExpressions": true
      }
    ]
  }
}
```

## Compliance Checklist

- ! Include TSDoc comments for all exported APIs
- ! Use strict TypeScript; ⊗ use `any`
- ! See [testing.md](../tools/testing.md) for testing requirements
- ! Run `task check` before commit
