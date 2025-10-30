# Summary of Changes for Modernize Config Plan v2

This document summarizes the key decisions and changes from the brainstorming session that should be incorporated into the updated modernization plan.

## Key Decisions Made

### 1. Python Environment Management
**Decision:** ✅ Remove all Python environment setup (pyenv/conda)
- **Rationale:** Now using `uv` for Python version management
- **Impact:** Remove pyenv/conda from all config files and installation scripts

### 2. Node.js/NVM
**Decision:** ✅ Remove NVM
- **Rationale:** Not needed for dotfiles setup, no active JS/TS development in dotfiles
- **Impact:** Remove NVM initialization from `.zshrc` (lines 86-88)

### 3. Mystery Configuration Line
**Decision:** ✅ Remove `. "$HOME/.local/bin/env"` from `.zshrc`
- **Impact:** Remove line 90 from `.zshrc`

### 4. Directory Navigation Tool
**Decision:** ✅ Migrate from fasd to zoxide (confirmed)
- **Rationale:** zoxide is modern, actively maintained, faster (Rust-based)
- **Status:** Already in original plan, now confirmed

### 5. Oh-My-Zsh
**Decision:** ✅ Keep oh-my-zsh (loaded via Antidote)
- **Rationale:** Provides mature git plugin, vi-mode, and core utilities
- **Architecture:** Load selectively through Antidote

### 6. ranger File Manager
**Decision:** ✅ Remove ranger integration
- **Impact:** Remove from `zsh/from_bashrc.zsh`:
  - Ctrl-O keybinding (lines 38-40)
  - ranger function with cd integration (lines 47-52)

---

## Zsh Plugin Changes

### Plugins to Remove
- ❌ `heroku` - Not installed, not used
- ❌ `clvv/fasd` - Replaced by zoxide
- ❌ `hschne/fzf-git` - Replaced by forgit

### Plugins to Add
- ✨ `Aloxaf/fzf-tab` - Fuzzy completion menu (modern enhancement)
- ✨ `wfxr/forgit` - Better maintained, more features than fzf-git

### Plugins to Keep (Confirmed)
- ✅ `djui/alias-tips` - User finds helpful
- ✅ `jsahlen/tmux-vim-integration.plugin.zsh` - Actively used

### Final Plugin List (11 plugins + theme)

**Oh-my-zsh (via Antidote):**
1. `ohmyzsh/ohmyzsh path:lib`
2. `ohmyzsh/ohmyzsh path:plugins/git`
3. `ohmyzsh/ohmyzsh path:plugins/vi-mode`

**External plugins:**
4. `zsh-users/zsh-autosuggestions`
5. `zsh-users/zsh-completions`
6. `djui/alias-tips`
7. `z-shell/F-Sy-H`
8. `Aloxaf/fzf-tab` ← NEW
9. `junegunn/fzf`
10. `wfxr/forgit` ← REPLACES hschne/fzf-git
11. `jsahlen/tmux-vim-integration.plugin.zsh`

**Theme:**
12. `ohmyzsh/ohmyzsh path:themes/candy.zsh-theme`

**Separately installed:**
- `zoxide` (binary, not zsh plugin)

---

## Alias Changes

### Remove/Fix
1. **Duplicate ls alias:**
   - Remove from `base.zsh`: `alias 'ls=ls --color=auto'`
   - Keep from `from_bashrc.zsh`: `alias ls='ls --color=auto --group-directories-first'`

2. **Fix grep alias:**
   - Change: `alias 'grep=grep --colour=always --line-number --devices=skip'`
   - To: `alias 'grep=grep --colour=auto --devices=skip'`
   - Reason: `--colour=always` breaks piping; `--line-number` not always wanted

3. **Remove custom git alias:**
   - Remove from `from_bashrc.zsh`: `compdef g='git'` and `alias g=git`
   - Reason: oh-my-zsh git plugin already provides this

4. **Trim ls aliases:**
   - Keep only: `l`, `la`, `ll`, `lrt`
   - Remove: `llh`, `lq`, `lr`, `lrs`, `lrta`, `lrth`, `lrtha`
   - Reason: Excessive, rarely used variations

### Keep (Confirmed Important)
- ✅ `xo=xdg-open`
- ✅ `python=python3`
- ✅ `EDITOR=nvim`
- ✅ Safety aliases: `rm -i`, `mv -i`, `cp -i`
- ✅ `mkdir=mkdir -p`
- ✅ `cd..=cd ..` (typo fix)
- ✅ `L='less'`
- ✅ `sudo='sudo '` (allows aliases after sudo)

### Functions to Keep
- ✅ `mkcd` - Create and cd into directory
- ✅ `qf` - Quick find
- ✅ `zh` - History search with regex
- ✅ `rationalise-dot` - Auto-expand ... to ../..
- ✅ `alert` - Desktop notification for command completion

### Zsh Autoloads to Keep
- ✅ `zmv` - Advanced file renaming
- ✅ `zcalc` - Calculator
- ✅ `zargs` - xargs for zsh
- ✅ `zed` - Line editor

---

## Neovim Plugin Changes

### Remove These Plugins
- ❌ `lervag/vimtex` - Not writing LaTeX
- ❌ `vim-pandoc/vim-pandoc` - Not using Pandoc
- ❌ `vim-pandoc/vim-pandoc-syntax` - Not using Pandoc
- ❌ `powerman/vim-plugin-AnsiEsc` - Not needed
- ❌ `vim-scripts/256-jungle` - Obsolete colorscheme
- ❌ `KeitaNakamura/neodark.vim` - Obsolete colorscheme

### Keep/Add to LazyVim
- ✅ `christoomey/vim-tmux-navigator` - Actively used for tmux integration
- ✅ `gruvbox` - Use Lua version: `ellisonleao/gruvbox.nvim`

### LazyVim Extras to Enable
```lua
{ import = "lazyvim.plugins.extras.lang.python" }
{ import = "lazyvim.plugins.extras.lang.markdown" }
{ import = "lazyvim.plugins.extras.lang.json" }
{ import = "lazyvim.plugins.extras.lang.yaml" }
```

### All Other Plugins Replaced by LazyVim
The remaining 24 plugins are fully replaced by LazyVim's built-in equivalents:
- Git: gitsigns, fugitive, LazyGit
- Completion: nvim-cmp + LSP
- File navigation: Telescope, neo-tree
- Editing: mini.nvim suite, flash.nvim, yanky.nvim, nvim-surround
- UI: lualine, undotree
- Snippets: LuaSnip + friendly-snippets

---

## Critical Issues Identified

### 1. Neovim Version Too Old
**Current:** v0.6.1
**Required:** v0.9.0+ (for LazyVim)
**Action:** Must upgrade Neovim before Phase 3
- Recommend: AppImage or neovim-ppa/unstable

### 2. Git Config Email
**Original plan stated:** Fix `temp@temp.com`
**Actual state:** Already correct (`tordks@hotmail.com`)
**Action:** No change needed - remove this from plan

### 3. Conda Currently Active
**Original plan:** Remove Python environments
**Actual state:** `.zshrc` has active conda initialization (lines 70-82)
**Action:** Confirmed removal - user now uses `uv`

---

## New Sections to Add

### Future Improvements (Post-Modernization)
Add section documenting potential future enhancements:

1. **Starship Prompt**
   - Replace oh-my-zsh candy theme
   - Benefits: Faster (Rust), prettier, more customizable
   - Cross-shell compatible

2. **bat** - Modern cat replacement
   - Syntax highlighting for file viewing
   - Git integration, line numbers
   - Drop-in replacement

3. **eza** - Modern ls replacement
   - Better colors, git integration, icons
   - Could simplify/replace many ls aliases
   - Tree view built-in

---

## Updated Phase Breakdown

### Phase 1: Cleanup & Removal
**Additions to original plan:**
- Remove NVM initialization from `.zshrc`
- Remove `. "$HOME/.local/bin/env"` from `.zshrc`
- Remove ranger integration from `zsh/from_bashrc.zsh`
- More specific alias cleanup (documented above)

### Phase 2: Zsh Modernization
**Changes to original plan:**
- Update plugin list (remove 3, add 2)
- Add specific alias trimming/fixes
- Keep alias-tips and tmux-vim-integration (confirmed)
- Explicitly document custom configurations to preserve

### Phase 3: Neovim Modernization
**Changes to original plan:**
- Remove vimtex, vim-pandoc plugins (confirmed not needed)
- Remove vim-plugin-AnsiEsc
- Remove old colorschemes (256-jungle, neodark)
- Add critical note about Neovim version upgrade requirement

### Phase 4: Tmux Modernization
**No changes** - original plan is good

### Phase 5: Polish & Documentation
**Additions:**
- Document future improvements section
- Remove git email fix (already correct)

---

## Installation Dependencies Update

### Remove from install.conf.yaml
- pyenv installation and prerequisites
- NVM installation
- Heroku-related packages (if any)
- Taskwarrior

### Ensure These Are Included
- zoxide installation
- Neovim 0.9.0+ (update setup_nvim.sh)
- ripgrep (for Telescope)
- fd-find (for Telescope)
- git (modern version)

### New Installation Flow
```yaml
# Zsh setup
- [git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote, Installing Antidote]
- [curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash, Installing zoxide]

# Remove old Antigen installation line
# Remove pyenv installation section
```

---

## Configuration File Organization

### .zshrc Structure
**Current issues:**
- Conda initialization (remove)
- NVM initialization (remove)
- Local bin env source (remove)
- fasd initialization (replace with zoxide)

**New structure:**
```bash
# Environment variables
source ~/.zsh/env.zsh

# Antidote plugin manager
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt

# Custom aliases and functions
source ~/.zsh/base.zsh
source ~/.zsh/from_bashrc.zsh

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_ALT_C_COMMAND="fd --type d . $HOME"
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

# zoxide (replaces fasd)
eval "$(zoxide init zsh)"

# Other configurations
export XDG_CONFIG_HOME=~/.config
```

---

## Testing Checklist Updates

### Additional Tests Needed
- [ ] Verify zoxide works (`z` command)
- [ ] Verify forgit commands work
- [ ] Verify fzf-tab completion works
- [ ] Verify NVM removal doesn't break anything
- [ ] Test Neovim LSP for Python
- [ ] Verify vim-tmux-navigator works in LazyVim
- [ ] Confirm all preserved aliases work
- [ ] Test custom functions (mkcd, qf, zh, rationalise-dot)

---

## Success Criteria Updates

**Add:**
- [ ] Neovim version is 0.9.0+
- [ ] zoxide z command works
- [ ] forgit commands accessible
- [ ] fzf-tab provides fuzzy completion
- [ ] No references to NVM, pyenv, conda in configs
- [ ] ranger integration removed
- [ ] LazyVim Python development works (LSP, completion, formatting)
- [ ] vim-tmux-navigator works in LazyVim
- [ ] All critical aliases and functions preserved

---

## Estimated Time Adjustments

**Original:** ~2 hours total

**Adjusted:**
- Phase 1: ~20 minutes (more specific removals)
- Phase 2: ~40 minutes (plugin changes, alias cleanup)
- Phase 3: ~45 minutes (includes Neovim upgrade + LazyVim setup)
- Phase 4: ~20 minutes (unchanged)
- Phase 5: ~30 minutes (additional documentation)
- **Total: ~2.5 hours**

Note: Neovim upgrade may add time depending on method chosen

---

## Summary of Changes from Original Plan

### Major Additions
1. Remove NVM and local bin env source
2. Remove ranger integration
3. Add fzf-tab and forgit plugins
4. Specific alias cleanup documented
5. Remove 3 additional Neovim plugins
6. Future improvements section
7. Critical Neovim version upgrade requirement

### Confirmations
1. ✅ Remove Python environments (using uv)
2. ✅ Migrate to zoxide
3. ✅ Keep oh-my-zsh
4. ✅ LazyVim approach
5. ✅ Keep specific plugins (alias-tips, tmux-vim-integration)

### Corrections
1. Git email already correct - no change needed
2. Conda is currently active (not commented) - needs removal

---

## Docker Testing Setup

### Overview
Add Docker-based testing to verify dotfiles installation works in a clean environment before and after modernization.

### Files to Create

#### 1. `Dockerfile`
```dockerfile
# Dockerfile for testing dotfiles installation
FROM ubuntu:22.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    sudo \
    zsh \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create a test user (similar to real usage)
RUN useradd -m -s /bin/zsh testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Copy dotfiles into container
COPY --chown=testuser:testuser . /home/testuser/.dotfiles

# Set working directory to dotfiles
WORKDIR /home/testuser/.dotfiles

# Run the dotbot installation
CMD ["./install"]
```

#### 2. `test-docker.sh`
```bash
#!/bin/bash
# Test script for dotfiles installation in Docker

set -e  # Exit on error

echo "======================================"
echo "Dotfiles Installation Test"
echo "======================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Build the Docker image
echo -e "${YELLOW}Building Docker image...${NC}"
docker build -t dotfiles-test .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Docker image built successfully${NC}"
else
    echo -e "${RED}✗ Failed to build Docker image${NC}"
    exit 1
fi

echo ""

# Run the installation
echo -e "${YELLOW}Running dotbot installation...${NC}"
docker run --rm dotfiles-test

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Installation completed successfully${NC}"
else
    echo -e "${RED}✗ Installation failed${NC}"
    exit 1
fi

echo ""

# Run verification tests
echo -e "${YELLOW}Running verification tests...${NC}"
docker run --rm dotfiles-test /bin/zsh -c "
    set -e

    # Test 1: Check if .zshrc exists
    echo 'Test 1: Checking .zshrc symlink...'
    if [ -L ~/.zshrc ]; then
        echo '  ✓ .zshrc symlink exists'
    else
        echo '  ✗ .zshrc symlink missing'
        exit 1
    fi

    # Test 2: Check if .gitconfig exists
    echo 'Test 2: Checking .gitconfig symlink...'
    if [ -L ~/.gitconfig ]; then
        echo '  ✓ .gitconfig symlink exists'
    else
        echo '  ✗ .gitconfig symlink missing'
        exit 1
    fi

    # Test 3: Check if .tmux.conf exists
    echo 'Test 3: Checking .tmux.conf symlink...'
    if [ -L ~/.tmux.conf ]; then
        echo '  ✓ .tmux.conf symlink exists'
    else
        echo '  ✗ .tmux.conf symlink missing'
        exit 1
    fi

    # Test 4: Check if nvim config directory exists
    echo 'Test 4: Checking nvim config...'
    if [ -d ~/.config/nvim ]; then
        echo '  ✓ nvim config directory exists'
    else
        echo '  ✗ nvim config directory missing'
        exit 1
    fi

    # Test 5: Check if zsh directory exists
    echo 'Test 5: Checking zsh config...'
    if [ -d ~/.zsh ]; then
        echo '  ✓ zsh config directory exists'
    else
        echo '  ✗ zsh config directory missing'
        exit 1
    fi

    # Test 6: Check if antidote was installed (after modernization)
    echo 'Test 6: Checking antidote installation...'
    if [ -d ~/.antidote ]; then
        echo '  ✓ antidote directory exists'
    else
        echo '  ⚠ antidote directory missing (expected before modernization)'
    fi

    # Test 7: Check if zoxide was installed (after modernization)
    echo 'Test 7: Checking zoxide installation...'
    if command -v zoxide &> /dev/null; then
        echo '  ✓ zoxide is installed'
    else
        echo '  ⚠ zoxide not installed (expected before modernization)'
    fi

    echo ''
    echo 'All critical tests passed!'
"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ All verification tests passed${NC}"
else
    echo -e "${RED}✗ Some verification tests failed${NC}"
    exit 1
fi

echo ""
echo "======================================"
echo -e "${GREEN}All tests completed successfully!${NC}"
echo "======================================"
```

Make executable: `chmod +x test-docker.sh`

#### 3. `.dockerignore`
```
# Don't copy these into the Docker image
.git
.github
*.md
plans/
.claude/

# Vim/Neovim temporary files
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db

# Cache directories
__pycache__/
*.pyc
.cache/
```

### Usage

**Run tests:**
```bash
./test-docker.sh
```

**Manual testing:**
```bash
# Build image
docker build -t dotfiles-test .

# Run installation
docker run --rm -it dotfiles-test

# Interactive shell (for debugging)
docker run --rm -it dotfiles-test /bin/zsh
```

### Test Phases

**Pre-Modernization:**
- Test current setup works in clean environment
- Verify all symlinks created
- Document any existing issues

**During Each Phase:**
- Test after each major change
- Verify no regressions
- Ensure new tools install correctly

**Post-Modernization:**
- Full integration test
- Verify all new plugins work
- Test Neovim LazyVim setup
- Confirm zoxide, antidote functional

### Additional Tests to Add Later

```bash
# Test 8: Verify zsh plugins loaded
zsh -c "antidote list" | grep -q "zsh-autosuggestions"

# Test 9: Verify zoxide works
zsh -c "eval \$(zoxide init zsh) && which z"

# Test 10: Verify LazyVim installed
nvim --headless "+Lazy! sync" +qa

# Test 11: Test custom aliases
zsh -c "alias | grep -q 'xo=xdg-open'"

# Test 12: Test custom functions
zsh -c "type mkcd | grep -q 'mkcd is a shell function'"
```

### Benefits

1. **Safe testing** - Test in isolated environment
2. **Reproducible** - Same results every time
3. **CI/CD ready** - Can add to GitHub Actions later
4. **Documentation** - Tests serve as documentation
5. **Confidence** - Know changes work before applying to real system

---

## Next Steps

1. Create Docker testing files (Dockerfile, test-docker.sh, .dockerignore)
2. Run initial test with current setup (baseline)
3. Update `plans/modernize-config.md` with these changes
4. Create `.zsh_plugins.txt` with final plugin list
5. Update installation scripts (remove pyenv, NVM; add zoxide)
6. Plan Neovim upgrade strategy
7. Begin Phase 1 execution with Docker testing after each phase
