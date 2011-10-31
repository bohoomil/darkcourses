# Multimedia related aliases

# cue2tracks
# *.cue file has to be named CDImage.cue
alias cuefl='cue2tracks -C -c flac -o "%N %t" CDImage.cue'
alias cueflr='cue2tracks -CR -c flac -o "%N %t" CDImage.cue'
alias cuemp3='cue2tracks -C -c mp3 -B 320 -o "%N %t" CDImage.cue'
alias cuemp3r='cue2tracks -CR -c mp3 -B 320 -o "%N %t" CDImage.cue'

# tagging
# flac & mp3
alias tagmp3="mp3info -x"
alias tagflac="metaflac --show-tag=TITLE --show-tag=ARTIST --show-tag=ALBUM --show-tag=TRACKNUMBER --show-tag=GENRE --show-tag=COMMENT --show-tag=DATE --show-sample-rate --show-channels"

