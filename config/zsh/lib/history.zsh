## Command history configuration
HISTFILE=$HOME/.config/zsh/zsh_history
HISTSIZE=5000
SAVEHIST=5000

setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt nobanghist

setopt SHARE_HISTORY
setopt APPEND_HISTORY
