# Genesis Installer for Windows
# Installs Genesis technical specification generator for Claude Code

$ErrorActionPreference = "Stop"

# Colors for output
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Blue
Write-Host "║           Genesis Technical Specification Generator           ║" -ForegroundColor Blue
Write-Host "║                      Installation Script                       ║" -ForegroundColor Blue
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Blue
Write-Host ""

# Get directories
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$InstallDir = "$env:USERPROFILE\genesis"
$ClaudeDir = "$env:USERPROFILE\.claude"

Write-Host "[INFO] Script directory: $ScriptDir" -ForegroundColor Cyan
Write-Host "[INFO] Install directory: $InstallDir" -ForegroundColor Cyan
Write-Host ""

# Check for Claude Code
Write-Host "[1/6] Checking for Claude Code CLI..." -ForegroundColor Cyan
try {
    $claudeVersion = & claude --version 2>$null
    Write-Host "✓ Claude Code CLI found" -ForegroundColor Green
} catch {
    Write-Host "! Claude Code CLI not found" -ForegroundColor Yellow
    Write-Host "  Please install Claude Code first: https://claude.ai/code"
    Write-Host "  Then re-run this installer."
    exit 1
}

# Copy files to install directory
Write-Host "[2/6] Installing Genesis to $InstallDir..." -ForegroundColor Cyan
if ($ScriptDir -ne $InstallDir) {
    if (Test-Path $InstallDir) {
        Remove-Item -Recurse -Force $InstallDir
    }
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
    Copy-Item -Recurse -Force "$ScriptDir\*" $InstallDir
    Write-Host "✓ Files copied to $InstallDir" -ForegroundColor Green
} else {
    Write-Host "✓ Already in install directory" -ForegroundColor Green
}

# Create batch file wrapper for orchestrator
Write-Host "[3/6] Creating orchestrator wrapper..." -ForegroundColor Cyan
$batchContent = @"
@echo off
REM Genesis Orchestrator Wrapper for Windows
REM Runs the bash script using WSL or Git Bash

where wsl >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    wsl bash -c "cd '%~dp0' && ./genesis_orchestrator.sh %*"
    exit /b %ERRORLEVEL%
)

where bash >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    bash -c "cd '%~dp0' && ./genesis_orchestrator.sh %*"
    exit /b %ERRORLEVEL%
)

echo ERROR: Neither WSL nor Git Bash found.
echo Please install WSL (Windows Subsystem for Linux) or Git Bash.
echo.
echo To install WSL:
echo   wsl --install
echo.
exit /b 1
"@
Set-Content -Path "$InstallDir\genesis_orchestrator.bat" -Value $batchContent
Write-Host "✓ Created genesis_orchestrator.bat" -ForegroundColor Green

# Create global Claude directories
Write-Host "[4/6] Setting up global Claude Code configuration..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path "$ClaudeDir\commands" -Force | Out-Null
New-Item -ItemType Directory -Path "$ClaudeDir\rules" -Force | Out-Null
Write-Host "✓ Created Claude directories" -ForegroundColor Green

# Copy commands globally
Write-Host "[5/6] Installing global commands..." -ForegroundColor Cyan
$commands = @("genesis", "genesis-quick", "genesis-auto", "genesis-status", "genesis-review")
foreach ($cmd in $commands) {
    $source = "$InstallDir\.claude\commands\$cmd.md"
    $dest = "$ClaudeDir\commands\$cmd.md"
    if (Test-Path $source) {
        Copy-Item -Force $source $dest
        Write-Host "  ✓ Copied $cmd" -ForegroundColor Green
    }
}

# Create/update global CLAUDE.md
Write-Host "[6/6] Configuring global memory..." -ForegroundColor Cyan
$GlobalClaude = "$ClaudeDir\CLAUDE.md"
$GenesisSection = @"

## Genesis Technical Specification Generator

When the user wants to create a technical specification, system design,
PRD, or plan a new project, use the Genesis skill.

**Automatically invoke `/genesis` when the user:**
- Asks to create a technical specification or tech spec
- Asks to design or architect a new system or application
- Asks to write a PRD (Product Requirements Document)
- Wants to plan a new project, feature, or product from scratch
- Says "I want to build [something]" for non-trivial applications

**Genesis location:** ~/genesis/
"@

if (Test-Path $GlobalClaude) {
    $content = Get-Content $GlobalClaude -Raw
    if ($content -match "Genesis Technical Specification Generator") {
        Write-Host "✓ Genesis already in global memory" -ForegroundColor Green
    } else {
        Add-Content -Path $GlobalClaude -Value $GenesisSection
        Write-Host "✓ Added Genesis to existing global memory" -ForegroundColor Green
    }
} else {
    $newContent = @"
# Global Claude Code Memory
$GenesisSection

## My Preferences

- Be concise and technical
- Prefer code examples over lengthy explanations
- Ask clarifying questions before making assumptions on complex tasks
"@
    Set-Content -Path $GlobalClaude -Value $newContent
    Write-Host "✓ Created global memory file" -ForegroundColor Green
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                  Installation Complete!                       ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Genesis has been installed to: $InstallDir"
Write-Host ""
Write-Host "Quick Start:" -ForegroundColor Cyan
Write-Host "  cd ~/genesis"
Write-Host "  claude"
Write-Host '  /genesis "Your project idea"'
Write-Host ""
Write-Host "Or from anywhere, just say:" -ForegroundColor Cyan
Write-Host '  "I want to build a task management app"'
Write-Host "  Claude will automatically invoke Genesis!"
Write-Host ""
Write-Host "Orchestrator commands (requires WSL or Git Bash):" -ForegroundColor Cyan
Write-Host "  .\genesis_orchestrator.bat --init      # Initialize project"
Write-Host "  .\genesis_orchestrator.bat --continue  # Continue from last section"
Write-Host "  .\genesis_orchestrator.bat --status    # Check progress"
Write-Host ""
Write-Host "Note: The orchestrator requires WSL or Git Bash to run bash scripts." -ForegroundColor Yellow
Write-Host "Install WSL with: wsl --install" -ForegroundColor Yellow
Write-Host ""
