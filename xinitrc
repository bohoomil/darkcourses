
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge $HOME/.Xresources

xset r rate 200 30

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

sh $HOME/.fehbg &

dunst &

/usr/bin/urxvtd -q -o -f &

unclutter -idle 5 &

parcellite -n &

xautolock -time 60 -locker "sudo pm-suspend" &

exec $HOME/bin/dwm-start
#xterm -geometry 80x60+600+0 &
#exec xterm -geometry 80x60+0+0 -name login
# vim:set ts=2 sw=2 ft=sh et:
