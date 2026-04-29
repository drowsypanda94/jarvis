# Run in PowerShell as Administrator when possible.
$ErrorActionPreference = "Stop"

Write-Host "Installing JARVIS prerequisites for Windows..."

function Require-Command($cmd, $url) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
    Write-Host "$cmd is missing. Install it from: $url"
    return $false
  }
  return $true
}

$hasGit = Require-Command git "https://git-scm.com/download/win"
$hasPython = Require-Command python "https://www.python.org/downloads/windows/"
$hasNode = Require-Command node "https://nodejs.org/"
$hasOllama = Require-Command ollama "https://ollama.com/download/windows"
$hasFfmpeg = Require-Command ffmpeg "https://www.gyan.dev/ffmpeg/builds/"

if (-not ($hasGit -and $hasPython -and $hasNode -and $hasOllama -and $hasFfmpeg)) {
  Write-Host "Install the missing tools above, restart PowerShell, then rerun this script."
  exit 1
}

if (-not (Test-Path ".venv")) {
  python -m venv .venv
}
. .\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip setuptools wheel
if (Test-Path "requirements.txt") {
  pip install -r requirements.txt
}

if (Test-Path "ui\jarvis-ui") {
  Push-Location "ui\jarvis-ui"
  npm install
  Pop-Location
}

if (-not (Test-Path ".env")) {
  Copy-Item ".env.example" ".env"
  Write-Host "Created .env. Add your API key before launching."
}

ollama pull llama3.1:8b
ollama pull llama3.2:latest

Write-Host "Windows setup complete. Start with: .\scripts\start_windows.ps1 full"
