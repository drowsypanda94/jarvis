param(
  [string]$Mode = "full"
)
$ErrorActionPreference = "Stop"

if (-not (Test-Path ".env")) {
  Write-Host "Missing .env. Copy .env.example to .env and add your API key."
  exit 1
}

if (Test-Path ".venv\Scripts\Activate.ps1") {
  . .\.venv\Scripts\Activate.ps1
}

Start-Process -WindowStyle Minimized powershell -ArgumentList "ollama serve"
Start-Sleep -Seconds 2

switch ($Mode) {
  "text" { python -m jarvis.main text }
  "voice" { python -m jarvis.main voice }
  "server" { python -m jarvis.main server }
  "full" { python -m jarvis.main full }
  default { Write-Host "Unknown mode. Use text, voice, server, or full."; exit 1 }
}
