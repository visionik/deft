# TypeScript Standards

**⚠️ Generic: [warp.md](./warp.md) | Project: [project.md](./project.md)**

**Stack**: TypeScript 5.0+, Vitest/Jest; Web: React 18+/Next.js; CLI: commander; Build: Vite/tsup

## Standards

**Docs**: TSDoc comments for all exported APIs
**Test**: Vitest (or Jest)+coverage, ≥75% overall+per-module, integration for critical paths, exclude main entry points
**Coverage**: Count src/*, exclude entry/scripts/generated
**Style**: ESLint+Prettier, functional > classes where practical
**Types**: Strict mode, no `any`, prefer `unknown` for type-safe unknowns

## Commands

```bash
task ts:install|test|test:coverage|ts:fmt|ts:lint|ts:type|quality|check
npm test -- path/to/test.spec.ts          # Specific test file
npm run test:coverage                     # Coverage report
open coverage/index.html                  # View coverage
```

## Workflow

```bash
task ts:fmt && task ts:lint && task ts:type && task test && task check
```

**Tests**: `*.spec.ts` or `*.test.ts`, ≥75%/module, integration in `tests/integration/`

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
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    globals: true,
    environment: 'node', // or 'jsdom' for React
    coverage: {
      provider: 'v8',
      reporter: ['text', 'html', 'lcov'],
      include: ['src/**/*.ts'],
      exclude: ['src/**/*.spec.ts', 'src/**/*.test.ts', 'src/index.ts'],
      thresholds: {
        lines: 75,
        functions: 75,
        branches: 75,
        statements: 75
      }
    }
  }
})
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
    "@typescript-eslint/no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
    "@typescript-eslint/explicit-function-return-type": ["warn", {
      "allowExpressions": true
    }]
  }
}
```

## Compliance

- TSDoc for all exported APIs
- Strict TypeScript, no `any`
- Vitest, ≥75% coverage
- `task check` before commit
