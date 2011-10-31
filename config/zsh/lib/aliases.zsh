# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# hg
alias hgp='hg pull'
alias hgu='hg update'

alias g='grep -in'

# Show history
alias history='fc -l 1'

# List direcory contents
alias la='ls -lhA'
alias l='ls -la'
alias ll='ls -l'
alias sl='ls'

# command L equivalent to command |less
alias -g L='|less'

# Normal aliases
alias ls="BLOCK_SIZE=\'1 ls --color=auto" #thousands grouping
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias f='find | grep'
alias c='clear'
alias ..='cd ..'
alias hist="grep '$1' /home/bohoomil/.config/zsh/zsh_history"
alias irssi="irssi -c irc.freenode.net -n yyz"
alias mem="free -m"
#alias xterm='xterm -geometry 120x50 -e /bin/bash'
#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'
alias xdvi='LC_ALL=C xdvi'
alias IP='$HOME/bin/iploc.sh'
alias mplayer='mplayer -noass'
alias bashburn='NOCOPE=1 bashburn'
#alias cdemu='cdemu -b system'
alias slurm="slurm -L -t ~/.local/share/slurm/themes/my -i wlan0"
alias gfv="gnome-font-viewer"
alias feh="feh --scale-down -F"

alias pacman='sudo pacman'
alias upgrade='pacman -Syu && aurget -Syu'

# pm
alias shut='sudo shutdown -h now'

# command S equivalent to command &> /dev/null &
alias -g S='&> /dev/null &'

# Mounts
alias fam='sudo mount -t ext3 /dev/sdb1 /media/FreeAgent'
alias fau='sudo umount /media/FreeAgent'
alias him='sudo mount -t davfs https://xxx.xxx.xxx.xxx.com/ /media/netdrive'
alias hiu='sudo umount /media/netdrive'

# Places
alias bkp='cd /home/data/BACKUP'
alias data='cd /home/data'
alias soft='cd /home/data/software'
alias eb='cd /home/bohoomil/documents/eBooks'
alias not='cd /home/bohoomil/documents/0_notes'
alias vid='cd /home/bohoomil/videos'
alias doc='cd /home/bohoomil/documents'
alias rec='cd /home/data/recent'
alias pic='cd /home/bohoomil/pictures'
alias dw='cd /home/bohoomil/downloads'
alias pkg='cd /home/bohoomil/packages'

# VPN
alias vpnu='sudo rc.d start openvpn'
alias vpnd='sudo rc.d stop openvpn'
alias vpnr='sudo rc.d restart openvpn'
