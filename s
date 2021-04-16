#!/bin/sh

### CONFIG ###
# For a list of ANSI color codes, check the link below
# https://gist.github.com/Prakasaka/219fe5695beeb4d6311583e79933a009
COL_TITLE="\033[1;31m"
COL_REST="\033[0;33m"

CACHE="/tmp/search-yt"
INSTANCE="https://invidious.snopyta.org/"

FILTERS="+content_type:video"
# This needs to be 2x
# 16 here for example will show 8 results
NUMBER_OF_RESULTS="16"

### Main ###

while [ "$1" != "" ] ; do
  case "$1" in

    "-n")
      NUMBER_OF_RESULTS="$(( $2 * 2 ))";
      shift 2 ;;

    "-l")
      FILTERS="${FILTERS}+duration:$2";
      shift 2 ;;

    "-d")
      FILTERS="${FILTERS}+date:$2";
      shift 2 ;;

    *)
      QUERY="search?q=$( echo $@ | sed 's| |+|g' )";
      shift $# ;;

  esac
done

curl -sS "$INSTANCE$QUERY$FILTERS" |
  awk -F '[<>]' \
    -v QUOTE="'" -v DQUOTE=\" -v AMP='\\&' \
    -v CACHE="$CACHE" \
    -v COL_TITLE="$COL_TITLE" -v COL_REST="$COL_REST" \
      '/href="\/watch.*<\/a>/ {
          gsub(/&#39;/,QUOTE);
          gsub(/&quot;/,DQUOTE);
          gsub(/&amp;/,AMP);
          print COL_TITLE "[" ++count "] " $5;
          print $4 > CACHE
      } /length">/ { LENGTH=$3 
      } /channel\// { AUTHOR=$3 
      } /Shared / { gsub(/Shared /,""); AGE=$3
      } /views*$/ {
          gsub(/\s{2,}/,"");
          print COL_REST AUTHOR \
            " | " LENGTH \
            " | " $0 \
            " | " AGE } ' |
  head -n "$NUMBER_OF_RESULTS"
