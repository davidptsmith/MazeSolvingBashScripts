#!/bin/bash

# Author: David Smith 
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
 #set up global variable
 passScript=true; 

#get input
local STDIN;
 STDIN=$(cat)

#set up local variables 
local testColCount=${1}
local testRowCount=${2}

testRowCount=$((testRowCount*2+1))
testColCount=$((testColCount*2+1))

local RowCount; 
RowCount=0;

#loop through input variable 
 while IFS= read -r line; do  
               
                #if any of the lines are not equal to what is expected, fail the maze 
                if (( ${#line} != testColCount )); then
                   passScript=false;

                fi
                ((RowCount++)); 
                
        done <<<"$STDIN"


#run checks to ensure values are correct 
if (( RowCount != testRowCount )); then
  passScript=false;
fi

#return result 
if $passScript ; then 
  echo yes
else
  echo no
fi

 
}

# setup colors and run main
setup_colors
main "${@}"

