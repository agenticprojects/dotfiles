# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000         # Large memory history for better search
SAVEHIST=50000         # Large file history
setopt APPEND_HISTORY          # Append to history file
setopt SHARE_HISTORY           # Share history between sessions
setopt HIST_IGNORE_DUPS        # Don't record duplicate entries
setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicates
setopt HIST_IGNORE_SPACE       # Don't record commands starting with space
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks
setopt HIST_VERIFY             # Show command before executing from history
setopt INC_APPEND_HISTORY      # Write to history file immediately

# Atuin configuration
eval "$(atuin init zsh)"

# fnm (Fast Node Manager) configuration
eval "$(fnm env --use-on-cd)"