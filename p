#!/bin/sh

PLAYER="devour mpv"
CACHE="/tmp/search-yt"

# No arugments given
[ -z "$1" ] &&
  LINK="$(xclip -o)" ||
  LINK="https://youtube.com/watch?v=$(grep -P "\[$1\]" "$CACHE" | sed "s/\[$1\]\ //g;s/\s.*$//")"

$PLAYER "$LINK"
