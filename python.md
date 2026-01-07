# Python Standards

**⚠️ [warp.md](./warp.md) | [project.md](./project.md)**

**Stack**: Python 3.11+, pytest; Web: Flask/FastAPI; CLI: typer[all]; TUI: textual[dev]

## Standards

**Docs**: PEP 257 docstrings all public APIs
**Test**: pytest+pytest-cov+pytest-mock, ≥75% overall+per-module, integration for critical paths, exclude `__main__`/entry points
**Coverage**: Count src/*, exclude entry/scripts/generated
**Style**: PEP 8 via ruff+black+isort
**Types**: PEP 484 all functions/methods, mypy strict

## Commands

```bash
task py:install|test|test:coverage|py:fmt|py:lint|py:type|quality|check
pytest --cov=src --cov-report=term-missing|-v tests/X.py|-k name
open htmlcov/index.html
```

## Workflow

```bash
task py:fmt && task py:lint && task py:type && task test && task check
```

**Tests**: `test_*.py`, ≥75%/module, integration in `tests/integration/`

## Patterns

**Parametrize**: `@pytest.mark.parametrize("a,b",[(1,2)])`, add `ids=[]` for names
**Fixtures**: `@pytest.fixture; yield val; cleanup()` for setup/teardown
**HTTP**: Flask: `app.test_client()`; FastAPI: `TestClient(app)`
**Mock**: `mocker.patch("mod.X")` or `@patch("mod.X")`
**Class**: `@pytest.fixture(autouse=True)` in class for shared setup

## pyproject.toml

```toml
[project]
requires-python=">=3.11"
dependencies=["flask>=3.0.0"]  # or fastapi/typer[all]/textual[dev]
[project.optional-dependencies]
dev=["pytest>=7.4","pytest-cov>=4.1","pytest-mock>=3.12","black>=23","isort>=5.12","ruff>=0.1","mypy>=1.7"]
[tool.pytest.ini_options]
testpaths=["tests"]
python_files=["test_*.py","*_test.py"]
addopts="--cov=src --cov-report=html --cov-report=term-missing"
[tool.coverage.run]
omit=["*/tests/*","*/venv/*","*/.venv/*"]
[tool.coverage.report]
fail_under=75
[tool.black]
line-length=100
[tool.isort]
profile="black"
line_length=100
[tool.ruff]
line-length=100
select=["E","F","W","I","N","UP","B","A","C4","DTZ","T10","PIE","PT","RET","SIM"]
[tool.mypy]
python_version="3.11"
warn_return_any=true
warn_unused_configs=true
disallow_untyped_defs=true
```

## Compliance

PEP 257+484, pytest, ≥75% coverage, `task check` before commit
