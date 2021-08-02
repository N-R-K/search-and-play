#!/bin/sh
#
## Copyright 2021 NRK
## Licensed under GPL v3. See LICENSE for more details.

### CONFIG ###
# For a list of ANSI color codes, check the link below
# https://gist.github.com/Prakasaka/219fe5695beeb4d6311583e79933a009
COL_TITLE="\033[1;31m"
COL_REST="\033[0;33m"

CACHE="/tmp/search-yt"
INSTANCE="https://invidious.snopyta.org/"
# INSTANCE="https://yewtu.be/"
# INSTANCE="https://invidious.048596.xyz/"
# INSTANCE="https://vid.puffyan.us/"

FILTERS="+content_type:video"
# This needs to be 2x
# 16 here for example will show 8 results
NUMBER_OF_RESULTS="16"

### Functions ###
usage() {
  printf "Usage: s [<args>] <search-term>\n"
  printf "
ARGUMENTS:
    -c         Disable color output.
    -n         Number of results to show.
    -l         Duration. Valid options <short|long>
    -d         Date. Valid options <hour|today|week|month|year>
    -h|--help  print this text and exit\n
NOTE: If there is no results, try changing the invidious instance.
      See https://github.com/N-R-K/search-and-play/tree/master#faq for more info.\n"
}

### Main ###

while [ -n "$1" ]; do
  case "$1" in
    "-h"|"--help")
      usage
      exit 0 ;;
    "-c")
      COL_TITLE=""
      COL_REST=""
      shift ;;
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

[ -z "$QUERY" ] &&
  printf "Nothing to search.\nUse 's --help' for help!\n" >/dev/stderr &&
  exit 1

curl -sS "$INSTANCE$QUERY$FILTERS" |
  awk -F '[<>]' \
    -v QUOTE="'" -v DQUOTE=\" -v AMP='\\&' \
    -v CACHE="$CACHE" \
    -v COL_TITLE="$COL_TITLE" -v COL_REST="$COL_REST" \
      '/href="\/watch.*<\/a>/ {
          gsub(/&#39;/,QUOTE);
          gsub(/&quot;/,DQUOTE);
          gsub(/&amp;/,AMP);
          print $4 > CACHE;
          print COL_TITLE "[" ++count "] " $5;
      }
      /length">/   { LENGTH=$3 }
      /channel\//  { AUTHOR=$3 }
      /Shared /    { gsub(/Shared /,""); AGE=$3 }
      /views*$/    { gsub(/[[:space:]]{2,}/,""); VIEWS=$0;
          print COL_REST AUTHOR " | " LENGTH " | " VIEWS " | " AGE }' |
  head -n "$NUMBER_OF_RESULTS"
