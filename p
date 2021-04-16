#!/bin/sh

### CONFIG ###
PLAYER="devour mpv"
CACHE="/tmp/search-yt"

### Functions ###

### Main ###

[ -z "$1" ] &&
  LINK="$(xclip -o)" ||
  LINK="https://youtube.com$( awk -F '"' -v SELECTION="$1" \
    ' NR == SELECTION { print $2 } ' "${CACHE}" )"

$PLAYER "${LINK}"
