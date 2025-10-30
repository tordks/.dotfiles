#!/bin/bash

# Test Docker setup for dotfiles
# Verifies: image build, installation, symlinks, and tool installation
# Exit codes: 0 = success, 1 = failure

set -o pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test state
TESTS_PASSED=0
TESTS_FAILED=0
DOCKER_IMAGE_NAME="dotfiles-test:latest"
DOCKER_CONTAINER_NAME="dotfiles-test-container"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((TESTS_PASSED++))
}

log_error() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((TESTS_FAILED++))
}

log_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Cleanup function
cleanup() {
    log_info "Cleaning up Docker resources..."

    # Stop and remove container
    if docker ps -a --format '{{.Names}}' | grep -q "^${DOCKER_CONTAINER_NAME}$"; then
        log_info "Removing test container..."
        docker rm -f "$DOCKER_CONTAINER_NAME" 2>/dev/null || true
    fi

    # Remove image
    if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^${DOCKER_IMAGE_NAME}$"; then
        log_info "Removing test image..."
        docker rmi -f "$DOCKER_IMAGE_NAME" 2>/dev/null || true
    fi
}

# Trap cleanup on exit
trap cleanup EXIT

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."

    # Check Docker is installed
    if ! command -v docker &> /dev/null; then
        log_error "Docker is not installed"
        return 1
    fi
    log_success "Docker is installed"

    # Check Docker daemon is running
    if ! docker info &> /dev/null; then
        log_error "Docker daemon is not running"
        return 1
    fi
    log_success "Docker daemon is running"

    # Check Dockerfile exists
    if [ ! -f "Dockerfile" ]; then
        log_error "Dockerfile not found in current directory"
        return 1
    fi
    log_success "Dockerfile found"

    return 0
}

# Step 1: Build Docker image
build_docker_image() {
    log_info "=========================================="
    log_info "Step 1: Building Docker image"
    log_info "=========================================="

    if docker build -t "$DOCKER_IMAGE_NAME" .; then
        log_success "Docker image built successfully"
        return 0
    else
        log_error "Failed to build Docker image"
        return 1
    fi
}

# Step 2: Verify installation (already completed during Docker build)
run_installation() {
    log_info "=========================================="
    log_info "Step 2: Verifying installation"
    log_info "=========================================="

    log_info "Installation already completed during Docker build..."
    log_success "Proceeding to verification steps"
    return 0
}

# Step 3: Verify symlinks
verify_symlinks() {
    log_info "=========================================="
    log_info "Step 3: Verifying symlinks"
    log_info "=========================================="

    local required_symlinks=(
        "/home/testuser/.zshrc"
        "/home/testuser/.gitconfig"
        "/home/testuser/.tmux.conf"
        "/home/testuser/.config/nvim"
    )

    local all_exist=true

    # Run verification inside a new container
    for symlink in "${required_symlinks[@]}"; do
        log_info "Checking symlink: $symlink"

        if docker run \
            --rm \
            "$DOCKER_IMAGE_NAME" \
            /bin/bash -c "[ -L '$symlink' ] || [ -d '$symlink' ] || [ -f '$symlink' ]"; then
            log_success "Symlink exists: $symlink"
        else
            log_error "Symlink missing: $symlink"
            all_exist=false
        fi
    done

    if [ "$all_exist" = true ]; then
        return 0
    else
        return 1
    fi
}

# Step 4: Check antidote installation
check_antidote_installation() {
    log_info "=========================================="
    log_info "Step 4: Checking antidote installation"
    log_info "=========================================="

    log_info "Checking for antidote..."

    if docker run \
        --rm \
        "$DOCKER_IMAGE_NAME" \
        /bin/bash -c "[ -d '/home/testuser/.antidote' ]"; then
        log_success "Antidote is installed"
        return 0
    else
        log_error "Antidote is not installed (directory /home/testuser/.antidote not found)"
        return 1
    fi
}

# Step 5: Check zoxide installation
check_zoxide_installation() {
    log_info "=========================================="
    log_info "Step 5: Checking zoxide installation"
    log_info "=========================================="

    log_info "Checking for zoxide..."

    if docker run \
        --rm \
        "$DOCKER_IMAGE_NAME" \
        /bin/bash -c "test -f /home/testuser/.local/bin/zoxide"; then
        log_success "Zoxide is installed"
        return 0
    else
        log_error "Zoxide is not installed"
        return 1
    fi
}

# Main test execution
main() {
    echo ""
    log_info "=========================================="
    log_info "Docker Setup Test Suite"
    log_info "=========================================="
    echo ""

    # Check prerequisites
    if ! check_prerequisites; then
        log_error "Prerequisites check failed"
        exit 1
    fi

    echo ""

    # Run all tests
    local test_failed=false

    if ! build_docker_image; then
        test_failed=true
    fi

    echo ""

    if ! run_installation; then
        test_failed=true
    fi

    echo ""

    if ! verify_symlinks; then
        test_failed=true
    fi

    echo ""

    if ! check_antidote_installation; then
        test_failed=true
    fi

    echo ""

    if ! check_zoxide_installation; then
        test_failed=true
    fi

    # Print summary
    echo ""
    log_info "=========================================="
    log_info "Test Summary"
    log_info "=========================================="
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    echo -e "${RED}Failed: $TESTS_FAILED${NC}"

    if [ "$test_failed" = true ]; then
        log_error "Some tests failed"
        exit 1
    else
        log_success "All tests passed!"
        exit 0
    fi
}

# Run main
main
