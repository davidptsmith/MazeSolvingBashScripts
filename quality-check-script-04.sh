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
Usage: $(basename "${BASH_SOURCE[0]}")

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
  elif [ "$#" -ne 0 ] ; then
    printf >&2 "${RED}Error:${NOFORMAT} Expected 0 args; got %s. See \"usage\" below.\n" "$#"
    usage;
    exit 1;
  fi

  # you probably want to put other code here.
 #set up global variable 
 passScript=true; 

local STDIN;
 STDIN=$(cat)

RowCount=0;
ColCount=0;  
 while IFS= read -r line; do  

                ((RowCount++)); 
                if ((ColCount == 0)); then 
                     ColCount=${#line};
             
               elif (( ColCount != ${#line} )); then #this should throw an exception as the maze is not valid if the lines dont have the same length

                   ColCount=${#line};
                fi
                
        done <<<"$STDIN"
        
#set up regular expressions 
  spacesChar='[\n\[:space:]]'; 
  hashChar='[\n\#]'; 
  notHashChar='[^\n\#]'; 
     
 local index=0;
 while IFS= read -r line; do  
                #test the whole first & last lines for exits - nonHashes chars
               if ((index == 0)); then 
                   [[ ${line} =~ $notHashChar ]] &&   passScript=false;
               fi
                if ((index == RowCount-1)); then 
                   [[ ${line} =~ $notHashChar ]] &&   passScript=false;
               fi
               
                #if first row, check for entry cell
                if ((index == 1)); then 
                  local firstCharacter=${line:0:1}
                   [[ ! ${firstCharacter} =~ $spacesChar ]] && passScript=false;
                fi
                #if second last row, test for exit cell 
                if ((index == RowCount-2)); then 
                  local lastCharacter="${line: -1}"
                   [[ ! ${lastCharacter} =~ $spacesChar ]] &&  passScript=false;
                fi

                #check the first char if not the entry row
                if ((index != 1)); then 
                  local firstCharacter=${line:0:1}
                   [[ ! ${firstCharacter} =~ $hashChar ]] && passScript=false;
                fi
                #check the last char if not the exit row 
                if ((index != RowCount-2)); then 
                  local lastCharacter="${line: -1}"
                   [[ ! ${lastCharacter} =~ $hashChar ]] && passScript=false;
                fi
              
              ((index++));
        done <<<"$STDIN"


if $passScript ; then 
  echo yes
else
  echo no
fi

}

# setup colors and run main
setup_colors
main "${@}"

