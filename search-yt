#!/bin/sh

# NC="\033[0m"
RED="\033[1;31m"
YELLOW="\033[0;33m"

CACHE="/tmp/search-yt"
INSTANCE="https://invidious.snopyta.org/search?q="

QUERY="$( echo $@ | sed 's| |+|g' )"
TYPE="+content_type:video"
NUMBER_OF_RESULTS="16"

curl -s "$INSTANCE$QUERY$TYPE" |
  awk -F '[<>]' \
    -v QUOTE="'" -v DQUOTE=\" \
    -v CACHE="$CACHE" \
    -v RED="$RED" -v YELLOW="$YELLOW" \
      '/href="\/watch.*<\/a>/ {
          gsub(/&#39;/,QUOTE); gsub(/&quot;/,DQUOTE);
          print RED "[" ++count "] " $5; \
          print $4 > CACHE
      } /length">/ { LENGTH=$3 
      } /channel\// { AUTHOR=$3 
      } /Shared / { gsub(/Shared /,""); AGE=$3
      } /views*$/ {
          gsub(/\s{2,}/,"");
          print YELLOW AUTHOR \
            " | " LENGTH \
            " | " $0 \
            " | " AGE } ' |
  head -n "$NUMBER_OF_RESULTS"
