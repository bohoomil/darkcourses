#!/bin/sh

PID=$(pgrep offlineimap)

[[ -n "$PID" ]] && kill "$PID"

offlineimap -o -u quiet &>/dev/null &

exit 0

