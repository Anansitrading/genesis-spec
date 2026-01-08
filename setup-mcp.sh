#!/bin/bash
# Genesis MCP Setup Script
# Configures required MCP servers for full Genesis functionality

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║              Genesis MCP Server Setup                         ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check for Claude Code
echo -e "${BLUE}[1/6]${NC} Checking for Claude Code CLI..."
if command -v claude &> /dev/null; then
    echo -e "${GREEN}✓${NC} Claude Code CLI found"
else
    echo -e "${RED}✗${NC} Claude Code CLI not found"
    echo "  Please install Claude Code first: https://claude.ai/code"
    exit 1
fi

# Check for Node.js/npx
echo -e "${BLUE}[2/6]${NC} Checking for Node.js..."
if command -v npx &> /dev/null; then
    echo -e "${GREEN}✓${NC} Node.js/npx found"
else
    echo -e "${RED}✗${NC} Node.js not found"
    echo "  Please install Node.js: https://nodejs.org/"
    exit 1
fi

# Check for required environment variables
echo -e "${BLUE}[3/6]${NC} Checking environment variables..."

MISSING_VARS=()

if [ -z "$PERPLEXITY_API_KEY" ]; then
    MISSING_VARS+=("PERPLEXITY_API_KEY")
fi

if [ -z "$FIRECRAWL_API_KEY" ]; then
    MISSING_VARS+=("FIRECRAWL_API_KEY")
fi

if [ -z "$RAINDROP_API_KEY" ]; then
    MISSING_VARS+=("RAINDROP_API_KEY")
fi

if [ -z "$EXA_API_KEY" ]; then
    MISSING_VARS+=("EXA_API_KEY")
fi

if [ ${#MISSING_VARS[@]} -gt 0 ]; then
    echo -e "${YELLOW}!${NC} Missing environment variables:"
    for var in "${MISSING_VARS[@]}"; do
        echo "    - $var"
    done
    echo ""
    echo "Please set these before running Genesis:"
    echo ""
    echo "  export PERPLEXITY_API_KEY=\"your-key\"   # https://www.perplexity.ai/settings/api"
    echo "  export FIRECRAWL_API_KEY=\"your-key\"    # https://firecrawl.dev/"
    echo "  export RAINDROP_API_KEY=\"your-key\"     # https://app.raindrop.io/settings/integrations"
    echo "  export EXA_API_KEY=\"your-key\"          # https://exa.ai/"
    echo ""
    echo "Add these to your ~/.bashrc or ~/.zshrc for persistence."
    echo ""
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo -e "${GREEN}✓${NC} All environment variables set"
fi

# Add MCP servers
echo -e "${BLUE}[4/6]${NC} Adding MCP servers to Claude Code..."

echo "  Adding Perplexity..."
claude mcp add perplexity-ask -- npx -y server-perplexity-ask 2>/dev/null || echo "    (may already exist)"

echo "  Adding Firecrawl..."
claude mcp add firecrawl -- npx -y firecrawl-mcp 2>/dev/null || echo "    (may already exist)"

echo "  Adding Raindrop..."
claude mcp add raindrop -- npx -y @nicholasrq/raindrop-mcp 2>/dev/null || echo "    (may already exist)"

echo "  Adding Exa..."
claude mcp add exa -- npx -y @anthropic/exa-mcp 2>/dev/null || echo "    (may already exist)"

echo "  Adding Context7..."
claude mcp add context7 -- npx -y @anthropic/context7-mcp 2>/dev/null || echo "    (may already exist)"

echo -e "${GREEN}✓${NC} MCP servers configured"

# Verify MCP configuration
echo -e "${BLUE}[5/6]${NC} Verifying MCP configuration..."
claude mcp list 2>/dev/null || echo "  Run 'claude mcp list' manually to verify"

# Complete
echo -e "${BLUE}[6/6]${NC} Setup complete!"

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                  MCP Setup Complete!                          ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "MCP servers installed:"
echo "  ✓ perplexity-ask  - Web research"
echo "  ✓ firecrawl       - Web scraping"
echo "  ✓ raindrop        - Bookmark collections"
echo "  ✓ exa             - Code search"
echo "  ✓ context7        - Library documentation"
echo ""
echo -e "${YELLOW}IMPORTANT:${NC} Restart Claude Code for changes to take effect!"
echo ""
echo "To verify setup, run:"
echo "  claude"
echo "  /mcp"
echo ""
echo "Then start Genesis:"
echo "  /genesis \"Your project idea\""
echo ""
