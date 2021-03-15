#!/bin/sh

LINK=$(grep -P "\[$1\]" /tmp/search-yt | sed "s/\[$1\]\ //g;s/\s.*$//")

devour mpv "https://youtube.com/watch?v=${LINK}"
