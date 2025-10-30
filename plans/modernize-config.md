# Dotfiles Modernization Plan

## Overview
Comprehensive modernization of dotfiles repository to remove obsolete configurations, migrate to modern tools, and establish a clean, maintainable setup for coding and terminal workflows.

## Current State Analysis
- **Dotbot**: Already configured and working
- **Zsh**: Using Antigen plugin manager (to be replaced)
- **Neovim**: VimScript-based with vim-plug (needs modernization)
- **Bash**: Full setup present (to be removed)
- **Python**: Both pyenv and conda configured (to be removed)
- **Other**: tmux (needs updates), taskwarrior (to be removed), VSCode (to be removed)

---

## Phase 1: Cleanup & Removal
**Goal:** Remove obsolete configurations and simplify structure

### 1.1 Remove Bash Configuration
- Delete `bash/` directory entirely
- Remove bash-related symlinks from `install.conf.yaml`:
  - `~/.bash_profile`
  - Any other bash references

### 1.2 Remove Python Environment Setup
- Delete `install_pyenv.sh` script
- Remove pyenv/conda installation steps from `install.conf.yaml`
- Clean up references in shell configs:
  - `.zshrc`: Remove pyenv init, conda init
  - `zsh/env.zsh`: Remove Python-related PATH modifications
  - `zsh/base.zsh`: Remove Python-related aliases/functions
- Remove Python environment variables (PYENV_ROOT, etc.)

### 1.3 Remove Unused Configurations
- Delete `.taskrc` and remove taskwarrior from `install.conf.yaml`
- Delete `vscode/` directory and remove from `install.conf.yaml`
- Review and clean `.global_gitignore`:
  - Remove Python-specific entries (if any)
  - Remove IDE-specific entries for unused editors
  - Keep generic useful patterns

### 1.4 Commit Changes
```bash
git add -A
git commit -m "cleanup: remove bash, python env, taskwarrior, and vscode configs"
```

---

## Phase 2: Zsh Modernization
**Goal:** Migrate from Antigen to Antidote for better performance and maintainability

### 2.1 Plugin Migration Table

Current setup uses Antigen with 12 active plugins from oh-my-zsh and external sources. Antidote provides the same functionality with better performance.

| Current Plugin | Functionality | Antidote Equivalent | Status | Notes |
|----------------|---------------|---------------------|--------|-------|
| **Core oh-my-zsh** |
| oh-my-zsh library | Core functions & aliases | ✅ `ohmyzsh/ohmyzsh path:lib` | Keep | Same, just different syntax |
| **oh-my-zsh Plugins** |
| `git` | Git aliases & functions | ✅ `ohmyzsh/ohmyzsh path:plugins/git` | Keep | Essential git shortcuts |
| `vi-mode` | Vi keybindings in shell | ✅ `ohmyzsh/ohmyzsh path:plugins/vi-mode` | Keep | Vim-style editing |
| `zsh-autosuggestions` | Command suggestions from history | ✅ `zsh-users/zsh-autosuggestions` | Keep | Fish-like autosuggestions |
| `heroku` | Heroku CLI completions | ⚠️ `ohmyzsh/ohmyzsh path:plugins/heroku` | Optional | Remove if not using Heroku |
| ~~`pip`~~ | Python pip completions | ❌ Commented out | Remove | Not needed without Python env |
| ~~`command-not-found`~~ | Suggests packages for missing commands | ❌ Commented out | Remove | Not in use |
| **External Plugins** |
| `djui/alias-tips` | Shows alias suggestions for commands | ✅ `djui/alias-tips` | Keep | Helps learn/remember aliases |
| `z-shell/F-Sy-H` | Fast syntax highlighting | ✅ `z-shell/F-Sy-H` | Keep | Better than zsh-syntax-highlighting |
| `junegunn/fzf` | Fuzzy finder | ✅ `junegunn/fzf` | Keep | Essential fuzzy finding |
| `hschne/fzf-git` | Fzf integration with git | ✅ `hschne/fzf-git` | Keep | Fuzzy find branches, commits, etc. |
| `clvv/fasd` | Quick access to files/dirs | ⚠️ `clvv/fasd` or replace with `zoxide` | Replace | Fasd is unmaintained; zoxide is modern alternative |
| `jsahlen/tmux-vim-integration` | Open files in vim from tmux | ✅ `jsahlen/tmux-vim-integration.plugin.zsh` | Keep | Useful for tmux workflow |
| `zsh-users/zsh-completions` | Additional completion definitions | ✅ `zsh-users/zsh-completions` | Keep | More command completions |
| ~~`rupa/z`~~ | Jump to frequent directories | ❌ Commented out | Remove | Replaced by fasd |
| **Theme** |
| `candy` | oh-my-zsh theme | ✅ `ohmyzsh/ohmyzsh path:themes/candy.zsh-theme` | Keep | Current theme |

### 2.1.1 Plugin Count Summary
- **Current setup**: 12 active plugins (2 commented out)
- **Antidote setup**: Same plugins, different loading mechanism
- **Suggested change**: Replace `fasd` with `zoxide` for better performance

### 2.1.2 Recommended: Replace fasd with zoxide
`fasd` is no longer maintained (last update 2015). `zoxide` is a modern Rust-based alternative:

**Benefits of zoxide:**
- ✅ **Faster**: Written in Rust, much faster than fasd
- ✅ **Smarter**: Better frecency algorithm (frequency + recency)
- ✅ **Maintained**: Active development and updates
- ✅ **Compatible**: Drop-in replacement for `z` command
- ✅ **Cross-platform**: Works on Linux, macOS, Windows

**Migration:**
- Replace: `clvv/fasd` → `ajeetdsouza/zoxide`
- Commands: `z <query>` still works, `zi` for interactive selection
- Integration: Works with fzf automatically

### 2.2 Update Installation System
Modify `install.conf.yaml`:

**Remove Antigen:**
```yaml
# DELETE these lines:
- shell:
  - [curl -L git.io/antigen > ~/antigen.zsh, Installing Antigen]
```

**Add Antidote and zoxide:**
```yaml
# ADD these lines:
- shell:
  - [git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote, Installing Antidote]
  - [curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash, Installing zoxide]
```

### 2.3 Create Antidote Plugin File
Create `.zsh_plugins.txt` with plugin declarations (converted from `zsh/antigen_config.zsh`):

**Option A: With zoxide (Recommended)**
```bash
# ~/.dotfiles/.zsh_plugins.txt

# Core oh-my-zsh library
ohmyzsh/ohmyzsh path:lib

# oh-my-zsh plugins
ohmyzsh/ohmyzsh path:plugins/git
ohmyzsh/ohmyzsh path:plugins/vi-mode

# External plugins
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
djui/alias-tips
z-shell/F-Sy-H
jsahlen/tmux-vim-integration.plugin.zsh

# fzf integration
junegunn/fzf path:shell kind:fpath
hschne/fzf-git

# Directory jumping (modern alternative to fasd)
# Note: zoxide is installed via install.conf.yaml, not as zsh plugin

# Theme
ohmyzsh/ohmyzsh path:themes/candy.zsh-theme
```

**Option B: Keep fasd (if preferred)**
```bash
# Same as above, but add:
clvv/fasd
```

### 2.3.1 Install zoxide separately
Since zoxide is a binary (not a zsh plugin), install it system-wide:

```bash
# Install zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Or via package manager
# Ubuntu/Debian: sudo apt install zoxide
# Or: cargo install zoxide
```

### 2.4 Update .zshrc
Replace Antigen initialization with Antidote and add zoxide:

```bash
# OLD (remove):
source ~/antigen.zsh
source ~/.dotfiles/zsh/antigen_config.zsh
antigen apply

# NEW (add):
# Initialize Antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt

# Initialize zoxide (replaces fasd)
eval "$(zoxide init zsh)"

# Optional: Add fzf integration with zoxide
export _ZO_FZF_OPTS="--height 40% --layout=reverse --border"
```

**Remove old fasd configuration:**
```bash
# DELETE these lines from .zshrc or zsh config files:
source "/home/tordks/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/fasd/fasd.plugin.zsh"
# Any FZFZ_RECENT_DIRS_TOOL settings
```

### 2.5 Command Comparison: fasd vs zoxide

For reference, here's how commands translate:

| Task | fasd | zoxide |
|------|------|--------|
| Jump to directory | `z dirname` | `z dirname` |
| Interactive selection | `zz` (with fzf) | `zi` |
| List recent dirs | `d` | `zoxide query -l` |
| Jump to file's directory | `f filename` | N/A (zoxide is dir-only) |
| Add directory manually | `fasd -A /path` | `zoxide add /path` |
| Remove directory | N/A | `zoxide remove /path` |

**Note:** zoxide focuses only on directories (not files), which is simpler and faster.

### 2.6 Reorganize Zsh Config Files
Consolidate and clean up:
- Review `zsh/base.zsh`, `zsh/env.zsh`, `zsh/from_bashrc.zsh`
- Remove redundant/obsolete aliases and functions
- Remove Python-related settings (pyenv, conda)
- Remove heroku plugin if not in use
- Merge related configurations
- Add clear section comments
- Consider renaming for clarity:
  - `base.zsh` → `aliases.zsh`
  - `env.zsh` → `environment.zsh`

**Specific cleanups:**
- Remove fasd aliases (`a`, `s`, `d`, `f`, `sd`, `sf`, `z`, `zz`)
- Remove Python environment initialization
- Remove taskwarrior-related aliases
- Keep useful aliases: `xo`, `g` (git), ranger integration, etc.

### 2.7 Delete Obsolete Files
- Delete `zsh/antigen.zsh` (if present in zsh directory)
- Delete `zsh/antigen_config.zsh`
- Archive `zsh/from_bashrc.zsh` if fully migrated
- Remove any `.antigen/` directory from home

### 2.8 Test and Commit
```bash
# Test in new shell
zsh

# If working:
git add -A
git commit -m "feat: migrate from Antigen to Antidote for zsh plugin management"
```

---

## Phase 3: Neovim Modernization
**Goal:** Practical Python development and file editing setup using LazyVim

**Selected Approach: LazyVim**
- Pre-configured Neovim distribution with sensible defaults
- Python support out-of-the-box via "extras" system
- All modern features included (LSP, completion, treesitter)
- No Lua coding needed - just install and enable language support

### 3.1 Plugin Migration Table

Current setup uses vim-plug with 30+ plugins. LazyVim provides equivalent or better functionality through its curated plugin ecosystem.

| Current Plugin | Functionality | LazyVim Equivalent | Status | Notes |
|----------------|---------------|-------------------|--------|-------|
| **Git Integration** |
| `tpope/vim-fugitive` | Git commands in Vim | ✅ **Included by default** | Keep | LazyVim includes fugitive |
| `airblade/vim-gitgutter` | Show git diff in gutter | ✅ `lewis6991/gitsigns.nvim` | Replace | Better, Lua-native alternative |
| `Xuyuanp/nerdtree-git-plugin` | Git status in NERDTree | ✅ Built into neo-tree | Replace | neo-tree has native git integration |
| **Completion & LSP** |
| `Shougo/deoplete.nvim` | Async completion | ✅ `hrsh7th/nvim-cmp` | Replace | Native, faster, better maintained |
| `zchee/deoplete-jedi` | Python completion | ✅ `pyright` LSP | Replace | LSP-based, more accurate |
| `davidhalter/jedi-vim` | Python goto/docs | ✅ Native LSP | Replace | Built into LSP workflow |
| `dense-analysis/ale` | Linting & formatting | ✅ `conform.nvim` + `nvim-lint` | Replace | Modern, async alternatives |
| **Snippets** |
| `SirVer/ultisnips` | Snippet engine | ✅ `L3MON4D3/LuaSnip` | Replace | Lua-native, better integration |
| `honza/vim-snippets` | Snippet collection | ✅ `rafamadriz/friendly-snippets` | Replace | Works with LuaSnip |
| **File Navigation** |
| `scrooloose/nerdtree` | File tree sidebar | ✅ `nvim-neo-tree/neo-tree.nvim` | Replace | Modern, Lua-native, better UI |
| `junegunn/fzf` | Fuzzy finder | ✅ `nvim-telescope/telescope.nvim` | Replace | More powerful, native integrations |
| `junegunn/fzf.vim` | Fzf Vim integration | ✅ Telescope | Replace | Telescope is more feature-rich |
| **UI & Statusline** |
| `itchyny/lightline.vim` | Status line | ✅ `nvim-lualine/lualine.nvim` | Replace | Better performance, more features |
| `maximbaz/lightline-ale` | ALE integration | ✅ Built into lualine | Replace | LSP diagnostics in lualine by default |
| `sjl/gundo.vim` | Undo tree viewer | ✅ `mbbill/undotree` | Replace | Included in LazyVim, better maintained |
| **Editing & Motions** |
| `tpope/vim-surround` | Surround text objects | ✅ `kylechui/nvim-surround` | Replace | Lua-native, more features |
| `tpope/vim-repeat` | Repeat plugin maps | ✅ **Included by default** | Keep | Still best solution |
| `scrooloose/nerdcommenter` | Comment toggling | ✅ `numToStr/Comment.nvim` or `echasnovski/mini.comment` | Replace | LazyVim uses mini.comment |
| `svermeulen/vim-yoink` | Yank history | ✅ `gbprod/yanky.nvim` | Replace | Modern alternative with better UI |
| `godlygeek/tabular` | Text alignment | ✅ `echasnovski/mini.align` | Replace | Part of mini.nvim suite |
| `christoomey/vim-tmux-navigator` | Tmux pane navigation | ✅ **Can be added** | Keep | LazyVim supports this plugin |
| `unblevable/quick-scope` | Highlight jump targets | ✅ `folke/flash.nvim` | Replace | Much more powerful motion plugin |
| **Language Support** |
| `lervag/vimtex` | LaTeX support | ✅ **Can be added** | Optional | Enable `lazyvim.plugins.extras.lang.tex` |
| `vim-pandoc/vim-pandoc` | Pandoc integration | ⚠️ Manual add if needed | Optional | Not in LazyVim by default |
| `vim-pandoc/vim-pandoc-syntax` | Pandoc syntax | ⚠️ Manual add if needed | Optional | Not in LazyVim by default |
| `plasticboy/vim-markdown` | Markdown support | ✅ Built-in + `extras.lang.markdown` | Replace | Better treesitter-based support |
| `fisadev/vim-isort` | Python import sorting | ✅ `conform.nvim` with isort | Replace | Integrated into formatter |
| **Colorschemes** |
| `morhetz/gruvbox` | Gruvbox theme | ✅ `ellisonleao/gruvbox.nvim` | Replace | Lua port with better support |
| `256-jungle` | Color scheme | ❌ Not needed | Remove | Use modern alternatives |
| `neodark.vim` | Color scheme | ❌ Not needed | Remove | LazyVim includes many themes |
| **Misc** |
| `tpope/vim-obsession` | Session management | ✅ `folke/persistence.nvim` | Replace | Better session management |
| `majutsushi/tagbar` | Tag browser | ✅ `aerial.nvim` or LSP symbols | Replace | Aerial is more modern |
| `powerman/vim-plugin-AnsiEsc` | ANSI color support | ⚠️ Manual add if needed | Optional | Rarely needed |
| ~~`vimwiki/vimwiki`~~ | Note taking | ❌ Commented out | Remove | Not in use |
| ~~`tbabej/taskwiki`~~ | Taskwarrior integration | ❌ Commented out | Remove | Not in use |
| ~~`blindFS/vim-taskwarrior`~~ | Taskwarrior interface | ❌ Commented out | Remove | Not in use |

### 3.1.1 Plugin Count Summary
- **Current setup**: 30 plugins (excluding commented)
- **LazyVim base**: ~50 plugins (pre-configured, optimized)
- **Result**: More features with better performance (lazy loading)

### 3.1.2 What You Gain with LazyVim
- ✅ **Treesitter**: Better syntax highlighting for all languages
- ✅ **Native LSP**: Go to definition, hover docs, diagnostics
- ✅ **Telescope**: Powerful fuzzy finding with live preview
- ✅ **Which-key**: Discover keybindings as you type
- ✅ **Better UI**: Modern file explorer, floating windows
- ✅ **Auto-completion**: Context-aware with LSP integration
- ✅ **Git integration**: Blame, diff view, git signs
- ✅ **Performance**: Lazy loading, faster startup

### 3.2 Archive Old Configuration
Move current nvim config to archive within dotfiles:

```bash
# Create archive directory in dotfiles
mkdir -p ~/.dotfiles/nvim/archive

# Move old configs to archive
mv ~/.dotfiles/nvim/init.vim ~/.dotfiles/nvim/archive/
mv ~/.dotfiles/nvim/plugins.vim ~/.dotfiles/nvim/archive/
mv ~/.dotfiles/nvim/*.vim ~/.dotfiles/nvim/archive/ 2>/dev/null || true
mv ~/.dotfiles/nvim/coc-settings.json ~/.dotfiles/nvim/archive/ 2>/dev/null || true

# Backup nvim data directories
mv ~/.local/share/nvim ~/.local/share/nvim.backup 2>/dev/null || true
mv ~/.local/state/nvim ~/.local/state/nvim.backup 2>/dev/null || true
mv ~/.cache/nvim ~/.cache/nvim.backup 2>/dev/null || true
```

### 3.3 Install LazyVim Starter
Clone LazyVim starter template into dotfiles:

```bash
# Clone LazyVim starter to dotfiles
git clone https://github.com/LazyVim/starter ~/.dotfiles/nvim/
rm -rf ~/.dotfiles/nvim/.git

# Update symlink (already configured in install.conf.yaml)
# Verify this line exists:
# ~/.config/nvim: nvim/
```

### 3.4 Enable Language Support Extras
LazyVim uses an "extras" system for language support. Add language extras:

**Edit `nvim/lua/config/lazy.lua`:**
Add at the top of the file (before the main plugins spec):
```lua
return {
  -- Import language extras
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.yaml" },

  -- Import additional useful extras
  { import = "lazyvim.plugins.extras.formatting.black" },  -- Python formatter
  { import = "lazyvim.plugins.extras.linting.eslint" },   -- If using JS/TS
  { import = "lazyvim.plugins.extras.ui.mini-animate" },  -- Smooth animations

  -- Your custom plugins can go after this
  -- { import = "plugins" },  -- This imports from lua/plugins/*.lua
}
```

### 3.5 Optional: Add vim-tmux-navigator Plugin
To keep tmux integration, add custom plugin:

**Create `nvim/lua/plugins/tmux.lua`:**
```lua
return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
  },
}
```

### 3.6 Optional: Customize Settings
**Edit `nvim/lua/config/options.lua`** to add personal preferences:
```lua
-- Add these lines at the end
local opt = vim.opt

opt.relativenumber = false  -- Use absolute line numbers
opt.wrap = true             -- Enable line wrapping for writing
opt.colorcolumn = "80"      -- Show column marker at 80 chars
opt.scrolloff = 8           -- Keep 8 lines visible above/below cursor
```

### 3.7 Optional: Set Gruvbox Theme
**Edit `nvim/lua/config/lazy.lua`** to set colorscheme:
```lua
-- Add to the colorscheme section (usually near line 10-15)
{
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "gruvbox",  -- Set default theme to gruvbox
  },
}
```

### 3.8 Update Installation Script
Replace `setup_nvim.sh` with new version:

```bash
#!/bin/bash
# Install latest stable Neovim (0.9.0+)

echo "Installing Neovim..."

# Method 1: Use PPA (recommended for Ubuntu/Debian)
if command -v apt &> /dev/null; then
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install neovim -y
fi

# Method 2: Use AppImage (universal Linux)
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# chmod u+x nvim.appimage
# sudo mv nvim.appimage /usr/local/bin/nvim

# Install dependencies
echo "Installing Python development tools..."
if command -v pip &> /dev/null; then
    pip install --user black ruff isort flake8
fi

# Install ripgrep and fd (required for Telescope)
if command -v apt &> /dev/null; then
    sudo apt install ripgrep fd-find -y
fi

echo "Neovim installation complete!"
echo "Run 'nvim' to start LazyVim and auto-install plugins"
echo "First launch will take a moment to download and configure plugins"
```

Make it executable:
```bash
chmod +x ~/.dotfiles/setup_nvim.sh
```

### 3.9 Update install.conf.yaml
Ensure the install.conf.yaml includes the nvim setup script:

```yaml
- shell:
  - [bash ~/.dotfiles/setup_nvim.sh, Setting up Neovim]
```

### 3.10 File Format Support (Built-in)
LazyVim with enabled extras supports:

**Fully Supported Formats:**
- **Python** (.py) - LSP (pyright), formatting (black/ruff), linting
- **Markdown** (.md) - Syntax, preview, formatting, inline code highlighting
- **JSON** (.json) - Validation, formatting, JSON schema support
- **YAML** (.yaml) - Syntax, validation, Kubernetes support
- **Shell** (.sh, .zsh, .bash) - Syntax highlighting, shellcheck
- **Git** (commit messages, diffs) - Syntax and formatting
- **Lua** (.lua) - Full LSP support (for nvim config)
- **TOML** (.toml) - Syntax and validation
- **Dockerfile** - Syntax highlighting

### 3.11 Test Installation
```bash
# Run LazyVim for first time
nvim

# LazyVim will:
# 1. Show a dashboard
# 2. Auto-install all plugins in background
# 3. Install Mason tool managers
# 4. Download LSP servers (pyright for Python)

# Check health after installation
:checkhealth

# Test Python functionality
echo "def hello(): print('world')" > test.py
nvim test.py
# Try these:
# - Type and see completion
# - Press 'K' on a symbol for docs
# - Press 'gd' to go to definition
# - Press '<space>cf' to format
```

### 3.12 Commit Changes
```bash
cd ~/.dotfiles
git add -A
git commit -m "feat: migrate to LazyVim for modern Python development

- Replace vim-plug with lazy.nvim
- Enable Python, Markdown, JSON, YAML language support
- Replace 30+ manual plugins with curated LazyVim setup
- Add vim-tmux-navigator for tmux integration
- Archive old VimScript configuration
- Update installation script for dependencies"
```

### 3.13 Key Bindings Reference
Document these essential LazyVim keybindings:

**General:**
- `<space>` - Leader key (shows which-key menu)
- `<space>l` - Open Lazy plugin manager
- `<space>:` - Command history
- `<space><space>` - Find files in cwd

**File Navigation:**
- `<space>e` - Toggle file explorer (neo-tree)
- `<space>fe` - Toggle file explorer with current file
- `<space>ff` - Find files (Telescope)
- `<space>fr` - Recent files
- `<space>fg` - Find files (git files)
- `<space>fb` - Find buffers

**Search:**
- `<space>sg` - Search in files (live grep)
- `<space>sw` - Search word under cursor
- `<space>sh` - Search help
- `<space>sk` - Search keymaps

**Code (LSP):**
- `K` - Hover documentation
- `gd` - Go to definition
- `gr` - Go to references
- `gD` - Go to declaration
- `gI` - Go to implementation
- `<space>ca` - Code actions
- `<space>cr` - Rename symbol
- `<space>cf` - Format code
- `]d` / `[d` - Next/prev diagnostic

**Git:**
- `<space>gg` - LazyGit (full TUI)
- `<space>gb` - Git blame line
- `<space>gf` - LazyGit current file history
- `]h` / `[h` - Next/prev git hunk

**Windows/Buffers:**
- `<C-h/j/k/l>` - Navigate splits (with tmux integration)
- `<space>-` - Split window below
- `<space>|` - Split window right
- `<space>bd` - Delete buffer
- `<Tab>` / `<S-Tab>` - Next/prev buffer

**Misc:**
- `<space>qq` - Quit all
- `<space>qs` - Save session
- `<space>ur` - Toggle relative line numbers
- `<space>uw` - Toggle line wrap

---

## Phase 4: Tmux Modernization
**Goal:** Update tmux config for tmux 3.x features

### 4.1 Review Current Configuration
Audit `.tmux.conf` for:
- Deprecated options
- Compatibility with tmux 3.x+
- Optimization opportunities

### 4.2 Update tmux.conf
Key improvements:
- Verify mouse mode syntax (should be `set -g mouse on`)
- Update status bar with modern styling
- Add popup window bindings (tmux 3.2+)
- Improve color scheme for 24-bit color
- Add useful bindings:
  ```
  # Popup terminal
  bind-key g display-popup -E "tmux new-session -A -s scratch"

  # Better pane splitting
  bind | split-window -h -c "#{pane_current_path}"
  bind - split-window -v -c "#{pane_current_path}"
  ```

### 4.3 Update TPM and Plugins
Review plugin list:
- ✅ Keep: tmux-sensible, tmux-resurrect, tmux-continuum
- ✅ Keep: tmux-yank, tmux-copycat
- Consider adding:
  - tmux-fzf (fuzzy finder integration)
  - tmux-thumbs (better copy mode)

Update TPM installation in `install.conf.yaml`:
```yaml
- shell:
  - [git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm, Installing TPM]
```

### 4.4 Add Comments and Documentation
Add inline comments explaining:
- Key binding groups
- Plugin purposes
- Custom settings

### 4.5 Test and Commit
```bash
# Test tmux
tmux source ~/.tmux.conf

# If working:
git add -A
git commit -m "feat: modernize tmux config for v3.x+"
```

---

## Phase 5: Git & System Configuration Polish
**Goal:** Finalize and document the setup

### 5.1 Update .gitconfig
Improvements:
- Fix email address (currently `temp@temp.com`)
- Add modern git features:
  ```ini
  [init]
    defaultBranch = main
  [maintenance]
    auto = true
  [feature]
    manyFiles = true
  [core]
    fsmonitor = true
  ```
- Review and update aliases
- Add useful new aliases:
  ```ini
  [alias]
    recent = branch --sort=-committerdate --format='%(committerdate:short) %(refname:short)'
    undo = reset --soft HEAD^
    amend = commit --amend --no-edit
  ```

### 5.2 Update install.conf.yaml
Final polish:
- Organize into logical sections with comments
- Remove obsolete package installations:
  - taskwarrior
  - Python build dependencies (if not needed)
- Add new required packages:
  - neovim (latest)
  - tmux (3.x+)
  - ripgrep (rg, better than ag)
  - fd-find (modern find)
  - bat (better cat)
- Example structure:
  ```yaml
  # System Update
  # Shell Tools
  # Development Tools
  # Symlinks
  # Shell Configuration
  ```

### 5.3 Create/Update README.md
Include:
- **Quick Start**: Installation instructions
- **Dependencies**: Required packages and versions
- **Structure**: Directory layout explanation
- **Key Features**:
  - Zsh with Antidote
  - Neovim with native LSP
  - Tmux configuration
  - Git integration
- **Key Bindings**: Quick reference table
- **Customization**: How to extend
- **Troubleshooting**: Common issues

### 5.4 Add Inline Documentation
Add comments to config files:
- `.zshrc`: Explain each sourced file and section
- `nvim/init.lua`: Document structure and loading order
- `.tmux.conf`: Explain key binding groups

### 5.5 Final Testing
- Test fresh install in clean environment (VM or container)
- Verify all symlinks created correctly
- Check that all tools work post-install
- Document any manual steps needed

### 5.6 Final Commit
```bash
git add -A
git commit -m "docs: finalize modernization with updated configs and documentation"
```

---

## Summary of Changes

### Removed
- ❌ Bash configuration (entire `bash/` directory)
- ❌ Python environment setup (pyenv, conda)
- ❌ Taskwarrior configuration
- ❌ VSCode settings

### Migrated
- 🔄 Antigen → Antidote (zsh plugin manager)
- 🔄 Custom Neovim → LazyVim or CoC.nvim (pre-configured distributions)
- 🔄 ALE/deoplete → LSP-based completion (via LazyVim or CoC)

### Modernized
- ✨ Zsh: Faster plugin loading with Antidote, cleaner config
- ✨ Neovim: Ready-to-use Python development environment (no Lua coding required)
- ✨ Tmux: Updated for v3.x features
- ✨ Git: Modern features and aliases

### Kept
- ✅ Dotbot (installation framework)
- ✅ Zsh (primary shell)
- ✅ Git configuration (with updates)
- ✅ Tmux (with modernization)

---

## Estimated Time
- **Phase 1**: ~15 minutes (cleanup)
- **Phase 2**: ~30 minutes (zsh migration)
- **Phase 3**: ~30 minutes (neovim setup with LazyVim or CoC - simple install)
- **Phase 4**: ~20 minutes (tmux updates)
- **Phase 5**: ~25 minutes (polish and documentation)
- **Total**: ~2 hours

---

## Prerequisites
- Git access to repository
- Backup of current configs (if not in git)
- Time to test and iterate
- Willingness to adapt to new workflows

## Success Criteria
- [ ] All phases completed without breaking existing workflow
- [ ] Fresh install works in clean environment
- [ ] All tools launch without errors
- [ ] Documentation is clear and complete
- [ ] Configs are well-commented and maintainable
- [ ] Faster shell startup time (from Antidote)
- [ ] Python development working in Neovim (completion, linting, formatting)
- [ ] Common file formats (markdown, JSON, YAML) edit smoothly
- [ ] Clean commit history documenting changes

## Notes
- Take breaks between phases to test thoroughly
- Commit after each phase for easy rollback
- Keep old configs in `archive/` folders temporarily
- Test in new shell/tmux sessions after changes
- Consider creating git tags at major milestones
