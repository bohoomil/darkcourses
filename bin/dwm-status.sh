#!/bin/sh
# Status bar script for dwm

# Status bar options:
# http://0mark.unserver.de/projects/dwm-sprinkles/tfm

loc(){
	LOC="$("$HOME/bin/loc.sh")"
	if [ $LOC == XX ]; then
		#red
		echo -e "^[f0;GEO ^[fB3354C;$LOC^[f0;"
	else
		#blue
		echo -e "^[f0;GEO ^[f3987BF;$LOC^[f0;"
	fi
	}

   # CPU line courtesy Procyon: https://bbs.archlinux.org/viewtopic.php?pid=661592
cpu(){
	CPU="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4; 
	eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); 
	INTERVALTOTAL=$((total-${prevtotal:-0})); 
	echo "$((100*( (INTERVALTOTAL) - ($idle-${previdle:-0}) ) / (INTERVALTOTAL) ))")"
	if [ "$CPU" -ge 0 ] && [ "$CPU" -le 9 ]; then
		#green
		echo -e "^[f0;CPU ^[f4BA65A;$CPU%^[f0;"
	elif [ "$CPU" -ge 10 ] && [ "$CPU" -le 24 ]; then
		#cyan light
		echo -e "^[f0;CPU ^[f31A6A6;$CPU%^[f0;"
	elif [ "$CPU" -ge 25 ] && [ "$CPU" -le 49 ]; then
		#yellow
		echo -e "^[f0;CPU ^[fBFA572;$CPU%^[f0;"
	elif [ "$CPU" -ge 50 ] && [ "$CPU" -le 74 ]; then
		#magenta
		echo -e "^[f0;CPU ^[fA64286;$CPU%^[f0;"
	else
		#red
		echo -e "^[f0;CPU ^[fB3354C;$CPU%^[f0;"
	fi
	}

mem(){
	MEM="$(free -m |awk '/cache:/ { print $3"M" }')"
	#yellow
	echo -e "^[f0;MEM ^[f807933;$MEM^[f0;"
	}

hdd(){
	HDD1="$(df /dev/sda5 | awk '/^\/dev/{printf "%s ", $5}' | sed '$s/.$//')"
	HDD2="$(df /dev/sda3 | awk '/^\/dev/{printf $5"\n"}')"
	HDDT="$(curl --connect-timeout 1 -fsm 3 telnet://127.0.0.1:7634 | cut -c 34-35)"
		#cyan magenta
		echo -e "^[f0;HFS ^[f008080;$HDD2  ^[f0;TMP ^[fA64286;$HDDT°C^[f0;"
	}

eml(){
	MAILDIRS="$HOME/.mail/*/INBOX/new/"
	MLS="$(find $MAILDIRS -type f | wc -l)"
	if [ $MLS == 0 ]; then
		#black
		echo -en "^[f0;EML ^[f585858;0^[f0;"
	else
		#red
		echo -en "^[f0;EML ^[fB3354C;$MLS^[f0;"
	fi
	}

pkg(){
	PAC="$(pacman -Qu | wc -l)"
	if [ $PAC == 0 ]; then
	    echo -en "^[f0;PKG ^[f585858;0^[f0;"
	else
	    echo -en "^[f0;PKG ^[f802535;$PAC^[f0;"
	fi
}


dte(){
	DTE="$(date "+%a %d.%m, %H:%M")"
		echo -e "^[f5F87AF;$DTE^[f0;"
	}

vol(){
	LEVEL="$(amixer get PCM | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')"
	MIX=`amixer | tail -1`;
	if [[ $MIX == *\[off\]* ]]
	then
		echo -e "^[f0;VOL ^[f802626;OFF^[f0;"
	elif [[ $MIX == *\[on\]* ]]
	then
		echo -e "^[f0;VOL ^[f3F7347;$LEVEL^[f0;"
	else
		echo -e "^[f0;VOL ^[f802626;---^[f0;"
	fi
	}

msc(){
	STAT="$(mpc | head -n 2 | tail -n 1 | sed 's/ .*//')"
	if [ $STAT == "[playing]" ]; then
		#red
		echo -e "^[fB34747;^[i45;^[f0;"
	elif [ $STAT == "[paused]" ]; then
		#yellow
		echo -e "^[fBFA572;^[i43;^[f0;"
	else
		#black
		echo -e "^[f585858;^[i41;^[f0;"
	fi
	}

# Pipe to status bar
xsetroot -name " $(loc)  $(cpu)  $(mem)  $(hdd)  $(eml)  $(pkg)  $(dte)  $(vol)"
