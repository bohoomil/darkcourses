function zsh_stats() {
	history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

# Extract Files
function extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)  tar xjf $1        ;;
			*.tar.gz)   tar xzf $1        ;;
			*.tar.xz)   tar xJf $1        ;;
			*.tar.lzma) tar --lzma -xf $1 ;;
			*.bz2)      bunzip2 $1        ;;
			*.rar)      rar x $1          ;;
			*.gz)       gunzip $1         ;;
			*.tar)      tar xf $1         ;;
			*.tbz2)     tar xjf $1        ;;
			*.tgz)      tar xzf $1        ;;
			*.zip)      unzip $1          ;;
			*.Z)        uncompress $1     ;;
			*.7z)       7z x $1           ;;
			*.xz)       unxz $1           ;;
			*.exe)      cabextract $1     ;;
			*.lha)      lha e $1          ;;
			*)          echo "\`$1': unrecognized archive type" || return 1 ;;
		esac
	else
		echo "\`$1' is not a valid file"
	fi
}

function pack() {
	local FILE
	FILE=$1
	case $FILE in
		*.tar.bz2)  shift && tar cjf $FILE $* ;;
		*.tbz2)     shift && tar cjf $FILE $* ;;
		*.tar.gz)   shift && tar czf $FILE $* ;;
		*.tgz)      shift && tar czf $FILE $* ;;
		*.zip)      shift && zip $FILE $*     ;;
		*.rar)      shift && rar $FILE $*     ;;
	esac
}

## Note-taking macro based on
## http://lifehacker.com/5592047/turn-your-command-line-into-a-fast-and-simple-note+taking-tool
#
function n() { $EDITOR $HOME/documents/0_notes/"$*".rst }
function nls() { ls -CR --color=always $HOME/documents/0_notes/ | grep "$*" }
function nd() { rm $HOME/documents/0_notes/"$*".rst ; }

function nmount() {
	(echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t;
}

# International timezone
function zone() { TZ="$1"/"$2" date; }
function zones() { ls /usr/share/zoneinfo/"$1" ;}

## pretty JSON
function pj() {
	python -mjson.tool
}

# Create pdf of man page - requires ghostscript and mimeinfo
function manpdf() { man -t "$@" | ps2pdf - /tmp/manpdf_$1.pdf && xdg-open /tmp/manpdf_$1.pdf ;}

# Quick and dirty encryption
function encrypt() {
	openssl des3 -a -in $1 -out $1.des3
}
function decrypt() {
	openssl des3 -d -a -in $1 -out ${1%.des3}
}

# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# - If the input is a filename that exists, then it
#   uses the contents of that file.
# ------------------------------------------------
function cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string or the contents of a file to the clipboard."
      echo "Usage: cb <string or file>"
      echo "       echo <string or file> | cb"
    else
      # If the input is a filename that exists, then use the contents of that file.
      if [ -e "$input" ]; then input="$(cat $input)"; fi
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}

# Shortcut to copy SSH public key to clipboard.
alias cb_ssh="cb ~/.ssh/id_rsa.pub"

# Colors index
# ------------------------------------------------
function color_index() {
  # Show an index of all available bash colors
  echo -e "\n              Usage: \\\033[*;**(;**)m"
  echo -e   "            Default: \\\033[0m"
  local blank_line="\033[0m\n     \033[0;30;40m$(printf "%41s")\033[0m"
  echo -e "$blank_line" # Top border
  for STYLE in 2 0 1 4 9; do
    echo -en "     \033[0;30;40m "
    # Display black fg on white bg
    echo -en "\033[${STYLE};30;47m${STYLE};30\033[0;30;40m "
    for FG in $(seq 31 37); do
        CTRL="\033[${STYLE};${FG};40m"
        echo -en "${CTRL}"
        echo -en "${STYLE};${FG}\033[0;30;40m "
    done
    echo -e "$blank_line" # Separators
  done
  echo -en "     \033[0;30;40m "
  # Background colors
  echo -en "\033[0;37;40m*;40\033[0;30;40m \033[0m" # Display white fg on black bg
  for BG in $(seq 41 47); do
      CTRL="\033[0;30;${BG}m"
      echo -en "${CTRL}"
      echo -en "*;${BG}\033[0;30;40m "
  done
  echo -e "$blank_line" "\n" # Bottom border
}

