#!/bin/zsh
# status script for evilwm - right
SLEEP=1

BG="#000000"
FG="#8A9199"

tags(){
	tg=$(xprop -root _NET_CURRENT_DESKTOP|sed 's/_NET_CURRENT_DESKTOP(CARDINAL) = //;s/0x0/ /g;s/0x/\\x/g;s/, //g;')
	tgc=$(($tg + 1))
	print -n "^fg(#5F87AF)[$tgc]^fg($FG)"
}

win(){
	ID=$(xprop -root _NET_ACTIVE_WINDOW | sed 's/_NET_ACTIVE_WINDOW(WINDOW): window id # //')
	client=$(xprop -id "$ID" | grep "_NET_WM_NAME(UTF8_STRING)" | sed 's/_NET_WM_NAME(UTF8_STRING) = //;s/^"/\[/g;s/"$/\]/g')
	print -n " $client "
}

while true; do
	print -n " $(tags) $(win)\n"
	sleep $SLEEP
done | dzen2 -fn '-*-terminus-medium-r-*-*-12-*-*-*-*-*-iso10646-1' -bg $BG -h 15 -x 0 -y 0 -w 840 -ta l -e ''

