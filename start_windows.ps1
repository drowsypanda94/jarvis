#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "Installing JARVIS prerequisites for Ubuntu/Debian Linux..."

sudo apt-get update
sudo apt-get install -y git curl build-essential python3.11 python3.11-venv python3-pip ffmpeg portaudio19-dev nodejs npm

if ! command -v ollama >/dev/null 2>&1; then
  curl -fsSL https://ollama.com/install.sh | sh
fi

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

ollama pull llama3.1:8b || true
ollama pull llama3.2:latest || true

echo "Linux setup complete. Start with: ./start.sh full or ./start.sh server"
