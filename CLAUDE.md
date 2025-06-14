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

## GitHub Integration

This dotfiles setup includes GitHub CLI (`gh`) for seamless GitHub integration:

### Tools
- **GitHub CLI (`gh`)**: Included in Brewfile for command-line GitHub operations
- **Git configuration**: Use `git/` package for GitHub-specific settings
- **SSH setup**: Use `ssh/` package for GitHub SSH key management

### Git Flow Strategy
This repository uses a **Git Flow** branching model:

- **`main`** - Production-ready code, protected branch
- **`develop`** - Integration branch for features
- **`feature/*`** - Feature development branches
- **`hotfix/*`** - Emergency fixes for production

### Branching Workflow
1. **Feature Development**:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/your-feature-name
   # Make changes
   git add .
   git commit -m "Add feature description"
   git push -u origin feature/your-feature-name
   gh pr create --base develop --title "Add your feature" --body "Description"
   ```

2. **Hotfix Process**:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b hotfix/fix-description
   # Make fixes
   git add .
   git commit -m "Fix critical issue"
   git push -u origin hotfix/fix-description
   gh pr create --base main --title "Hotfix: description" --body "Fix details"
   ```

3. **Release Process**:
   ```bash
   # Merge develop to main via PR
   gh pr create --base main --head develop --title "Release: version" --body "Release notes"
   ```

### Repository Settings
- ✅ Auto-delete branches after merge
- ⚠️ Branch protection (requires GitHub Pro for private repos)

### Common GitHub Workflows
- `gh auth login` - Authenticate with GitHub
- `gh repo clone <repo>` - Clone repositories
- `gh pr create` - Create pull requests
- `gh pr list` - List pull requests
- `gh pr merge <number>` - Merge pull requests
- `gh issue list` - List issues
- `stow git` - Apply git configuration package
- `stow ssh` - Apply SSH configuration package

### Commit Message Guidelines
- Write clear, concise commit messages that describe the actual changes made
- Focus on the "what" and "why" of the change, not the tools used
- Do NOT reference Claude Code, AI assistance, or automated generation in commit messages
- Use imperative mood (e.g., "Add feature" not "Added feature")
- Keep the first line under 50 characters when possible
- Examples:
  - ✅ "Add automated Homebrew installation to install script"
  - ✅ "Fix SSH configuration path resolution"
  - ❌ "Update files with Claude Code assistance"
  - ❌ "AI-generated improvements to shell config"

### Setup Process
1. **Initial setup**: Run `./install.sh` to install system dependencies (Xcode tools, Homebrew packages)
2. Authenticate: `gh auth login`
3. Apply git config: `stow git`
4. Apply SSH config: `stow ssh` (if using SSH keys)

## Development Workflow

1. **Initial setup**: Run `./install.sh` to ensure system dependencies (including Xcode command line tools) are installed
2. Create new package directories as needed
3. Place config files in appropriate subdirectory structure
4. Test with `stow -n <package>` first (dry run)
5. Apply with `stow <package>`
6. Use `stow -R <package>` to update existing symlinks after changes

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