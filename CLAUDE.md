# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **personal dotfiles repository** for managing development environment configuration across machines. The setup uses Dotbot for installation, Antidote for zsh plugin management, LazyVim for Neovim, and includes comprehensive tmux and Git configurations.

**Key principle**: Changes to this repository directly affect the user's daily development environment. Always test thoroughly and maintain backward compatibility where possible.

## Installation & Testing

### Initial Setup
```bash
# Clone and install
git clone https://github.com/tordks/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

### Testing Changes
```bash
# Test in Docker (preferred for major changes)
docker build -t dotfiles-test .
docker run -it dotfiles-test

# Test installation script
./install

# Reload shell to test zsh changes
exec zsh
# Or just source the config
source ~/.zshrc

# Test neovim changes
nvim
# Check plugin status with :Lazy

# Test tmux changes
tmux source-file ~/.tmux.conf
```

## Architecture & File Organization

### Zsh Configuration Structure

**Single File Structure:**
- All zsh configuration consolidated in `.zshrc` (~370 lines)
- Organized into logical sections with clear headers
- Load order enforced within single file
- Uses Antidote for plugin management

**Load Order (Critical!):**
1. `.zshrc` - Main entry point and all configuration
2. Antidote plugin manager initialization
3. `compinit` - Completion system (MUST happen before plugins)
4. Antidote loads plugins from `.zsh_plugins.txt`
5. Environment variables, history settings, aliases, functions
6. Additional tools (zoxide, fzf, Starship prompt) initialization

**Important Notes:**
- The completion system (`compinit`) MUST be initialized in `.zshrc` AFTER Antidote is loaded but BEFORE plugins are loaded via `antidote load`. This prevents "command not found: compdef" errors.
- All configuration is now in `.zshrc` with clear section headers for easy navigation
- FZF is loaded ONLY via Antidote plugin (`junegunn/fzf path:shell kind:fpath` in `.zsh_plugins.txt`). Previous redundant loading methods have been removed.
- The enhanced `ls` alias with colors and directory grouping is defined BEFORE other ls-related aliases so they inherit the enhancements.

**When Editing Zsh Configuration:**
- Edit `.zshrc` - all configuration in one file
- Navigate to the appropriate section using section headers
- Always maintain the load order
- Test that completions work: `git <TAB>`
- Verify FZF works: `Ctrl+R` (history), `Ctrl+T` (files), `Alt+C` (directories)
- Check history search works: `zh <keyword>` uses `$HISTFILE` variable (not hardcoded path)
- Test: `source ~/.zshrc` or `exec zsh`

### Neovim Configuration (LazyVim)

Structure:
```
nvim/
├── init.lua                    # Entry point (loads lazy.lua)
└── lua/
    ├── config/
    │   ├── lazy.lua           # LazyVim bootstrapper
    │   ├── keymaps.lua        # Custom key bindings
    │   ├── options.lua        # Editor options
    │   └── autocmds.lua       # Autocommands
    └── plugins/
        ├── example.lua        # Example plugin spec
        └── tmux.lua           # Tmux integration plugin
```

**Plugin Loading**: LazyVim automatically discovers and loads all files in `lua/plugins/`. Each file should return a plugin specification table.

**Adding Plugins**: Create a new file in `lua/plugins/` with the plugin spec. LazyVim will auto-install on next nvim launch.

### Dotbot Installation System

The `install` script uses `install.conf.yaml` to:
1. Initialize git submodules (dotbot itself)
2. Clean old symlinks in `~`, `~/.zsh`, `~/.config/nvim`
3. Create symlinks for all config files
4. Run shell commands for package installation

**Symlink Pattern:**
- Individual configs like `.zshrc`, `.tmux.conf` are linked directly
- The `zsh/` directory has been removed (configuration consolidated into `.zshrc`)

**When updating install.conf.yaml:**
- **The install script MUST be idempotent** - running `./install` multiple times should produce the same result without errors
- Use `[ condition ] || command` pattern for shell commands that shouldn't re-run (e.g., `[ -d ~/.dir ] || git clone ...`)
- Test with `./install` (safe, uses relink and doesn't break existing setup)
- Document any new files or changed structure
- Update the comments in the YAML to reflect current architecture

## Common Workflows

### Adding a Zsh Plugin
1. Edit `.zsh_plugins.txt` following Antidote format
2. Reload: `source ~/.zshrc` or `exec zsh`
3. Verify with `antidote list`

### Modifying Zsh Configuration
1. Edit `.zshrc` - all configuration in one file
2. Navigate to the appropriate section using section headers
3. Test: `source ~/.zshrc` or `exec zsh`
4. Check for errors in interactive shell
5. Verify completions still work: `git <TAB>`

### Modifying Neovim Configuration
1. Edit config files in `nvim/lua/config/` or add plugins in `nvim/lua/plugins/`
2. Restart nvim - LazyVim auto-reloads
3. Check for errors with `:checkhealth`
4. View plugins with `:Lazy`

### Modifying tmux Configuration
1. Edit `.tmux.conf`
2. Reload: `tmux source-file ~/.tmux.conf` or `<prefix>r` if bound
3. Test key bindings in an active session

## Critical Configuration Details

### Tmux Prefix
Changed from default `C-b` to `C-a` (.tmux.conf:23-26). All bindings use this prefix.

### Tmux-Vim Smart Navigation
Lines 42-47 in `.tmux.conf` implement smart pane switching that detects vim/nvim and routes `C-h/j/k/l` appropriately. This requires:
- The vim detection pattern in tmux config
- Corresponding vim plugin (handled by tmux.lua in nvim config)

**Do not modify these lines without understanding both sides of the integration.**

### Git Commands
Two patterns for git commands:
- **`git <alias>`** - Standard git aliases defined in `.gitconfig` (e.g., `git l`, `git ci`, `git ap`)
- **Short aliases** - FZF-powered interactive commands via forgit (e.g., `ga`, `glo`, `gd`)

Notable `.gitconfig` aliases:
- `git l` - Pretty graph log (all branches)
- `git ci` - Commit with verbose diff
- `git ap` - Add patches interactively
- `git rs1` - Soft undo last commit
- `git recent` - Recently touched branches

Notable forgit commands (fzf-powered):
- `ga` - Interactive file staging
- `glo` - Browse commit log
- `gd` - Interactive diff viewer
- `gcb` - Switch branch
- `grb` - Interactive rebase

See README.md for complete reference.

### Zsh History Configuration
- Location: `~/.zsh/.zsh_history` (NOT `~/.zsh_history`)
- Size: 250K in memory, 1M saved
- The `zh()` function searches history - uses `$HISTFILE` variable (.zshrc:179)

## Known Issues & Quirks

### Completion System Timing
If you see "command not found: compdef" errors, the completion system isn't initialized before plugins try to use it. Ensure `compinit` is called in `.zshrc` between loading Antidote and loading plugins.

### FZF Configuration
FZF is loaded via Antidote plugin manager. The configuration variable `FZF_ALT_C_COMMAND` is set in `.zshrc` to use `fd` for directory searching.


### Docker Testing
The Dockerfile provides a clean Ubuntu environment for testing. Note that it installs from unstable PPA for Neovim 0.11+.

## Making Changes

### Before Editing
1. Understand the load order (especially for zsh)
2. Check if there are dependencies between files
3. Consider backward compatibility

### After Editing
1. Test in a new shell/tmux session (don't break your current one!)
2. For major changes, test in Docker first
3. Verify all key features work:
   - Zsh completions (`git <TAB>`)
   - FZF bindings (`Ctrl+R`, `Ctrl+T`, `Alt+C`)
   - Tmux pane navigation with vim awareness
   - Neovim plugin loading
4. Check for error messages during initialization
5. Test startup time: `time zsh -i -c exit` (should be <1 second)

### Git Workflow
This is a personal dotfiles repo. Changes are typically made directly to master after testing. For significant refactors, consider using a feature branch.

## Performance Considerations

### Zsh Startup Time
Target: <1 second. Monitor with: `time zsh -i -c exit`

Slow components:
- Plugin loading (check `.zsh_plugins.txt`)
- Completion initialization

### Neovim Startup
LazyVim lazy-loads most plugins. Check startup time with: `nvim --startuptime startup.log`

### Starship Prompt
Configuration at `starship.toml` (symlinked to `~/.config/starship.toml`).

Starship provides:
- Git branch and status display
- Command duration for slow commands (>2s)
- Python/Node/Rust version detection when in project directories

Customize by editing `starship.toml`. Documentation: https://starship.rs/config/
