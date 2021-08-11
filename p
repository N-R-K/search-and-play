#!/bin/sh
#
## Copyright 2021 NRK
## Licensed under GPL v3. See LICENSE for more details.

### CONFIG ###
PLAYER="mpv"
CLIPBOARD_CMD="xclip -o"
CACHE="/tmp/search-yt"

### Functions ###
die() {
  [ -n "$1" ] &&
    printf "$@\n" > /dev/stderr
  exit 1
}

usage() {
  printf "Usage: p [ID]\n"
  printf "
  p(lay) is meant to be used with s(earch)
  p [ID] will play from the s(earch) results
  When invoked without an argument, it will simply try to play whatever is in your clipboard (xclip by default)\n\n"
  exit
}

play_clipboard() {
  command -v "${CLIPBOARD_CMD%% *}" >/dev/null 2>&1 ||
    die "Clipboard not found"
  LINK="$($CLIPBOARD_CMD)"
}

play_id() {
  [ -f "$CACHE" ] ||
    die "$CACHE doesn't exist"

  LINK=$(sed -n "s|\"||g;${1}p" "$CACHE")
}

### Main ###

command -v "${PLAYER%% *}" >/dev/null 2>&1 ||
  die "$PLAYER not found."

case "$1" in
  "-h"|"--help") usage ;;
  [0-9]*)
    [ "$1" -eq "$1" 2>/dev/null ] &&
      play_id "$1" || die "Invalid"
    ;;
  "") play_clipboard ;;
  *) die "Invalid" ;;
esac

[ -z "$LINK" ] && die "Nothing to play"

$PLAYER "${LINK}"
