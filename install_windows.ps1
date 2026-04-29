#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "Installing JARVIS prerequisites for macOS..."

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it from https://brew.sh then rerun this script."
  exit 1
fi

brew update
brew install python@3.11 node ffmpeg portaudio ollama cloudflared || true

if [ ! -d ".venv" ]; then
  python3.11 -m venv .venv
fi
source .venv/bin/activate
python -m pip install --upgrade pip setuptools wheel
if [ -f requirements.txt ]; then
  pip install -r requirements.txt
fi

if [ -d "ui/jarvis-ui" ]; then
  cd ui/jarvis-ui
  npm install
  cd "$PROJECT_ROOT"
fi

if [ ! -f ".env" ]; then
  cp .env.example .env
  echo "Created .env. Add your API key before launching."
fi

ollama serve >/tmp/jarvis-ollama.log 2>&1 & disown || true
sleep 2
ollama pull llama3.1:8b || true
ollama pull llama3.2:latest || true

echo "macOS setup complete. Start with: ./start.sh full"
