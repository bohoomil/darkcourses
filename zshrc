# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export GPGKEY="6E32FD72"

# path to zsh configuration
export ZSH=$HOME/.config/zsh

# the name of the theme to load
export ZSH_THEME="dc"

# termcap
[ -n "$TMUX" ] && export TERM="screen-256color"

# use case-sensitive completion
export CASE_SENSITIVE="true"

# load plugins
plugins=(git zsh-syntax-highlighting)

source $ZSH/my-zsh.sh

# antialiasing for java fonts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

# cope
export PATH=/usr/share/perl5/site_perl/auto/share/dist/Cope:$PATH

# console colors {{{1
if [ "$TERM" = "linux" ]; then
	echo -en "\e]P0000000" #black
	echo -en "\e]P8434C59" #darkgrey
	echo -en "\e]P1802635" #darkred
	echo -en "\e]P9B3354C" #red
	echo -en "\e]P234733F" #darkgreen
	echo -en "\e]PA4BA65A" #green
	echo -en "\e]P3807933" #brown
	echo -en "\e]PBBF9F5F" #yellow
	echo -en "\e]P4005999" #darkblue
	echo -en "\e]PC3987BF" #blue
	echo -en "\e]P54D578C" #darkmagenta
	echo -en "\e]PDA64286" #magenta
	echo -en "\e]P6008080" #darkcyan
	echo -en "\e]PE31A6A6" #cyan
	echo -en "\e]P769758C" #lightgrey
	echo -en "\e]PF959EA6" #white
	clear # back to default input colours
fi
#1}}}
# vim:ft=zsh:fdm=marker
