# Dotfiles

Zsh + Neovim + tmux configuration with Antidote plugin manager, Starship prompt, and LazyVim.

## Installation

```bash
git clone https://github.com/tordks/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The install script:
- Creates symlinks for all config files
- Prompts for Git identity (stored in `.gitconfig.local`)
- Installs: zsh, antidote, zoxide, fzf, Starship, tmux + TPM, neovim
- Sets zsh as default shell


## Zsh Setup

Plugins managed by [Antidote](https://github.com/mattmc3/antidote). See `.zsh_plugins.txt`.

| Plugin | Purpose | Key Shortcuts |
|--------|---------|---------------|
| zsh-vi-mode | Vi-mode editing | `ESC` normal mode, `i` insert, `/` search history |
| zsh-autosuggestions | Fish-like suggestions | `→` accept suggestion |
| zsh-completions | Extended completions | - |
| alias-tips | Shows available aliases | Automatic |
| F-Sy-H | Syntax highlighting | - |
| fzf | Fuzzy finder | `Ctrl+R` history, `Ctrl+T` files, `Alt+C` cd |
| fzf-tab | FZF in tab completion | `TAB` |
| forgit | Git + FZF interface | See [Git Commands](#git-commands) |

### Custom Shortcuts

**Aliases** (see `.zshrc` for full list):

| Alias | Description |
|-------|-------------|
| `g` | git (with full completion) |
| `l` / `ll` / `la` | ls variants (long, all, hidden) |
| `lrt` | ls sorted by modification time |
| `rm` / `mv` / `cp` | Confirmation prompts (safety) |
| `xo` | xdg-open |

**Functions:**

| Function | Description |
|----------|-------------|
| `z <path>` | Smart cd - jumps to frecent dirs (zoxide) |
| `zi` | Interactive directory picker with fzf |
| `mkcd <dir>` | mkdir + cd in one command |
| `qf <pattern>` | Quick find files (case-insensitive) |
| `rg <pattern>` | Fast recursive grep (ripgrep) - respects .gitignore |
| `zh <pattern>` | Search command history |
| `...` | Auto-expands to `../..` (and `....` to `../../..`) |

**ripgrep tips:** `rg -i` case-insensitive, `rg -l` files only, `rg -C3` with context, `rg -t py` filter by type.

```bash
rg "def main" --type py      # Find Python main functions
rg TODO -g "*.{js,ts}"       # Find TODOs in JS/TS files
```

For details, see `.zshrc` - organized with section headers.

## Tmux

Prefix: `C-a` (not default `C-b`)

| Action | Shortcut |
|--------|----------|
| Split vertical | `C-a \|` |
| Split horizontal | `C-a -` |
| Navigate panes | `C-h/j/k/l` (vim-aware) |
| Resize panes | `C-a H/J/K/L` |
| Next/prev window | `C-a C-n` / `C-a C-p` |
| Kill pane | `C-a x` |
| Save session | `C-a S` |
| Restore session | `C-a R` |

Plugins: tmux-sensible, tmux-resurrect, tmux-continuum, tmux-yank.

## Neovim

Uses [LazyVim](https://www.lazyvim.org) - plugins auto-install on first launch.

- Check plugin status: `:Lazy`
- Tmux integration: `C-h/j/k/l` works across tmux panes and vim splits

## VS Code

Settings and keybindings symlinked to `~/.config/Code/User/`.

Extensions are listed in `vscode/extensions.txt`. Install manually:
```bash
./vscode/install_extensions.sh
```

## Git Commands

Two patterns: `git <alias>` for standard commands, short aliases for fzf-powered interactive commands.

`git` is aliased to `g` for brevity.

### Standard Git Aliases (`.gitconfig`)

| Alias | Command | Description |
|-------|---------|-------------|
| `g s` | `status --short` | Compact status |
| `g st` | `status` | Full status |
| `g co` | `checkout` | Checkout |
| `g br` | `branch` | Branch |
| `g ci` | `commit --verbose` | Commit with diff preview |
| `g ap` | `add --patch` | Stage hunks interactively |
| `g au` | `add --update` | Stage tracked files |
| `g d` | `diff` | Diff with color |
| `g wd` | `diff --word-diff` | Word-level diff |
| `g pl` | `pull --ff-only` | Safe pull (no merge commits) |
| `g rb` | `rebase` | Rebase |
| `g rbi` | `rebase --interactive` | Interactive rebase |
| `g rbo` | `rebase --onto` | Rebase onto |
| `g rs` | `reset` | Reset |
| `g rs1` | `reset HEAD~1` | Undo last commit (keep changes) |
| `g l` | `log --graph --oneline` | Pretty log graph (all branches) |
| `g ls` | log with dates | Compact log with relative dates |
| `g la` | log all | Log all local and remote branches |
| `g ll` | log long | Full commit messages + stats |
| `g rf` | reflog | Reflog with dates |
| `g recent` | branch by date | Recently updated branches |
| `g undo` | `reset --soft HEAD^` | Undo last commit |
| `g amend` | `commit --amend --no-edit` | Amend without editing message |
| `g alias` | - | List all git aliases |

### Interactive FZF Commands ([forgit](https://github.com/wfxr/forgit))

| Alias | Function |
|-------|----------|
| `ga` | Stage files with preview |
| `glo` | Browse commit log |
| `gd` | View diffs interactively |
| `grh` | Unstage files |
| `gcf` | Restore files from index |
| `gcb` | Switch branch |
| `gbd` | Delete branches |
| `gcp` | Cherry-pick commits |
| `grb` | Interactive rebase |
| `gbl` | Blame with navigation |
| `gclean` | Remove untracked files |
| `gss` | Browse stashes |
| `gsp` | Stash files selectively |
| `gi` | Generate .gitignore |

**Forgit keybindings:** `Enter` confirm, `Tab` toggle selection, `?` toggle preview, `Ctrl-Y` copy hash.

Personal config stored in `.gitconfig.local` (not tracked).
