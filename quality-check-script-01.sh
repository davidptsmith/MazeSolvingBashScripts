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

      #get the standard input for the function 
      testString=$(cat)

    #first check to ensure that the document is not empty 
    if [ -z "${testString}" ]; then 
        passScript=false
      
      fi
      
      # collection of valid characters 
      invalidCharacters='[^\n\#[:space:]]'; 

      #Check for non valid characters 
      [[ ${testString} =~ $invalidCharacters ]] && passScript=false 


      #Test for only spaces and # as the condition is not met if it does not contain both 
      #Collection of valid characters 
      spacesChar='[\n\[:space:]]'; 
      hashChar='[\n\#]'; 

      # #run check using the regular expression as if a maze contains only spaces or hashs then it too is not valid 
       [[ ! ${testString} =~ $spacesChar ]] &&   passScript=false #echo "no spaces found" $
       [[ ! ${testString} =~ $hashChar ]] &&   passScript=false #echo "no hashes found" 


if $passScript ; then 
  echo yes
else
  echo no
fi

}

# setup colors and run main
setup_colors
main "${@}"


