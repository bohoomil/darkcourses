# mime for zsh

# default applications
export EDITOR="vim"
export FCEDIT="vim"
export BROWSER="firefox"
#export PACMAN="pacman-color"
export VIDEO="mplayer -noass"
export IMAGE="xnview"

autoload -U zsh-mime-setup
zsh-mime-setup

# mime setup
zstyle :mime: mailcap ~/.mutt/mailcap /etc/mailcap
zstyle :mime: mime-types ~/.mime.types /etc/mime.types

# Set up auto extension stuff
alias -s avi=$VIDEO
alias -s mov=$VIDEO
alias -s mpg=$VIDEO
alias -s mpeg=$VIDEO
alias -s flv=$VIDEO
alias -s mp4=$VIDEO
alias -s mkv=$VIDEO
alias -s m4v=$VIDEO
alias -s ogg=$VIDEO
alias -s ogv=$VIDEO
alias -s wmv=$VIDEO
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=$IMAGE
alias -s jpg=$IMAGE
alias -s jpeg=$IMAGE
alias -s bmp=$IMAGE
alias -s gif=$IMAGE
#alias -s odt=unzip -p %f content.xml | o3totxt | less
alias -s doc="antiword -t"
alias -s docx=docx2txt.sh
alias -s rtf="catdoc -w"
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR
alias -s tex=$EDITOR
alias -s t2t=$EDITOR
alias -s rst=$EDITOR
alias -s pdf=acroread
alias -s djvu=djview
alias -s air=adobe-air
#alias -s chm=xchm

