#!/bin/sh

# NC="\033[0m"
RED="\033[1;31m"
YELLOW="\033[0;33m"

CACHE="/tmp/search-yt"
INSTANCE="https://invidious.snopyta.org/"

TYPE="+content_type:video"
NUMBER_OF_RESULTS="16"

while [ "$1" != "" ] ; do
  case "$1" in

    "-n")
      NUMBER_OF_RESULTS="$(( $2 * 2 ))";
      shift 2 ;;

    *)
      QUERY="search?q=$( echo $@ | sed 's| |+|g' )";
      shift $# ;;

  esac
done

# debugging
# echo $NUMBER_OF_RESULTS
# echo $QUERY

curl -s "$INSTANCE$QUERY$TYPE" |
  awk -F '[<>]' \
    -v QUOTE="'" -v DQUOTE=\" -v AMP='\\&' \
    -v CACHE="$CACHE" \
    -v RED="$RED" -v YELLOW="$YELLOW" \
      '/href="\/watch.*<\/a>/ {
          gsub(/&#39;/,QUOTE);
          gsub(/&quot;/,DQUOTE);
          gsub(/&amp;/,AMP);
          print RED "[" ++count "] " $5;
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
