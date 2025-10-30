# Dotfiles Modernization Plan

## Overview

### Problem

Current dotfiles repository contains obsolete configurations and outdated tools:
- **Bash configuration**: Complete setup present but unused (switched to zsh)
- **Python environments**: Both pyenv and conda configured but now using `uv` for Python management
- **Outdated plugins**: Using Antigen (unmaintained) for zsh, vim-plug for Neovim
- **Obsolete tools**: taskwarrior, VSCode configs, ranger integration, NVM
- **Old Neovim**: v0.6.1 (requires v0.9.0+ for modern LSP/treesitter)
- **Maintenance burden**: Duplicate aliases, commented code, unclear structure

This creates confusion during setup, slows shell startup, and makes maintenance difficult.

### Purpose

Modernize dotfiles to a clean, maintainable configuration focused on current workflows:
- Remove all obsolete configurations (bash, python envs, unused tools)
- Migrate to modern, actively-maintained tools (Antidote, LazyVim, zoxide)
- Establish clear structure with inline documentation
- Optimize for coding and terminal workflows
- Reduce complexity while maintaining essential functionality

### Scope

**IN scope:**
- Remove: bash configs, pyenv/conda setup, taskwarrior, VSCode, ranger, NVM
- Migrate: Antigen → Antidote (zsh), vim-plug → LazyVim (Neovim), fasd → zoxide
- Update: tmux for v3.x, git config with modern features
- Add: Documentation, Docker testing setup
- Optimize: Zsh aliases, plugin selection

**OUT of scope:**
- New feature additions (keep existing workflows)
- Dotbot replacement (working well)
- Shell migration (staying with zsh)
- Custom Neovim configuration from scratch (using LazyVim distribution)

### Success Criteria

- [ ] Fresh install works in clean Docker environment
- [ ] All obsolete configs removed (bash, Python envs, unused tools)
- [ ] Zsh uses Antidote with 11 curated plugins (down from 12)
- [ ] Neovim v0.9.0+ with LazyVim providing Python LSP/completion
- [ ] Shell startup faster (Antidote lazy loading)
- [ ] All essential aliases/functions preserved
- [ ] Well-commented configs with inline documentation
- [ ] Clean commit history documenting each phase

---

## Solution Design

### System Architecture

**Core Components:**

**Zsh Configuration:**
- **Antidote**: Modern plugin manager replacing Antigen (lazy loading, better performance)
- **Plugin System**: 11 curated plugins loaded via `.zsh_plugins.txt`
- **Config Files**: `env.zsh`, `base.zsh`, `from_bashrc.zsh` (cleaned, consolidated)
- **zoxide**: Modern directory jumper (Rust-based) replacing fasd

**Neovim Configuration:**
- **LazyVim**: Pre-configured distribution with modern LSP/treesitter
- **Language Support**: Python, Markdown, JSON, YAML via extras system
- **Plugins**: ~50 plugins (lazy-loaded) replacing 30 manual vim-plug plugins
- **vim-tmux-navigator**: Custom plugin for tmux integration

**Tmux Configuration:**
- **Updated .tmux.conf**: Modern v3.x features (popups, improved bindings)
- **TPM**: Plugin manager with sensible, resurrect, continuum plugins

**Git Configuration:**
- **Updated .gitconfig**: Modern features (fsmonitor, maintenance, better aliases)
- **Email**: Already correct (`tordks@hotmail.com`)

**Installation System:**
- **Dotbot**: Unchanged (working well)
- **Scripts**: `setup_nvim.sh` (updated for LazyVim dependencies)
- **Docker Testing**: Dockerfile + test script for validation

**Project Structure:**
```
.dotfiles/
├── bash/ [REMOVE]
├── zsh/
│   ├── env.zsh [MODIFY]
│   ├── base.zsh [MODIFY]
│   ├── from_bashrc.zsh [MODIFY]
│   └── antigen_config.zsh [REMOVE]
├── nvim/
│   ├── archive/ [CREATE]
│   │   ├── init.vim [CREATE] (moved from nvim/)
│   │   ├── plugins.vim [CREATE] (moved from nvim/)
│   │   └── *.vim [CREATE] (moved old configs)
│   ├── lua/ [CREATE]
│   │   ├── config/ [CREATE]
│   │   │   ├── lazy.lua [CREATE]
│   │   │   └── options.lua [CREATE]
│   │   └── plugins/ [CREATE]
│   │       └── tmux.lua [CREATE]
│   └── init.lua [CREATE]
├── .zsh_plugins.txt [CREATE]
├── .zshrc [MODIFY]
├── .tmux.conf [MODIFY]
├── .gitconfig [MODIFY]
├── .global_gitignore [MODIFY]
├── .taskrc [REMOVE]
├── vscode/ [REMOVE]
├── install_pyenv.sh [REMOVE]
├── setup_nvim.sh [MODIFY]
├── install.conf.yaml [MODIFY]
├── Dockerfile [CREATE]
├── test-docker.sh [CREATE]
├── .dockerignore [CREATE]
└── README.md [CREATE]
```

**Component Relationships:**
- `.zshrc` sources `zsh/*.zsh` configs and initializes Antidote
- Antidote loads plugins from `.zsh_plugins.txt`
- zoxide binary called via `eval "$(zoxide init zsh)"`
- LazyVim config in `nvim/lua/` with custom plugins in `nvim/lua/plugins/`
- Dotbot executes `install.conf.yaml` which runs setup scripts
- Docker testing validates entire installation flow

**Relationship to Existing Codebase:**
- **Architecture**: Dotfiles repository with Dotbot orchestration (unchanged)
- **Domain**: Shell/editor configuration management
- **Extends**: Current symlink-based approach via Dotbot
- **Uses**: System package managers (apt), external installers (zoxide, Antidote)
- **Follows**: Dotbot patterns, XDG base directory spec for Neovim

---

### Design Rationale

**Migrate from Antigen to Antidote for zsh**

Antigen is unmaintained (last update 2016). Antidote provides same functionality with better performance:
- Lazy loading by default (faster shell startup)
- Static plugin loading (generates `.zsh` file, no runtime overhead)
- Active maintenance and modern zsh compatibility
- Same plugin sources (oh-my-zsh, external repos)

Trade-offs accepted:
- Pro: Faster startup, better maintained, same plugins
- Con: Different configuration syntax (migration cost is one-time)

**Replace fasd with zoxide**

fasd unmaintained since 2015. zoxide is modern Rust-based alternative:
- 10x faster (compiled vs shell script)
- Smarter frecency algorithm (frequency + recency)
- Active development, cross-platform
- Drop-in `z` command replacement

Trade-offs accepted:
- Pro: Much faster, better algorithm, maintained
- Con: Directory-only (no file tracking - but rarely used)

**Use LazyVim distribution for Neovim**

Building custom Lua config from scratch requires significant time investment. LazyVim provides:
- Pre-configured LSP, treesitter, completion, telescope
- Curated plugin ecosystem (~50 plugins, optimized)
- Language support via "extras" system (just enable Python/Markdown/etc)
- Active maintenance, follows Neovim best practices
- No Lua coding required for standard workflows

Alternatives considered:
- **NvChad**: Similar approach, slightly different plugin choices
- **Custom Lua**: Full control but 10+ hours investment for equivalent functionality
- **Keep vim-plug**: Outdated, manual LSP setup, no treesitter integration

Trade-offs accepted:
- Pro: Ready immediately, best practices, maintained, no Lua required
- Con: Less control over plugin choices (acceptable for standard workflows)

**Remove Python environment management**

Now using `uv` for Python version/package management. Dotfiles should not manage Python environments:
- Reduces complexity and maintenance
- Faster shell startup (no pyenv/conda init)
- `uv` handles per-project Python versions
- Neovim LSP uses system/project Python automatically

**Consolidate and trim zsh plugins**

Original 12 plugins + commented plugins. New setup: 11 active plugins:
- **Remove**: heroku (not installed), fasd (replaced), hschne/fzf-git (replaced)
- **Add**: Aloxaf/fzf-tab (fuzzy completions), wfxr/forgit (better git integration)
- **Keep**: All actively-used plugins confirmed

Trade-offs accepted:
- Pro: Cleaner, better-maintained tools
- Con: Learning new commands (forgit vs fzf-git - minor)

**Clean up duplicate and problematic aliases**

Issues found:
- Duplicate `ls` alias in two files
- `grep --colour=always` breaks piping
- Excessive ls variations (8 aliases, keep 4 most-used)
- Duplicate git alias (oh-my-zsh already provides)

Consolidation improves maintainability and removes foot-guns.

---

### Technical Specification

**Dependencies:**

**New/Updated:**
- Neovim 0.9.0+ (LazyVim requirement) - via PPA or AppImage
- Antidote (git clone) - zsh plugin manager
- zoxide (install script) - directory jumper
- ripgrep (`rg`) - required for Telescope search
- fd-find (`fd`) - required for Telescope file finding

**Removed:**
- pyenv and build dependencies
- conda
- NVM
- taskwarrior
- Antigen

**Existing (kept):**
- zsh (primary shell)
- tmux 3.x+
- git (modern version)
- fzf (fuzzy finder)
- Python 3.x (system or via uv)

**Runtime Behavior:**

**Zsh initialization flow:**
1. `.zshrc` sources `zsh/env.zsh` (environment variables)
2. Initialize Antidote from `~/.antidote/antidote.zsh`
3. Load plugins from `.zsh_plugins.txt` via `antidote load`
4. Source custom configs: `zsh/base.zsh`, `zsh/from_bashrc.zsh`
5. Initialize fzf (key bindings, completions)
6. Initialize zoxide with `eval "$(zoxide init zsh)"`

**Neovim initialization flow:**
1. LazyVim reads `nvim/init.lua`
2. Loads `nvim/lua/config/lazy.lua` (plugin manager + extras)
3. Imports language extras (Python, Markdown, JSON, YAML)
4. Loads custom plugins from `nvim/lua/plugins/*.lua`
5. Downloads/updates plugins on first run
6. Mason auto-installs LSP servers (pyright for Python)

**Installation flow:**
1. Dotbot creates symlinks from `install.conf.yaml`
2. Shell commands install Antidote, zoxide
3. `setup_nvim.sh` installs Neovim + dependencies (ripgrep, fd)
4. First Neovim launch triggers LazyVim plugin installation

**Configuration:**

**Zsh environment variables** (env.zsh):
```bash
export EDITOR=nvim
export XDG_CONFIG_HOME=~/.config
export FZF_ALT_C_COMMAND="fd --type d . $HOME"
export _ZO_FZF_OPTS="--height 40% --layout=reverse --border"
```

**Zsh plugin list** (.zsh_plugins.txt):
```
ohmyzsh/ohmyzsh path:lib
ohmyzsh/ohmyzsh path:plugins/git
ohmyzsh/ohmyzsh path:plugins/vi-mode
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
djui/alias-tips
z-shell/F-Sy-H
Aloxaf/fzf-tab
junegunn/fzf path:shell kind:fpath
wfxr/forgit
jsahlen/tmux-vim-integration.plugin.zsh
ohmyzsh/ohmyzsh path:themes/candy.zsh-theme
```

**LazyVim extras** (lua/config/lazy.lua):
```lua
{ import = "lazyvim.plugins.extras.lang.python" }
{ import = "lazyvim.plugins.extras.lang.markdown" }
{ import = "lazyvim.plugins.extras.lang.json" }
{ import = "lazyvim.plugins.extras.lang.yaml" }
```

**Error Handling:**

**Installation errors:**
- Neovim version too old → Fail with message: "LazyVim requires Neovim 0.9.0+, found X.Y.Z"
- Missing dependencies (rg, fd) → Install via apt in setup script
- Network errors during plugin install → Retry on next Neovim launch
- Symlink conflicts → Dotbot prompts or fails (manual resolution required)

**Runtime errors:**
- Plugin load failure → zsh continues (degraded functionality)
- zoxide not installed → `z` command unavailable but shell works
- LSP server missing → Neovim shows warning, can install via `:Mason`

---

## Implementation Strategy

### Development Approach

**Incremental Phases with Safety Checkpoints**

Build in discrete phases with validation after each:
1. **Cleanup First**: Remove obsolete configs to establish clean baseline
2. **Shell Modernization**: Migrate zsh to modern tools (Antidote, zoxide)
3. **Editor Modernization**: Replace Neovim config with LazyVim
4. **Polish & Document**: Update ancillary configs, add documentation
5. **Validate at Boundaries**: Git commit + Docker test after each phase

Each phase produces a working system state. Rollback via git if issues arise.

### Testing Approach

**Multi-layered Validation:**

**Manual Testing:**
- New shell session after zsh changes
- Neovim launch after config changes
- Verify commands work (z, aliases, vim bindings)

**Docker Testing:**
- Clean Ubuntu 22.04 environment
- Full installation from scratch
- Automated verification of symlinks and tools
- Run before and after each phase for regression detection

**Git Safety:**
- Commit after each phase (atomic, revertible changes)
- Descriptive commit messages document changes
- Old configs archived (not deleted permanently)

### Risk Mitigation Strategy

**Critical Path Items (Tackle Early):**
- Neovim version upgrade (Phase 3 blocker - must upgrade first)
- Antidote plugin compatibility (Phase 2 - test with current plugins before cleanup)

**Safe Rollback Points:**
- Git commits after each phase
- Archived configs in `nvim/archive/` (can restore if needed)
- Docker testing provides pre-flight validation

**Unknowns to Validate:**
- LazyVim compatibility with vim-tmux-navigator (add as custom plugin early)
- zoxide integration with current fzf setup (test in Phase 2)
- Neovim Python LSP auto-detection (validate in Phase 3)

### Checkpoint Strategy

Each phase ends with validation before proceeding:

**Self-review:**
- Agent reviews implementation against phase deliverable
- Verifies all files marked [CREATE]/[MODIFY]/[REMOVE] were handled
- Confirms phase goals achieved

**Functional Testing:**
- Manual verification in new shell/editor session
- Test key workflows (commands, navigation, editing)

**Docker Testing:**
- Run `./test-docker.sh` to validate clean install
- Verify no regressions from previous phases

**Git Commit:**
- Commit phase changes with descriptive message
- Creates rollback point for next phase

**Note:** This project doesn't use linters/formatters for shell/Neovim config files, so no automated code quality checkpoints beyond manual review and functional testing.
