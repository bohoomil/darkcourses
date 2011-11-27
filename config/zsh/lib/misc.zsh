## various misc options

setopt autopushd pushdminus pushdsilent pushdtohome
setopt ignoreeof
setopt interactivecomments
setopt noclobber
setopt sh_word_split
setopt nohup

autoload -U zcalc

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
autoload -U zmv
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export PAGER='less -R'
export LC_CTYPE=en_US.UTF-8

##################################################################
##Less Colors for Man Pages -- org. settings
export LESS="-aMRS#3"
export LESS_TERMCAP_mb=$'\E[01;31m'     # begin blinking
export LESS_TERMCAP_md=$'\E[01;34m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'         # end mode
export LESS_TERMCAP_se=$'\E[0m'         # end stout-mode
export LESS_TERMCAP_so=$'\E[01;41;37m'  # begin stout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'         # end underline
export LESS_TERMCAP_us=$'\E[01;33m'     # begin underline


# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## Open current directory
alias oo='open .'

## Quick-look a file (^C to close)
alias ql='qlmanage -p 2>/dev/null'
## Highlight-aware less command
alias hl='less -R'

## Show history
alias history='fc -l 1'

## Color grep results
export GREP_OPTIONS='--color=auto'
export GREP_COLORS='ms=00;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'


