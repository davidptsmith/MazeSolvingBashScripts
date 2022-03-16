#!/bin/bash

# Author: **FILL IN YOUR NAME HERE**
#
# Maze quality control script

# You can set these Bash options if desired -- see discussions from class.
# set -u
# set -e

usage() {
  # shellcheck disable=SC2059
  p () { printf "${PURPLE}"; }
  # shellcheck disable=SC2059
  nf () { printf "${NOFORMAT}"; }
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") num_cols num_rows

Validates a maze supplied on standard input,
printing "yes" if the maze is valid, and
"no" if it is invalid.

Available options:
--help      Print this help and exit
EOF
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    # shellcheck disable=SC2034
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m'
    BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m';
  else
    # shellcheck disable=SC2034
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

main () {
  # validate args
  if [ "$#" -eq 1 ] && [ "$1" = "--help" ] ; then
    usage;
    exit;
  elif [ "$#" -ne 2 ] ; then
    printf >&2 "${RED}Error:${NOFORMAT} Expected 2 args; got %s. See \"usage\" below.\n" "$#"
    usage;
    exit 1;
  fi

  # you probably want to put other code here.
local STDIN;
 STDIN=$(cat)

local testRowCount=${1}
local testColCount=${2}

testRowCount=$((testRowCount*2+1))
testColCount=$((testColCount*2+1))

local RowCount; 
local ColCount; 
RowCount=0;
ColCount=0;  
 while IFS= read -r line; do  
                echo "Line: ${line} RowCount: ${RowCount} Col Count:${#line}"; 
                ((RowCount++)); 
                if ((ColCount < ${#line} )); then
                   ColCount=${#line};
                elif (( ColCount != testColCount )); then
                   ColCount=${#line};
                fi
                
        done <<<"$STDIN"

echo "${testRowCount} ";
echo "${testColCount} ";

echo "${RowCount}";
echo "${ColCount}";


if (( RowCount != testRowCount )); then
  echo "rows arent equal";
fi

if (( ColCount != testColCount )); then
  echo "columns arent equal";
fi

 if (( RowCount != testRowCount)) || ((ColCount != testColCount )); then
                   echo "damnnn this aint right";
                fi

  echo end
    printf '%s' "$STDIN" 
 
}

# setup colors and run main
setup_colors
main "${@}"

