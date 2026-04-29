#!/usr/bin/env bash
set -u

echo "JARVIS Doctor Check"
echo "==================="

check() {
  name="$1"; cmd="$2"
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "[OK] $name"
  else
    echo "[MISSING] $name"
  fi
}

check "Git" git
check "Python" python3
check "Node" node
check "FFmpeg" ffmpeg
check "Ollama" ollama

if [ -f .env ]; then
  echo "[OK] .env found"
else
  echo "[WARN] .env missing"
fi
