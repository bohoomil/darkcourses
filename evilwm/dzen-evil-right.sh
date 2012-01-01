#!/bin/zsh
# Status script for evilwm - left
SLEEP=1

#ICON="$HOME/.dzen/icons"
MAILDIRS="/home/data/mail/"
IFACE=wlan0
RXB=`cat /sys/class/net/${IFACE}/statistics/rx_bytes`
TXB=`cat /sys/class/net/${IFACE}/statistics/tx_bytes`
BG="#000000"
FG="#5E6875"
#SEP="^fg(#0F2133):^fg($FG)"

netmon() {
   RXBN=`cat /sys/class/net/${IFACE}/statistics/rx_bytes`
   TXBN=`cat /sys/class/net/${IFACE}/statistics/tx_bytes`
   RXR=$(printf "%4d\n" $(echo "($RXBN - $RXB) / 1024/${SLEEP}" | bc))
   TXR=$(printf "%4d\n" $(echo "($TXBN - $TXB) / 1024/${SLEEP}" | bc))
	 print -n "^fg($FG)UP^fg(#005999)${RXR} kB/s ^fg($FG)DOWN^fg(#4D578C)${TXR} kB/s^fg($FG)"
   RXB=$RXBN
   TXB=$TXBN
}

loc(){
	loc=`$HOME/bin/loc.sh`
	if [[ $loc == XX ]]; then
		#red
		print "^fg($FG)GEO ^fg(#B3354C)$loc^fg($FG)"
	else
		#blue
		print "^fg($FG)GEO ^fg(#3987BF)$loc^fg($FG)"
	fi
	}

   # CPU line courtesy Procyon: https://bbs.archlinux.org/viewtopic.php?pid=661592
cpu(){
	cpu="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4; 
	eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); 
	intervaltotal=$((total-${prevtotal:-0})); 
	echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")"
	if [[ "$cpu" -ge 0 ]] && [[ "$cpu" -le 9 ]]; then
		#green
		print -n "^fg($FG)CPU ^fg(#4BA65A)$cpu%^fg($FG)"
	elif [[ "$cpu" -ge 10 ]] && [[ "$cpu" -le 24 ]]; then
		#cyan light
		print -n "^fg($FG)CPU ^fg(#31A6A6)$cpu%^fg($FG)"
	elif [[ "$cpu" -ge 25 ]] && [[ "$cpu" -le 49 ]]; then
		#yellow
		print -n "^fg($FG)CPU ^fg(#BFA572)$cpu%^fg($FG)"
	elif [[ "$cpu" -ge 50 ]] && [[ "$cpu" -le 74 ]]; then
		#magenta
		print -n "^fg($FG)CPU ^fg(#A64286)$cpu%^fg($FG)"
	else
		#red
		print -n "^fg($FG)CPU ^fg(#B3354C)$cpu%^fg($FG)"
	fi
	}

mem(){
	mem="$(free -m |awk '/cache:/ { print $3"M" }')"
	#yellow
	print -n "^fg($FG)MEM ^fg(#807933)$mem^fg($FG)"
	}

hdd(){
	hdd1="$(df /dev/sda5 | awk '/^\/dev/{printf "%s ", $5}' | sed '$s/.$//')"
	hdd2="$(df /dev/sda3 | awk '/^\/dev/{printf $5"\n"}')"
	hddt="$(curl --connect-timeout 1 -fsm 3 telnet://127.0.0.1:7634 | cut -c 34-35)"
	#cyan magenta
	print -n "^fg($FG)HFS ^fg(#008080)$hdd2  ^fg($FG)TMP ^fg(#A64286)$hddt°C^fg($FG)"
	}

eml(){
	ml=`find "$MAILDIRS"/*/INBOX/new -type f | wc -l`
	if [[ $ml == 0 ]]; then
		#black
		print -n "^fg($FG)EML ^fg(#585858)0^fg($FG)"
	else
		#red
		print -n "^fg($FG)EML ^fg(#B3354C)$ml^fg($FG)"
	fi
	}

dte(){
	dt=`date '+%a %d.%m, %H:%M'`
		print -n "^fg(#5F87AF)$dt^fg($FG)"
	}

vol(){
	level="$(amixer get PCM | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')"
	mix=`amixer | tail -1`;
	if [[ $mix == *\[off\]* ]]
	then
		print -n "^fg($FG)VOL ^fg(#802626)OFF^fg($FG)"
	elif [[ $mix == *\[on\]* ]]
	then
		print -n "^fg($FG)VOL ^fg(#3F7347)$level^fg($FG)"
	else
		print -n "^fg($FG)VOL ^fg(#802626)---^fg($FG)"
	fi
	}

pkg(){
	pac="$(pacman -Qu | wc -l)"
	if [[ $pac == 0 ]]; then
		print -n "^fg($FG)PKG 0^fg($FG)"
	else
		print -n "^fg($FG)PKG ^fg(#802535)$pac^fg($FG)"
	fi
}

while true; do
	print -n " $(loc)  $(cpu)  $(mem)  $(hdd)  $(eml)  $(pkg)  $(dte)  $(vol) \n"
	sleep $SLEEP
done | dzen2 -fn '-*-terminus-medium-r-*-*-12-*-*-*-*-*-iso10646-1' -bg $BG -h 15 -x 840 -y 0 -ta r -e ''

