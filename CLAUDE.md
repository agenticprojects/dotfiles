# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a dotfiles repository using GNU Stow for managing personal system configuration files. Stow creates symlinks from the home directory to configuration files stored in this repository, allowing version control of system configs.

## Common Commands

- `stow <package>` - Create symlinks for a package (run from dotfiles directory)
- `stow -D <package>` - Remove symlinks for a package (unstow)
- `stow -R <package>` - Restow (remove then create symlinks)
- `stow -n <package>` - Dry run (show what would be done without doing it)
- `stow -v <package>` - Verbose output
- `stow -t ~ <package>` - Explicitly set target directory to home

## Architecture

- Each subdirectory represents a "package" that can be stowed independently
- Directory structure within packages mirrors the target structure in home directory
- Example: `zsh/.zshrc` becomes `~/.zshrc` when stowed
- Packages allow modular management (e.g., separate packages for different tools)

## Package Structure

Typical package organization:
- `zsh/` - Shell configuration (.zshrc, .zsh_profile, etc.)
- `git/` - Git configuration (.gitconfig, .gitignore_global)
- `vim/` - Vim configuration (.vimrc, .vim/)
- `tmux/` - Tmux configuration (.tmux.conf)
- `ssh/` - SSH configuration (.ssh/config)

## Development Workflow

1. Create new package directories as needed
2. Place config files in appropriate subdirectory structure
3. Test with `stow -n <package>` first (dry run)
4. Apply with `stow <package>`
5. Use `stow -R <package>` to update existing symlinks after changes

## Next Development Phase Plan

### Phase 1: Setup Foundation
1. **Install dependencies**: Run `brew bundle` to ensure stow is installed
2. **Backup existing configs**: Create backup of current ~/.zshrc, ~/.gitconfig, etc.

### Phase 2: Create Core Packages  
3. **Shell package**: Create `zsh/` directory with .zshrc, .zsh_profile
4. **Git package**: Create `git/` directory with .gitconfig, .gitignore_global  
5. **Editor package**: Create `vim/` or `nvim/` directory for editor config

### Phase 3: Migration & Testing
6. **Move existing configs**: Copy current config files into respective package directories
7. **Test with dry runs**: Use `stow -n <package>` to preview changes safely
8. **Apply selectively**: Start with `stow zsh` then `stow git`

### Phase 4: Enhance & Expand
9. **Add more tools**: Consider tmux, ssh, brew packages in Brewfile
10. **Document setup**: Update CLAUDE.md with your specific packages and workflow