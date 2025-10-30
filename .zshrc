# ============================================================================
# ZSH Configuration - Consolidated Single File
# ============================================================================
# All zsh configuration consolidated into this single file (December 2024)
# Previously split across: base.zsh, from_bashrc.zsh, and .zshrc
# Organized into logical sections with clear headers for easy navigation

# ============================================================================
# Quick Aliases
# ============================================================================
# xo: Open files/URLs with the default application
alias xo=xdg-open

# ============================================================================
# PATH Configuration
# ============================================================================
# Add local bin directory to PATH (required for tools like zoxide)
export PATH="$HOME/.local/bin:$PATH"

# ============================================================================
# Plugin Manager: Antidote
# ============================================================================
# Antidote is a zsh plugin manager that loads plugins from .zsh_plugins.txt
# It manages shell enhancements like completions, themes, and utilities
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Initialize completion system (required before loading plugins that use compdef)
autoload -Uz compinit
compinit

# Load plugins (many plugins require completion system to be initialized)
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

# Use Python 3 by default when invoking 'python' command
alias python=python3

# Set default text editor for commands like git, crontab, etc.
export EDITOR=nvim

# Configure pager defaults for output like man pages, git logs, etc.
if [[ -x $(which less 2> /dev/null) ]]; then
    export PAGER="less"
    # less options: ignore-case for searches, long prompt with file info,
    # suppress bell, handle long lines, colorize, exit if single screen,
    # raw control chars for colors/formatting
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    # Disable persistent history (files, manpages, etc. don't need permanent cache)
    export LESSHISTFILE='-'
    # Use lesspipe filter to display non-text files in less (archives, images, etc.)
    if [[ -x $(which lesspipe 2> /dev/null) ]]; then
	LESSOPEN="| lesspipe %s"
	export LESSOPEN
    fi
fi

# ============================================================================
# HISTORY SETTINGS
# ============================================================================
# Don't save trivial commands that clutter history (basic navigation, background jobs, shell control)
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..)"
# Keep substantial history in memory and on disk for effective searching
HISTSIZE=250000
HISTFILE=~/.zsh/.zsh_history
SAVEHIST=1000000
# Append commands to history immediately (don't wait for session to end)
setopt INC_APPEND_HISTORY
# Remove duplicate commands - keep most recent occurrence
setopt HIST_IGNORE_ALL_DUPS
# Don't save commands starting with space (useful for hiding sensitive data)
setopt HIST_IGNORE_SPACE
# Remove extra blanks from commands before storing
setopt HIST_REDUCE_BLANKS
# Show command being executed when recalling from history via Ctrl+R
setopt HIST_VERIFY

# ============================================================================
# SHELL BEHAVIOR SETTINGS
# ============================================================================

# Notify when long-running commands complete (helps track async tasks)
export REPORTTIME=30

# Safety feature: require confirmation before 'rm *' glob expansion
# Prevents disasters like 'rm * o' instead of intended 'rm *.o'
setopt RM_STAR_WAIT

# ============================================================================
# COLOR AND DISPLAY SETTINGS
# ============================================================================

# Enable color support for ls command (when terminal supports it)
# This makes directory listings more readable with color-coded file types
if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors 2> /dev/null` ]]; then
	eval `dircolors -b`
    fi
fi

# Use ISO 8601 date format (YYYY-MM-DD) for consistency and sorting
# Ensures dates sort correctly and are unambiguous regardless of locale
export TIME_STYLE="long-iso"

# Add thousands separators to file sizes in ls, du, df commands
# Makes large numbers easier to read at a glance
export BLOCK_SIZE="'1"

# Don't quote spaces in file names (newer coreutils feature)
# Files with spaces are displayed more naturally
export QUOTING_STYLE=literal

# ============================================================================
# ALIASES
# ============================================================================

# Improve ls output by grouping directories before files (more intuitive)
# Only enable if the installed coreutils version supports this flag
if man ls | grep group-directories-first >&/dev/null; then
    alias ls='ls --color=auto --group-directories-first'
fi

# Common ls variants for quick access to different listing formats
alias 'l=ls -l'           # Long format (detailed info)
alias 'la=ls -FA'         # Show hidden files without . and ..
alias 'll=ls -Flah'       # Full listing with human-readable sizes
alias 'lrt=ls -lrt'       # By modification time (oldest first)

# Enhanced grep with colors for matching terms and skip device files
alias 'grep=grep --colour=auto --devices=skip'

# Safety-first defaults: require confirmation before destructive operations
# Prevents accidental data loss from typos or muscle memory
alias 'rm=rm -i'
alias 'mv=mv -i'
alias 'cp=cp -i'

# Convenience improvements for common operations
alias 'mkdir=mkdir -p'    # Create parent directories automatically
alias 'cal=ncal -b'       # Use ncal with weeks starting Monday (ISO week standard)
alias 'dmesg=dmesg --ctime' # Show human-readable timestamps in kernel messages

# Common typing errors - space instead of dot
alias 'cd..= cd ..'

# Common one-letter shortcut for pager (from bash compatibility)
alias L='less'

# Git shortcut with completion
alias g='git'
compdef g=git

# Allow aliases to be expanded after sudo (preserves command substitution)
# Without this, 'sudo ll' won't work even if 'll' is an alias
# See: http://askubuntu.com/a/22043
alias sudo='sudo '

# ============================================================================
# FUNCTIONS
# ============================================================================

# Quick file finder: case-insensitive search in current directory and subdirs
qf() {
    echo "find . -iname \"*$1*\""
    find . -iname "*$1*"
}

# Quick history search: find commands matching all given keywords (regex-based)
# Usage: zh git commit (finds all commands with both "git" and "commit")
zh() {
    pattern=^$(echo '(?=.*'${^@}')' | tr -d ' ')
    grep --text $HISTFILE --perl-regexp --regexp $pattern
}

# Create directory and immediately cd into it - eliminates the need for separate commands
mkcd() { mkdir -p -- "$1" && cd -- "$1" }
# Enable completion for mkcd to work like mkdir
compdef mkcd=mkdir

# Helper function: recursively resolve aliases to their final command
# Used by rationalise-dot to avoid expanding in contexts where dots have special meaning
resolve-alias() {
    typeset -a cmd
    cmd=(${(z)1})
    while (( ${+aliases[$cmd[1]]} )) \
          && [[ ${aliases[$cmd[1]]} != $cmd ]]; do
	cmd=(${(z)aliases[${cmd[1]}]})
    done
    echo $cmd
}

# Auto-expand repeated dots into directory traversals
# "..." becomes "../../", "...." becomes "../../../", etc.
# Skips expansion in git, tig, and p4 to avoid interfering with their operations
# When pasting text (PENDING > 0), inserts literally without expansion
rationalise-dot() {
    local MATCH # Prevent regex match variable from leaking to environment

    # Don't expand when pasting multi-line text
    if (( PENDING > 0 )); then
	zle self-insert
	return
    fi

    # Check if we're in a position to expand (after path separator, operator, etc.)
    # and NOT in a command that uses dots as special syntax
    if [[ $LBUFFER =~ '(^|/| ||'$'\n''|\||;|&)\.\.$' ]] \
       && ! [[ $(resolve-alias $LBUFFER) =~ '(git|tig|p4)' ]]; then
	LBUFFER+=/
	zle self-insert
	zle self-insert
    else
	zle self-insert
    fi
}
zle -N rationalise-dot
# Bind period key to enable dot expansion
bindkey . rationalise-dot
# In search mode (Ctrl+R), period inserts literally (don't interfere with history search)
bindkey -M isearch . self-insert 2>/dev/null

# ============================================================================
# COMPLETION CACHING
# ============================================================================

# Cache completion results for slow functions like _apt and _dpkg
# Dramatically speeds up completion for debian package lists and similar heavy operations
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ============================================================================
# AUTOLOADS
# ============================================================================
# Load advanced zsh modules that provide powerful utilities
# These are loaded on-demand when first called

# zargs: like xargs but for zsh with full zsh argument expansion
autoload -U zargs

# zcalc: built-in arbitrary precision calculator (type: zcalc, then exit with 'q')
autoload zcalc

# zed: full-featured line editor for editing files or command-line content
autoload zed

# zmv: rename multiple files with pattern matching and transformations
# Usage: zmv 'pattern' 'replacement' (e.g., zmv '(*).txt' '${1}.md')
autoload zmv

# ============================================================================
# Directory Navigation: zoxide
# ============================================================================
# zoxide is a modern directory jumper that learns your frequently used directories
# It provides the 'z' and 'zi' commands for quick navigation
export _ZO_FZF_OPTS="--height 40% --layout=reverse --border"
eval "$(zoxide init zsh)"

# ============================================================================
# Fuzzy Finder (fzf) Configuration
# ============================================================================
# fzf provides fuzzy search capabilities for the shell
# Loaded via Antidote plugin manager (see .zsh_plugins.txt)
# This provides fuzzy completion and keyboard shortcuts (Ctrl+R for history, Ctrl+T for files)
export FZF_ALT_C_COMMAND="fd --type d"

# ============================================================================
# XDG Base Directory Standard
# ============================================================================
# XDG_CONFIG_HOME: Standard location for user configuration files
export XDG_CONFIG_HOME=~/.config

# ============================================================================
# Prompt: Starship
# ============================================================================
# Starship is a minimal, fast, and customizable cross-shell prompt
# Configuration located at ~/.config/starship.toml
eval "$(starship init zsh)"
