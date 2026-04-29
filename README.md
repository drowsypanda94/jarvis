# JARVIS

Advanced AI assistant framework with voice interaction, browser automation, local + cloud LLM routing, and multi-agent orchestration.

## What This Repo Contains

This repo is being prepared as a production-ready JARVIS setup package with:

- cross-platform setup guidance
- safe environment variable handling
- Docker deployment files
- GitHub Actions CI
- security checklist
- troubleshooting scripts
- Codex/GitHub task plan

## Quick Start

1. Copy `.env.example` to `.env`.
2. Add your real API keys to `.env`.
3. Install prerequisites for your operating system.
4. Run the setup script for your platform.
5. Start JARVIS.

## Required Tools

- Python 3.11+
- Node.js 18+
- Git
- Ollama
- FFmpeg
- Chrome

## Security Warning

Never commit `.env`, API keys, tokens, private data, browser profiles, or local memory databases.

Review `docs/SECURITY.md` before using browser automation, tunnels, shell tools, or remote/mobile access.
