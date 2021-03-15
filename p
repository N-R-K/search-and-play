#!/bin/sh

PLAYER="devour mpv"
CACHE="/tmp/search-yt"

# No arugments given
[ -z "$1" ] && LINK="$(xclip -o)" ||
  ID="$(grep -P "\[$1\]" "$CACHE" | sed "s/\[$1\]\ //g;s/\s.*$//")"

[ -n "$1" ] && LINK="https://youtube.com/watch?v=$ID"

$PLAYER "$LINK"
