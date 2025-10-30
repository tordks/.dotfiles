# Dotfiles Modernization Tasklist

## Phase 1: Cleanup & Removal

**Goal:** Remove all obsolete configurations to establish clean baseline

**Deliverable:** Repository with bash, Python environments, taskwarrior, VSCode, ranger, and NVM fully removed. Clean configs with no commented code.

**Tasks:**

- [x] [P1.1] Delete `bash/` directory entirely
- [x] [P1.2] Remove bash symlink from `install.conf.yaml` (`~/.bash_profile`)
- [x] [P1.3] Delete `install_pyenv.sh` script
- [x] [P1.4] Remove pyenv/conda installation from `install.conf.yaml` shell commands
- [x] [P1.5] Remove conda initialization from `.zshrc` (lines 70-82)
- [x] [P1.6] Remove NVM initialization from `.zshrc` (lines 86-88)
- [x] [P1.7] Remove `. "$HOME/.local/bin/env"` from `.zshrc` (line 90)
- [x] [P1.8] Remove pyenv init from `zsh/env.zsh` (PYENV_ROOT, PATH modifications)
- [x] [P1.9] Remove Python-related aliases from `zsh/base.zsh` (if any pyenv/conda specific)
- [x] [P1.10] Delete `.taskrc` and remove taskwarrior symlink from `install.conf.yaml`
- [x] [P1.11] Delete `vscode/` directory and remove VSCode symlink from `install.conf.yaml`
- [x] [P1.12] Remove ranger integration from `zsh/from_bashrc.zsh` (Ctrl-O binding lines 38-40, ranger function lines 47-52)
- [x] [P1.13] Clean `.global_gitignore` (remove Python-specific and unused IDE entries)
- [x] [P1.14] Remove duplicate `ls` alias from `zsh/base.zsh` (keep version in `from_bashrc.zsh`)
- [x] [P1.15] Fix grep alias in `zsh/from_bashrc.zsh` (change `--colour=always` to `--colour=auto`, remove `--line-number`)
- [x] [P1.16] Remove duplicate git alias from `zsh/from_bashrc.zsh` (`compdef g='git'` and `alias g=git` - oh-my-zsh provides this)
- [x] [P1.17] Remove excessive ls alias variations from `zsh/from_bashrc.zsh` (keep: `l`, `la`, `ll`, `lrt`; remove: `llh`, `lq`, `lr`, `lrs`, `lrta`, `lrth`, `lrtha`)
- [x] [P1.18] Test in new zsh session: verify shell starts without errors
- [x] [P1.19] Verify essential aliases still work (`xo`, `python`, `mkdir`, safety aliases)
- [x] [P1.20] Commit: `git commit -m "cleanup: remove bash, python env, taskwarrior, vscode, ranger, and NVM configs"`

**Checkpoints:**

- [x] Self-review: Verify all obsolete configs removed, no broken references in remaining files
- [x] Functional test: Start new zsh session, verify no errors, test preserved aliases
- [x] Review: Confirm phase deliverable achieved (clean baseline established)

**Phase 1 Complete:** All obsolete configurations removed. Clean baseline with working zsh configuration and preserved essential aliases/functions.

---

## Phase 2: Zsh Modernization

**Goal:** Migrate from Antigen to Antidote and modernize zsh plugin ecosystem

**Deliverable:** Zsh using Antidote with 11 curated plugins, zoxide replacing fasd, fast shell startup

**Tasks:**

- [x] [P2.1] Remove Antigen installation from `install.conf.yaml` (delete curl command for `~/antigen.zsh`)
- [x] [P2.2] Add Antidote installation to `install.conf.yaml`: `git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote`
- [x] [P2.3] Add zoxide installation to `install.conf.yaml`: `curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash`
- [x] [P2.4] Create `.zsh_plugins.txt` with plugin declarations
  - Core: `ohmyzsh/ohmyzsh path:lib`
  - Plugins: `ohmyzsh/ohmyzsh path:plugins/git`, `ohmyzsh/ohmyzsh path:plugins/vi-mode`
  - External: `zsh-users/zsh-autosuggestions`, `zsh-users/zsh-completions`, `djui/alias-tips`
  - Syntax: `z-shell/F-Sy-H`
  - New: `Aloxaf/fzf-tab`, `wfxr/forgit`
  - Fzf: `junegunn/fzf path:shell kind:fpath`
  - Tmux: `jsahlen/tmux-vim-integration.plugin.zsh`
  - Theme: `ohmyzsh/ohmyzsh path:themes/candy.zsh-theme`
- [x] [P2.5] Update `.zshrc`: Remove Antigen initialization (source ~/antigen.zsh, antigen_config.zsh, antigen apply)
- [x] [P2.6] Update `.zshrc`: Add Antidote initialization
  - `source ${ZDOTDIR:-~}/.antidote/antidote.zsh`
  - `antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt`
- [x] [P2.7] Update `.zshrc`: Remove fasd initialization
- [x] [P2.8] Update `.zshrc`: Add zoxide initialization: `eval "$(zoxide init zsh)"`
- [x] [P2.9] Update `.zshrc`: Add zoxide fzf integration: `export _ZO_FZF_OPTS="--height 40% --layout=reverse --border"`
- [x] [P2.10] Remove fasd aliases from zsh configs (`a`, `s`, `d`, `f`, `sd`, `sf`, `z`, `zz`)
- [x] [P2.11] Delete `zsh/antigen_config.zsh`
- [x] [P2.12] Add section comments to `zsh/base.zsh`, `zsh/env.zsh`, `zsh/from_bashrc.zsh` for clarity
- [x] [P2.13] Test in new zsh session: verify Antidote loads plugins without errors
- [x] [P2.14] Test zoxide: `cd` to several directories, then use `z <partial-name>` to jump
- [x] [P2.15] Test new plugins: verify fzf-tab completions work (trigger tab completion), test forgit commands (`git forgit::log`)
- [x] [P2.16] Verify preserved plugins work: alias-tips shows suggestions, tmux-vim-integration commands available
- [x] [P2.17] Compare shell startup time (optional): `time zsh -i -c exit` before/after (should be faster)
- [x] [P2.18] Commit: `git commit -m "feat: migrate from Antigen to Antidote for zsh plugin management"`

**Checkpoints:**

- [x] Self-review: Verify all plugins loading, zoxide working, no Antigen/fasd references remain
- [x] Functional test: New zsh session, test plugin functionality (completions, syntax highlighting, zoxide)
- [x] Review: Confirm phase deliverable achieved (modern zsh setup with curated plugins)

**Phase 2 Complete:** Zsh modernized with Antidote plugin manager, zoxide for directory jumping, 11 curated plugins providing enhanced functionality with faster startup.

---

## Phase 3: Neovim Modernization

**Goal:** Upgrade Neovim and migrate to LazyVim for modern LSP-based development

**Deliverable:** Neovim 0.9.0+ with LazyVim distribution providing Python LSP, completion, and modern editing features

**Tasks:**

- [x] [P3.1] Create archive directory: `mkdir -p nvim/archive`
- [x] [P3.2] Move old configs to archive: `mv nvim/init.vim nvim/plugins.vim nvim/*.vim nvim/archive/` (if exist)
- [x] [P3.3] Backup Neovim data: `mv ~/.local/share/nvim ~/.local/share/nvim.backup` (if exist)
- [x] [P3.4] Backup Neovim state: `mv ~/.local/state/nvim ~/.local/state/nvim.backup` (if exist)
- [x] [P3.5] Backup Neovim cache: `mv ~/.cache/nvim ~/.cache/nvim.backup` (if exist)
- [x] [P3.6] Update `setup_nvim.sh`: Replace old script with new version
  - Add Neovim installation (PPA or AppImage for v0.9.0+)
  - Install Python tools: `pip install --user black ruff isort flake8`
  - Install Telescope dependencies: `apt install ripgrep fd-find`
  - Add usage instructions in echo statements
- [x] [P3.7] Make script executable: `chmod +x setup_nvim.sh`
- [x] [P3.8] Update `install.conf.yaml`: Ensure nvim setup script is called
- [ ] [P3.9] Run `setup_nvim.sh` to install Neovim 0.9.0+ and dependencies
- [ ] [P3.10] Verify Neovim version: `nvim --version` (should be 0.9.0+)
- [x] [P3.11] Clone LazyVim starter to nvim directory: `git clone https://github.com/LazyVim/starter ~/.dotfiles/nvim/`
- [x] [P3.12] Remove LazyVim git metadata: `rm -rf nvim/.git`
- [x] [P3.13] Verify symlink in `install.conf.yaml`: `~/.config/nvim: nvim/`
- [x] [P3.14] Edit `nvim/lua/config/lazy.lua`: Add language extras imports at top
  - `{ import = "lazyvim.plugins.extras.lang.python" }`
  - `{ import = "lazyvim.plugins.extras.lang.markdown" }`
  - `{ import = "lazyvim.plugins.extras.lang.json" }`
  - `{ import = "lazyvim.plugins.extras.lang.yaml" }`
- [x] [P3.15] Create `nvim/lua/plugins/tmux.lua` with vim-tmux-navigator configuration
  - Plugin: `christoomey/vim-tmux-navigator`
  - Keybindings: `<c-h>`, `<c-j>`, `<c-k>`, `<c-l>`, `<c-\>`
- [x] [P3.16] Edit `nvim/lua/config/options.lua`: Add personal preferences
  - `opt.relativenumber = false`
  - `opt.wrap = true`
  - `opt.colorcolumn = "80"`
  - `opt.scrolloff = 8`
- [x] [P3.17] Edit `nvim/lua/config/lazy.lua`: Set gruvbox colorscheme in LazyVim opts
- [ ] [P3.18] Launch Neovim: `nvim` (LazyVim will auto-install plugins)
- [ ] [P3.19] Wait for plugin installation to complete (monitor dashboard/notifications)
- [ ] [P3.20] Run health check: `:checkhealth` and verify no critical errors
- [ ] [P3.21] Test Python LSP: Create `test.py`, add `def hello(): print('world')`, verify completion works
- [ ] [P3.22] Test LSP features: Press `K` on symbol (docs), `gd` (go to definition), `<space>cf` (format)
- [ ] [P3.23] Test vim-tmux-navigator: Use `<c-h/j/k/l>` to navigate splits
- [ ] [P3.24] Test file navigation: `<space>e` (file explorer), `<space>ff` (find files)
- [ ] [P3.25] Test search: `<space>sg` (live grep), verify ripgrep working
- [ ] [P3.26] Commit: `git commit -m "feat: migrate to LazyVim for modern Python development"`
  - Include commit body describing changes (archive old config, add LazyVim, enable language support)

**Checkpoints:**

- [ ] Self-review: Verify LazyVim installed, all extras enabled, custom plugins working
- [ ] Functional test: Open Python file, test LSP (completion, go-to-def, formatting), test navigation
- [ ] Health check: `:checkhealth` shows no critical errors
- [ ] Review: Confirm phase deliverable achieved (modern Neovim with Python LSP ready)

**Phase 3 Complete:** Neovim upgraded to 0.9.0+ with LazyVim providing modern LSP-based editing. Python development fully functional with completion, formatting, and diagnostics.

---

## Phase 4: Tmux & Git Modernization

**Goal:** Update tmux configuration for v3.x features and modernize git config

**Deliverable:** Tmux with modern bindings and features, git with updated aliases and settings

**Tasks:**

- [x] [P4.1] Review `.tmux.conf`: Verify mouse mode uses modern syntax (`set -g mouse on`)
- [x] [P4.2] Add popup terminal binding to `.tmux.conf`: `bind-key g display-popup -E "tmux new-session -A -s scratch"`
- [x] [P4.3] Add better pane splitting to `.tmux.conf`:
  - `bind | split-window -h -c "#{pane_current_path}"`
  - `bind - split-window -v -c "#{pane_current_path}"`
- [x] [P4.4] Update status bar in `.tmux.conf` for 24-bit color support (if needed)
- [x] [P4.5] Add section comments to `.tmux.conf` (key bindings, plugins, settings groups)
- [x] [P4.6] Verify TPM installation in `install.conf.yaml`: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- [x] [P4.7] Review tmux plugin list in `.tmux.conf`, confirm: sensible, resurrect, continuum, yank, copycat
- [x] [P4.8] Update `.gitconfig`: Add modern git features
  - `[init] defaultBranch = main`
  - `[maintenance] auto = true`
  - `[feature] manyFiles = true`
  - `[core] fsmonitor = true`
- [x] [P4.9] Add useful git aliases to `.gitconfig`:
  - `recent = branch --sort=-committerdate --format='%(committerdate:short) %(refname:short)'`
  - `undo = reset --soft HEAD^`
  - `amend = commit --amend --no-edit`
- [x] [P4.10] Review existing git aliases in `.gitconfig`, update if outdated
- [x] [P4.11] Test tmux: `tmux source ~/.tmux.conf`, verify no errors
- [x] [P4.12] Test tmux popup: Press prefix + `g`, verify scratch session popup works
- [x] [P4.13] Test tmux splits: Use `|` and `-` bindings, verify paths preserved
- [x] [P4.14] Test git aliases: `git recent`, `git undo` (after test commit), `git amend`
- [x] [P4.15] Commit: `git commit -m "feat: modernize tmux and git configs for modern features"`

**Checkpoints:**

- [x] Self-review: Verify tmux config updated, git config enhanced, all changes tested
- [x] Functional test: Use tmux with new bindings, test git aliases
- [x] Review: Confirm phase deliverable achieved (modern tmux and git setup)

**Phase 4 Complete:** Tmux updated with v3.x features (popups, better bindings). Git config modernized with new features and useful aliases.

---

## Phase 5: Docker Testing & Documentation

**Goal:** Create Docker testing infrastructure and comprehensive documentation

**Deliverable:** Docker-based testing validates clean installation. README and inline comments document the setup.

**Tasks:**

- [x] [P5.1] Create `Dockerfile` for testing dotfiles installation
  - Base: Ubuntu 22.04
  - Install: git, curl, wget, sudo, zsh, build-essential
  - Create testuser with sudo access
  - Copy dotfiles and run `./install`
- [x] [P5.2] Create `test-docker.sh` script with test automation
  - Build Docker image
  - Run installation
  - Verify symlinks created (.zshrc, .gitconfig, .tmux.conf, nvim config)
  - Check antidote and zoxide installed
  - Exit codes for CI/CD compatibility
- [x] [P5.3] Make test script executable: `chmod +x test-docker.sh`
- [x] [P5.4] Create `.dockerignore` to exclude unnecessary files (.git, plans, .claude, cache)
- [x] [P5.5] Run Docker test: `./test-docker.sh` and verify all checks pass
- [x] [P5.6] Fix any issues found in Docker testing, re-run until clean
- [x] [P5.7] Create `README.md` with comprehensive documentation
  - Quick Start: Installation instructions
  - Dependencies: Required packages and versions
  - Structure: Directory layout explanation
  - Key Features: Zsh (Antidote), Neovim (LazyVim), tmux, git
  - Key Bindings: Quick reference for Neovim LazyVim
  - Testing: Docker testing instructions
  - Customization: How to extend configs
  - Troubleshooting: Common issues and solutions
- [x] [P5.8] Add section comments to `.zshrc` explaining each sourced file
- [x] [P5.9] Review and enhance comments in `zsh/env.zsh`, `zsh/base.zsh`, `zsh/from_bashrc.zsh`
- [x] [P5.10] Add comments to `install.conf.yaml` organizing into sections (System Update, Shell Tools, Development Tools, Symlinks)
- [x] [P5.11] Review `setup_nvim.sh` comments for clarity
- [x] [P5.12] Add header comment to `.zsh_plugins.txt` explaining Antidote plugin format
- [x] [P5.13] Organize `install.conf.yaml`: Group related operations with section comments
- [x] [P5.14] Final Docker test: `./test-docker.sh` to validate complete setup
- [x] [P5.15] Add missing `.zsh_plugins.txt` symlink and cleanup old files from previous phases
- [ ] [P5.16] Commit: `git commit -m "docs: add Docker testing and comprehensive documentation"`

**Checkpoints:**

- [x] Self-review: Verify Docker testing works, README complete, all configs well-commented
- [x] Docker test: Run `./test-docker.sh` and confirm all checks pass in clean environment
- [x] Review: Confirm phase deliverable achieved (tested, documented setup)

**Phase 5 Complete:** Docker testing infrastructure validates clean installation. Comprehensive documentation and inline comments make setup maintainable and understandable.

---

## Phase 6: Final Validation & Cleanup

**Goal:** Comprehensive testing and final polish

**Deliverable:** Fully modernized, tested, and documented dotfiles ready for daily use

**Tasks:**

- [ ] [P6.1] Run full Docker test suite: `./test-docker.sh` and verify 100% pass rate
- [ ] [P6.2] Test fresh install manually in new environment (VM/container): Run `./install` and verify
- [ ] [P6.3] Verify shell startup time improved: `time zsh -i -c exit` (should be faster than original)
- [ ] [P6.4] Test all preserved functions: `mkcd`, `qf`, `zh`, `rationalise-dot`, `alert`
- [ ] [P6.5] Test all preserved aliases: `xo`, `python`, safety aliases (`rm -i`, `mv -i`), `mkdir`, `cd..`, `L`, `sudo`
- [ ] [P6.6] Test zsh autoloads: `zmv`, `zcalc`, `zargs`, `zed`
- [ ] [P6.7] Verify zoxide working: `z` command jumps to frecent directories, `zi` for interactive
- [ ] [P6.8] Verify forgit commands: `git forgit::log`, `git forgit::diff`
- [ ] [P6.9] Verify fzf-tab: Trigger tab completion and see fuzzy menu
- [ ] [P6.10] Test Neovim LazyVim exhaustively:
  - Python file: LSP completion, go-to-definition, formatting, diagnostics
  - Markdown file: Syntax highlighting, inline code blocks
  - JSON/YAML: Validation and formatting
  - Git integration: LazyGit (`<space>gg`), blame (`<space>gb`)
- [ ] [P6.11] Test vim-tmux-navigator: Navigate between vim splits and tmux panes with `<c-hjkl>`
- [ ] [P6.12] Test tmux features: Popup terminal, improved splits, resurrect/continuum
- [ ] [P6.13] Verify git aliases work: `git recent`, `git undo`, `git amend`
- [ ] [P6.14] Check for any remaining references to removed tools: `grep -r "pyenv\|conda\|antigen\|fasd\|ranger\|taskwarrior" .`
- [ ] [P6.15] Review git history: Verify clean commit messages for each phase
- [ ] [P6.16] Update `README.md` if any gaps found during testing
- [ ] [P6.17] Remove draft plan files: Delete `plans/modernize-config.md` and `plans/modernize-config-2.md`
- [ ] [P6.18] Final commit: `git commit -m "chore: final validation and cleanup"`
- [ ] [P6.19] Review all success criteria from plan: Verify each checkbox can be checked
- [ ] [P6.20] Create git tag for milestone: `git tag -a v2.0-modern -m "Modernized dotfiles configuration"`

**Checkpoints:**

- [ ] Self-review: All tests passing, all features working, no obsolete references remain
- [ ] Comprehensive test: Every preserved feature verified working
- [ ] Docker test: Clean install passes all automated checks
- [ ] Success criteria: Review plan success criteria, verify all met
- [ ] Review: Confirm phase deliverable achieved (complete, tested, production-ready setup)

**Phase 6 Complete:** Dotfiles fully modernized, tested, and validated. All obsolete configs removed, modern tools integrated, comprehensive documentation in place. Ready for daily use.
