#!/bin/sh

### CONFIG ###
PLAYER="mpv"
CLIPBOARD_CMD="xclip -o"
CACHE="/tmp/search-yt"

### Functions ###
die(){
  [ -z "$1" ] ||
    printf "$@\n" > /dev/stderr
  exit 1
}

usage(){
  printf "Usage: p [ID]\n"
  printf "
  p(lay) is meant to be used with s(earch)
  p [ID] will play from the s(earch) results
  When invoked without an argument, it will simply try to play whatever is in your clipboard (xclip by default)\n\n"
  die
}

play_clipboard(){
  which "${CLIPBOARD_CMD%% *}" >/dev/null 2>&1 ||
    die "Clipboard not found"
  LINK="$(eval $CLIPBOARD_CMD)"
}

play_id(){
  [ -f "$CACHE" ] ||
    die "$CACHE doesn't exist"
  LINK="https://youtube.com$( awk -F '"' -v SELECTION="$1" \
  ' NR == SELECTION { print $2 } ' "$CACHE" )"
}

### Main ###

which "${PLAYER%% *}" >/dev/null 2>&1 ||
  die "$PLAYER not found."

[ -z "$1" ] &&
  play_clipboard ||
  play_id "$1"

[ -z "$LINK" ] && die "Nothing to play"

$PLAYER "${LINK}"
