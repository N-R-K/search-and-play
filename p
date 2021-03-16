#!/bin/sh

PLAYER="devour mpv"
CACHE="/tmp/search-yt"

[ -z "$1" ] &&
  LINK="$(xclip -o)" ||
  LINK="https://youtube.com$( awk -F '"' -v selection="$1" \
    ' NR == selection { print $2 } ' "${CACHE}" )"

$PLAYER "$LINK"
