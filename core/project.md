# Voxio Bot Project Guidelines

Legend (from RFC2119): !=MUST, ~=SHOULD, ≉=SHOULD NOT, ⊗=MUST NOT, ?=MAY.

**⚠️ See also**: [main.md](../main.md) | [python.md](../languages/python.md)

## Project Configuration

**Tech Stack**: Python 3.13, Pipecat, FastAPI, WebRTC

**Project Type**: Real-time Voice AI Assistant

**Purpose**: Voice interface for Clawdbot with bidirectional audio, TTS caching, and tool handoff

**Repository**: Private (voxio-bot)

**Branch Strategy**: `beta` (active development), `main` (stable)

## 📋 Workflow

```bash
uv sync              # Install dependencies
uv run python bot.py # Run bot directly
uv run pytest        # Run tests
task check           # Pre-commit checks (if Taskfile exists)
```

## 📁 Directory Structure

- `bot.py` - Main Pipecat bot entry point
- `run_auth.py` - Server with auth + /speak endpoint
- `config.toml` - Configuration file
- `cached_tts.py` - TTS caching wrapper
- `filler_cache.py` - Filler pre-caching system
- `tts_cache.py` - Unified cache implementation
- `sounds/` - Ambient sound files for handoff
- `static/` - Web client assets
- `tests/` - Test suite

## Architecture

**Core Components:**
- **STT**: MLX Whisper (local) or OpenAI Whisper
- **LLM**: Anthropic Claude (quick responses + handoff)
- **TTS**: ElevenLabs with transparent caching
- **Transport**: WebRTC via Pipecat
- **Integration**: Clawdbot Gateway for tools/memory

**Key Flows:**
1. Voice → STT → Claude → TTS → Voice (fast path)
2. Voice → STT → Claude → Handoff → Clawdbot → /speak → Voice (tool path)

## Standards

**Code Quality:**
- ! Type hints on all public functions
- ! Docstrings on modules and public classes
- ~ ≥85% test coverage on core modules (cached_tts, filler_cache, tts_cache)
- ~ Keep files <500 lines

**Audio/Realtime:**
- ! Never block the audio pipeline
- ! Use async/await for all I/O
- ~ Stream audio immediately, cache in background
- ~ Pre-cache common responses (fillers, greetings)

**Configuration:**
- ! All config via `config.toml` (not hardcoded)
- ! Secrets via `.env` (never committed)
- ~ Sensible defaults for all optional settings

**Caching:**
- ! Cache key = MD5(text + voice_id + model)
- ! Stream-first: play audio while caching
- ~ Auto-cleanup old cache files

**Clawdbot Integration:**
- ! Handoff tool for complex/tool-requiring tasks
- ! /speak endpoint for Clawdbot → Voice responses
- ~ Play ambient sounds during handoff wait

## Dependencies

**Core:**
- pipecat-ai - Real-time AI framework
- anthropic - Claude API
- elevenlabs - TTS API
- mlx-whisper - Local STT (Apple Silicon)

**Web:**
- fastapi - HTTP server
- uvicorn - ASGI server

**Audio:**
- soundfile - Audio file handling
- numpy - Audio processing

## Testing

```bash
uv run pytest                    # All tests
uv run pytest tests/test_cache.py  # Specific test
uv run pytest --cov=. --cov-report=html  # Coverage
```

**Test Guidelines:**
- ! Mock external APIs (ElevenLabs, Anthropic)
- ! Use time-warping for cache expiry tests
- ~ Test happy path + error cases
- ~ Integration tests for /speak endpoint

## Deployment

**Local Development:**
```bash
uv run python run_auth.py --port 8086
```

**Production:**
- Run behind Cloudflare Tunnel
- Use systemd/launchd for process management
- Monitor via logs + /sessions endpoint
