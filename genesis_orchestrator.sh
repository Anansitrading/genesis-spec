#!/bin/bash
# Genesis Orchestrator
# Runs each section in a fresh Claude Code session
# Handles state via handoff files

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SECTIONS=(
    "01:Introduction"
    "02:Product_Requirements"
    "03:Technology_Stack"
    "04:Process_Flowcharts"
    "05:Architecture_Design"
    "06:Data_Models_Schema"
    "07:Security_Compliance"
    "08:Testing_Strategy"
    "09:Monitoring_Observability"
    "10:Deployment_Operations"
    "11:Documentation_Knowledge"
    "12:Raindrop_Collections"
)

HANDOFF_DIR="genesis_output/handoffs"
SECTION_DIR="genesis_output/sections"
LOG_DIR="genesis_output/logs"

# Create log directory
mkdir -p "$LOG_DIR"

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_handoff_exists() {
    local section_num=$1
    local handoff_file="${HANDOFF_DIR}/handoff_${section_num}_*.json"

    if ls $handoff_file 1> /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

get_last_completed_section() {
    local last=0
    for i in {12..01}; do
        section_num=$(printf "%02d" $i)
        if check_handoff_exists "$section_num"; then
            last=$i
            break
        fi
    done
    echo $last
}

run_section() {
    local section_num=$1
    local section_name=$2
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local log_file="${LOG_DIR}/section_${section_num}_${timestamp}.log"

    log_info "Running Section ${section_num}: ${section_name}"
    log_info "Log file: ${log_file}"

    # Run Claude Code with the section command
    # Using --print to run non-interactively and capture output
    claude --print "/genesis-section-${section_num}" 2>&1 | tee "$log_file"

    local exit_code=${PIPESTATUS[0]}

    if [ $exit_code -eq 0 ]; then
        if check_handoff_exists "$section_num"; then
            log_success "Section ${section_num} completed successfully"
            return 0
        else
            log_error "Section ${section_num} finished but handoff file not found"
            return 1
        fi
    else
        log_error "Section ${section_num} failed with exit code ${exit_code}"
        return 1
    fi
}

run_init() {
    log_info "Initializing Genesis project..."

    if check_handoff_exists "00"; then
        log_warning "Project already initialized. Use --force to reinitialize."
        return 1
    fi

    claude --print "/genesis-init" 2>&1 | tee "${LOG_DIR}/init_$(date +%Y%m%d_%H%M%S).log"

    if check_handoff_exists "00"; then
        log_success "Project initialized successfully"
        return 0
    else
        log_error "Initialization failed"
        return 1
    fi
}

run_compile() {
    log_info "Compiling final specification..."

    claude --print "/genesis-compile" 2>&1 | tee "${LOG_DIR}/compile_$(date +%Y%m%d_%H%M%S).log"

    if [ -f "genesis_output/final/technical_specification.md" ]; then
        log_success "Compilation complete!"
        log_info "Output: genesis_output/final/technical_specification.md"
        return 0
    else
        log_error "Compilation failed"
        return 1
    fi
}

show_status() {
    echo ""
    echo "========================================="
    echo "         Genesis Project Status"
    echo "========================================="
    echo ""

    # Check initialization
    if check_handoff_exists "00"; then
        echo -e "${GREEN}✓${NC} Initialization complete"
    else
        echo -e "${RED}✗${NC} Not initialized (run: $0 --init)"
        return
    fi

    # Check each section
    for section in "${SECTIONS[@]}"; do
        IFS=':' read -r num name <<< "$section"
        if check_handoff_exists "$num"; then
            echo -e "${GREEN}✓${NC} Section ${num}: ${name//_/ }"
        else
            echo -e "${YELLOW}○${NC} Section ${num}: ${name//_/ } (pending)"
        fi
    done

    # Check compilation
    if [ -f "genesis_output/final/technical_specification.md" ]; then
        echo -e "${GREEN}✓${NC} Final specification compiled"
    else
        echo -e "${YELLOW}○${NC} Final compilation pending"
    fi

    echo ""
    echo "========================================="

    local last=$(get_last_completed_section)
    if [ $last -eq 0 ]; then
        echo "Next: Run initialization with --init"
    elif [ $last -lt 12 ]; then
        local next=$((last + 1))
        local next_formatted=$(printf "%02d" $next)
        echo "Next: Run section ${next_formatted}"
    else
        echo "Next: Run --compile to generate final specification"
    fi
    echo ""
}

run_auto() {
    local start_section=$1
    local pause_between=${2:-true}

    log_info "Starting automatic Genesis run from section ${start_section}"

    # Check initialization
    if ! check_handoff_exists "00"; then
        log_info "Project not initialized. Running initialization..."
        if ! run_init; then
            log_error "Initialization failed. Aborting."
            exit 1
        fi
    fi

    # Run each section
    for section in "${SECTIONS[@]}"; do
        IFS=':' read -r num name <<< "$section"

        # Skip completed sections
        if [ "$num" -lt "$start_section" ]; then
            log_info "Skipping Section ${num} (already complete)"
            continue
        fi

        # Check prerequisite
        local prev_num=$(printf "%02d" $((10#$num - 1)))
        if [ "$num" != "01" ] && ! check_handoff_exists "$prev_num"; then
            log_error "Cannot run Section ${num}: Section ${prev_num} not complete"
            exit 1
        fi

        # Run the section
        if ! run_section "$num" "$name"; then
            log_error "Section ${num} failed. Fix issues and run: $0 --continue"
            exit 1
        fi

        # Pause for review if requested
        if [ "$pause_between" = true ] && [ "$num" != "12" ]; then
            echo ""
            log_info "Section ${num} complete. Review the output before continuing."
            read -p "Press Enter to continue to next section (or Ctrl+C to stop)..."
            echo ""
        fi
    done

    log_success "All sections complete!"

    # Run compilation
    log_info "Running final compilation..."
    if run_compile; then
        log_success "Genesis specification generation complete!"
        log_info "Final output: genesis_output/final/technical_specification.md"
    else
        log_error "Compilation failed"
        exit 1
    fi
}

# Main script
case "${1:-}" in
    --init)
        run_init
        ;;
    --section)
        if [ -z "${2:-}" ]; then
            log_error "Please specify section number: $0 --section 01"
            exit 1
        fi
        section_num=$(printf "%02d" $2)
        section_name=""
        for section in "${SECTIONS[@]}"; do
            IFS=':' read -r num name <<< "$section"
            if [ "$num" = "$section_num" ]; then
                section_name="$name"
                break
            fi
        done
        if [ -z "$section_name" ]; then
            log_error "Invalid section number: $2"
            exit 1
        fi
        run_section "$section_num" "$section_name"
        ;;
    --continue)
        last=$(get_last_completed_section)
        if [ $last -eq 0 ]; then
            log_info "No sections complete. Starting from the beginning."
            run_auto "01" true
        elif [ $last -ge 12 ]; then
            log_info "All sections complete. Running compilation."
            run_compile
        else
            next=$((last + 1))
            next_formatted=$(printf "%02d" $next)
            log_info "Continuing from section ${next_formatted}"
            run_auto "$next_formatted" true
        fi
        ;;
    --auto)
        run_auto "01" false
        ;;
    --compile)
        run_compile
        ;;
    --status)
        show_status
        ;;
    --help|"")
        echo "Genesis Orchestrator - Technical Specification Generator"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  --init           Initialize a new Genesis project"
        echo "  --section N      Run a specific section (01-12)"
        echo "  --continue       Continue from last completed section"
        echo "  --auto           Run all sections automatically (no pauses)"
        echo "  --compile        Compile final specification"
        echo "  --status         Show project status"
        echo "  --help           Show this help message"
        echo ""
        echo "Examples:"
        echo "  $0 --init                # Start a new project"
        echo "  $0 --continue            # Continue where you left off"
        echo "  $0 --section 03          # Run just section 03"
        echo "  $0 --status              # Check progress"
        echo ""
        ;;
    *)
        log_error "Unknown command: $1"
        echo "Run '$0 --help' for usage information"
        exit 1
        ;;
esac
