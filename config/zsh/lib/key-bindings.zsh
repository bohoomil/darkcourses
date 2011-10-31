# TODO: Explain what some of this does..

bindkey -e
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey -s '\e.' "..\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey ' ' magic-space    # also do history expansion on space

bindkey "[Z" reverse-menu-complete

#bindkey -s "^[^T" "tmux\n"

case "$TERM" in
  cons25*|linux)
	bindkey "\e[H"    beginning-of-line     # Home
	bindkey "\e[F"    end-of-line           # End 
	bindkey "\e[3~"   delete-char           # Delete
	bindkey "[D"      emacs-backward-word   # Esc + Left
	bindkey "[C"      emacs-forward-word    # Esc + Right
	;;
  *rxvt*)
	bindkey "\e[7~"   beginning-of-line    # Home
	bindkey "\e[8~"   end-of-line          # End
	bindkey "\e[3~"   delete-char          # Delete
	bindkey "Oc"    forward-word
	bindkey "Od"    backward-word
	;;
  screen*)
	bindkey "[7~"  beginning-of-line     # Home
	bindkey "[8~"  end-of-line           # End
	bindkey "\e[3~"  delete-char           # Delete
	bindkey "\eOc"   forward-word          # Ctrl + Right
	bindkey "\eOd"   backward-word         # Ctrl + Left
	bindkey "Oc"   forward-word          # Ctrl + Right
	bindkey "Od"   backward-word         # Ctrl + Left
	;;
esac

