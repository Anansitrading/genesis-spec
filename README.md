# Genesis: AI-Powered Technical Specification Generator

Genesis is a multi-agent workflow for Claude Code that generates comprehensive, professional technical specifications through structured intake and parallel research.

## Features

- **Structured Intake Process**: 6-phase questionnaire ensures non-generic, highly specific outputs
- **Multi-Agent Architecture**: Parallel research subagents for web search, codebase analysis, and documentation
- **12-Section Specifications**: Covers everything from requirements to deployment
- **Session Management**: Fresh context windows per section via orchestrator script
- **Quality Enforcement**: Pushes for specifics, validates consistency, documents everything

## Quick Start

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/genesis.git
cd genesis

# Run the installer for your OS
./install.sh        # Linux/macOS
# or
./install.ps1       # Windows PowerShell

# Start Claude Code and use Genesis
claude
/genesis "Build a task management application"
```

## Installation

### Prerequisites

- [Claude Code CLI](https://claude.ai/code) installed and authenticated
- Bash (Linux/macOS) or PowerShell (Windows)

### Linux / macOS

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/genesis.git
cd genesis

# Run installer
chmod +x install.sh
./install.sh
```

### Windows

```powershell
# Clone repository
git clone https://github.com/YOUR_USERNAME/genesis.git
cd genesis

# Run installer (PowerShell as Administrator)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\install.ps1
```

### Manual Installation

If you prefer manual setup:

1. **Copy project files:**
   ```bash
   # Linux/macOS
   cp -r genesis ~/genesis

   # Windows
   xcopy /E /I genesis %USERPROFILE%\genesis
   ```

2. **Create global Claude Code memory:**
   ```bash
   # Linux/macOS
   mkdir -p ~/.claude/commands ~/.claude/rules
   cp genesis/.claude/commands/genesis*.md ~/.claude/commands/

   # Windows
   mkdir %USERPROFILE%\.claude\commands
   copy genesis\.claude\commands\genesis*.md %USERPROFILE%\.claude\commands\
   ```

3. **Add to global CLAUDE.md:**

   Create or edit `~/.claude/CLAUDE.md` (or `%USERPROFILE%\.claude\CLAUDE.md` on Windows):

   ```markdown
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
   ```

## Usage

### Full Structured Intake

```bash
cd ~/genesis
claude

# Start with a prompt
/genesis "AI-powered code review tool for enterprise teams"

# Or with a context file
/genesis requirements.md additional-notes.txt
```

### Quick Start (with existing build prompt)

```bash
/genesis-quick my-detailed-spec.md
```

### Orchestrator Commands

```bash
# Initialize new project
./genesis_orchestrator.sh --init

# Continue from last section
./genesis_orchestrator.sh --continue

# Run fully automated
./genesis_orchestrator.sh --auto

# Check status
./genesis_orchestrator.sh --status

# Run specific section
./genesis_orchestrator.sh --section 03

# Compile final specification
./genesis_orchestrator.sh --compile
```

### Individual Section Commands

```bash
/genesis-init           # Initialize project
/genesis-section-01     # Introduction
/genesis-section-02     # Product Requirements
/genesis-section-03     # Technology Stack
/genesis-section-04     # Process Flowcharts
/genesis-section-05     # Architecture & Design
/genesis-section-06     # Data Models & Schema
/genesis-section-07     # Security & Compliance
/genesis-section-08     # Testing Strategy
/genesis-section-09     # Monitoring & Observability
/genesis-section-10     # Deployment & Operations
/genesis-section-11     # Documentation & Knowledge
/genesis-section-12     # Raindrop.io Collections
/genesis-compile        # Compile final spec
/genesis-status         # Check progress
/genesis-review 01      # Review a section
```

## Directory Structure

```
genesis/
├── .claude/
│   ├── agents/                    # Subagent definitions
│   │   ├── genesis-researcher.md
│   │   ├── genesis-perplexity.md
│   │   ├── genesis-codebase-explorer.md
│   │   └── genesis-documentation.md
│   ├── commands/                  # Slash commands
│   │   ├── genesis.md             # Main intake skill
│   │   ├── genesis-init.md
│   │   ├── genesis-section-01.md ... genesis-section-12.md
│   │   ├── genesis-compile.md
│   │   ├── genesis-status.md
│   │   ├── genesis-quick.md
│   │   ├── genesis-review.md
│   │   └── genesis-auto.md
│   ├── rules/
│   │   └── genesis-triggers.md    # Auto-trigger rules
│   └── settings.local.json
├── genesis_sources/
│   ├── section_guides/            # Detailed section instructions
│   └── reference_materials/       # User-provided context
├── genesis_output/
│   ├── sections/                  # Generated sections
│   ├── handoffs/                  # State between sessions
│   ├── research/                  # Subagent outputs
│   ├── logs/                      # Orchestrator logs
│   └── final/                     # Compiled specification
├── genesis_orchestrator.sh        # Automation script
├── install.sh                     # Linux/macOS installer
├── install.ps1                    # Windows installer
├── CLAUDE.md                      # Project memory
└── README.md
```

## How It Works

### Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     /genesis skill                          │
│  (Structured 6-phase intake → Creates handoff files)        │
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                   genesis_orchestrator.sh                    │
│  (Runs each section in fresh Claude session)                │
└─────────────────────────────┬───────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
┌───────────────┐     ┌───────────────┐     ┌───────────────┐
│ Section 01    │     │ Section 02    │     │ Section N     │
│ Introduction  │────▶│ Requirements  │────▶│    ...        │
└───────┬───────┘     └───────┬───────┘     └───────┬───────┘
        │                     │                     │
        ▼                     ▼                     ▼
   ┌─────────┐           ┌─────────┐           ┌─────────┐
   │Subagents│           │Subagents│           │Subagents│
   │(parallel│           │(parallel│           │(parallel│
   │research)│           │research)│           │research)│
   └─────────┘           └─────────┘           └─────────┘
```

### Subagents

| Agent | Model | Purpose |
|-------|-------|---------|
| `genesis-researcher` | Opus | Deep technical research |
| `genesis-perplexity` | Sonnet | Web search & documentation |
| `genesis-codebase-explorer` | Haiku | Read-only code analysis |
| `genesis-documentation` | Sonnet | Documentation specialist |

### Output Sections

1. **Introduction** - Executive summary, system overview, success criteria
2. **Product Requirements** - Feature catalog, functional requirements, traceability
3. **Technology Stack** - Languages, frameworks, infrastructure decisions
4. **Process Flowcharts** - Workflows, validation rules, error handling
5. **Architecture & Design** - System architecture, design patterns, API design
6. **Data Models & Schema** - ER diagrams, TypeScript types, validation
7. **Security & Compliance** - Auth, encryption, GDPR/compliance
8. **Testing Strategy** - Testing pyramid, automation, quality gates
9. **Monitoring & Observability** - Logging, metrics, alerting
10. **Deployment & Operations** - CI/CD, infrastructure, runbooks
11. **Documentation & Knowledge** - Standards, ADRs, onboarding
12. **Raindrop.io Collections** - Curated documentation bookmarks

## Customization

### Adding Custom Section Guides

Place your own section guides in `genesis_sources/section_guides/` following the naming convention:
```
Genesis_Section_XX_Name.md
```

### Modifying Subagents

Edit files in `.claude/agents/` to customize research behavior, tools available, or model selection.

### Adding Trigger Rules

Edit `.claude/rules/genesis-triggers.md` to add new phrases that auto-invoke Genesis.

## Troubleshooting

### "Command not found" errors

Ensure you've run the installer and are in the genesis directory:
```bash
cd ~/genesis
./genesis_orchestrator.sh --status
```

### Sections not generating

Check that handoff files exist:
```bash
ls genesis_output/handoffs/
```

### Fresh context issues

Run each section in a new Claude session:
```bash
claude --print "/genesis-section-01"
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT License - See LICENSE file for details.

## Credits

Created with Claude Code by Anthropic.
