#!/bin/sh
#
## Copyright 2021 NRK
## Licensed under GPL v3. See LICENSE for more details.

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
  [ "$1" -gt "$( wc -l < $CACHE )" ] &&
    die "There's only $( wc -l < $CACHE ) results"

  LINK="https://youtube.com$( awk -F '"' -v SELECTION="$1" \
  ' NR == SELECTION { print $2 } ' "$CACHE" )"
}

### Main ###

which "${PLAYER%% *}" >/dev/null 2>&1 ||
  die "$PLAYER not found."

case "$1" in
  "-h"|"--help") usage ;;
  [0-9]) play_id "$1" ;;
  "") play_clipboard ;;
  *) die "Invalid" ;;
esac

[ -z "$LINK" ] && die "Nothing to play"

$PLAYER "${LINK}"
