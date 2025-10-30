# Dockerfile for testing dotfiles installation
# Base image: Ubuntu 22.04
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Update package lists and install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    sudo \
    zsh \
    build-essential \
    ca-certificates \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create a test user with sudo access
RUN useradd -m -s /bin/bash testuser && \
    usermod -aG sudo testuser && \
    echo "testuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/testuser && \
    chmod 0440 /etc/sudoers.d/testuser

# Create necessary directories
RUN mkdir -p /home/testuser/.dotfiles && \
    chown -R testuser:testuser /home/testuser

# Copy dotfiles repository
COPY --chown=testuser:testuser . /home/testuser/.dotfiles/

# Set working directory
WORKDIR /home/testuser/.dotfiles

# Switch to test user
USER testuser

# Initialize git repository and submodules (needed since .git is excluded by .dockerignore)
RUN rm -rf dotbot && \
    git init && \
    git submodule add https://github.com/anishathalye/dotbot dotbot && \
    cd dotbot && git checkout master && cd ..

# Run the installation script (allow some commands to fail in Docker environment)
RUN bash -c 'cd /home/testuser/.dotfiles && ./install || true' && \
    # Verify that at least symlinks were created
    test -L /home/testuser/.zshrc && \
    test -L /home/testuser/.gitconfig && \
    test -L /home/testuser/.tmux.conf

# Set up shell environment for testing
ENV SHELL=/bin/zsh
RUN mkdir -p /home/testuser/.local/bin

# Default command for interactive testing (can be overridden)
CMD ["/bin/bash"]
