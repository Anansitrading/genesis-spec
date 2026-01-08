#!/bin/bash
# Genesis Installer for Linux/macOS
# Installs Genesis technical specification generator for Claude Code

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           Genesis Technical Specification Generator           ║"
echo "║                      Installation Script                       ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/genesis"
CLAUDE_DIR="$HOME/.claude"

echo -e "${BLUE}[INFO]${NC} Script directory: $SCRIPT_DIR"
echo -e "${BLUE}[INFO]${NC} Install directory: $INSTALL_DIR"
echo ""

# Check for Claude Code
echo -e "${BLUE}[1/6]${NC} Checking for Claude Code CLI..."
if command -v claude &> /dev/null; then
    echo -e "${GREEN}✓${NC} Claude Code CLI found"
else
    echo -e "${YELLOW}!${NC} Claude Code CLI not found"
    echo "  Please install Claude Code first: https://claude.ai/code"
    echo "  Then re-run this installer."
    exit 1
fi

# Copy files to install directory
echo -e "${BLUE}[2/6]${NC} Installing Genesis to $INSTALL_DIR..."
if [ "$SCRIPT_DIR" != "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
    cp -r "$SCRIPT_DIR"/* "$INSTALL_DIR/" 2>/dev/null || true
    cp -r "$SCRIPT_DIR"/.claude "$INSTALL_DIR/" 2>/dev/null || true
    echo -e "${GREEN}✓${NC} Files copied to $INSTALL_DIR"
else
    echo -e "${GREEN}✓${NC} Already in install directory"
fi

# Make orchestrator executable
echo -e "${BLUE}[3/6]${NC} Setting up orchestrator script..."
chmod +x "$INSTALL_DIR/genesis_orchestrator.sh"
echo -e "${GREEN}✓${NC} Orchestrator script is executable"

# Create global Claude directories
echo -e "${BLUE}[4/6]${NC} Setting up global Claude Code configuration..."
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/rules"

# Copy/symlink commands globally
echo -e "${BLUE}[5/6]${NC} Installing global commands..."
for cmd in genesis genesis-quick genesis-auto genesis-status genesis-review; do
    if [ -f "$INSTALL_DIR/.claude/commands/${cmd}.md" ]; then
        ln -sf "$INSTALL_DIR/.claude/commands/${cmd}.md" "$CLAUDE_DIR/commands/${cmd}.md"
        echo -e "  ${GREEN}✓${NC} Linked $cmd"
    fi
done

# Create/update global CLAUDE.md
echo -e "${BLUE}[6/6]${NC} Configuring global memory..."
GLOBAL_CLAUDE="$CLAUDE_DIR/CLAUDE.md"

if [ -f "$GLOBAL_CLAUDE" ]; then
    # Check if Genesis section already exists
    if grep -q "Genesis Technical Specification Generator" "$GLOBAL_CLAUDE"; then
        echo -e "${GREEN}✓${NC} Genesis already in global memory"
    else
        # Append Genesis section
        cat >> "$GLOBAL_CLAUDE" << 'EOF'

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
EOF
        echo -e "${GREEN}✓${NC} Added Genesis to existing global memory"
    fi
else
    # Create new global CLAUDE.md
    cat > "$GLOBAL_CLAUDE" << 'EOF'
# Global Claude Code Memory

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

## My Preferences

- Be concise and technical
- Prefer code examples over lengthy explanations
- Ask clarifying questions before making assumptions on complex tasks
EOF
    echo -e "${GREEN}✓${NC} Created global memory file"
fi

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                  Installation Complete!                       ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Genesis has been installed to: $INSTALL_DIR"
echo ""
echo -e "${BLUE}Quick Start:${NC}"
echo "  cd ~/genesis"
echo "  claude"
echo "  /genesis \"Your project idea\""
echo ""
echo -e "${BLUE}Or from anywhere, just say:${NC}"
echo "  \"I want to build a task management app\""
echo "  Claude will automatically invoke Genesis!"
echo ""
echo -e "${BLUE}Orchestrator commands:${NC}"
echo "  ./genesis_orchestrator.sh --init      # Initialize project"
echo "  ./genesis_orchestrator.sh --continue  # Continue from last section"
echo "  ./genesis_orchestrator.sh --status    # Check progress"
echo ""
