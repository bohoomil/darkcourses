#!/bin/bash

# from http://www.linuxtutorialblog.com/post/solution-converting-flac-to-mp3

OUT_DIR="./mp3"
[ ! -d ${OUT_DIR} ] && mkdir -p ${OUT_DIR}

# modify the lame options to your
# preference
#lame_opts=" --vbr-new -V 2 -B 256 "
lame_opts=" --preset insane "

for x in "${@}"
do
FLAC=${x}
MP3=`basename "${FLAC%.flac}.mp3"`

[ -r "$FLAC" ] || { echo can not read file \"$FLAC\" >&1 ; exit 1 ; } ;

TITLE=""
TRACKNUMBER=""
GENRE=""
DATE=""
COMMENT=""
ARTIST=""
ALBUM=""
Title=""
Tracknumber=""
Genre=""
Date=""
Comment=""
Artist=""
Album=""

metaflac --export-tags-to=- "$FLAC" | sed 's/=\(.*\)/="\1"/' > tmp.tmp

. ./tmp.tmp
rm tmp.tmp

[ -z "$TITLE" ] && TITLE="$Title"
[ -z "$TRACKNUMBER" ] && TRACKNUMBER="$Tracknumber"
[ -z "$GENRE" ] && GENRE="$Genre"
[ -z "$DATE" ] && DATE="$Date"
[ -z "$COMMENT" ] && COMMENT="$Comment"
[ -z "$ARTIST" ] && ARTIST="$Artist"
[ -z "$ALBUM" ] && ALBUM="$Album"

echo "Converting ${FLAC} to MP3 format"

flac -c -d "$FLAC" | lame ${lame_opts} - ${OUT_DIR}/"$MP3"

id3v2 \
-a "$ARTIST" \
-A "$ALBUM" \
-t "$TITLE" \
-c "$COMMENT" \
-g "$GENRE" \
-y "$DATE" \
-T "$TRACKNUMBER" \
${OUT_DIR}/"$MP3"

done
