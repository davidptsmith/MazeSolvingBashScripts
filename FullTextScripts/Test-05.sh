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
  local STDIN;
  STDIN=$(cat);
 # echo "$STDIN"

#set up array of lines
lineArray=(); 

numCols=0; 

#loop through input and append the lines to the array of lines 
while IFS= read -r line; do            
        lineArray+=("$line");
        numCols=${#line};
done <<<"$STDIN"


numRows=${#lineArray[@]}


#set up an array of already visited cells - this will prevent loops in the maze and therefore infinite loops in the script
visitedArrr=(); 

#set up global variable to search for the exit - maybe if it stop searching 
foundExit=false; 

endCell="{ $((numCols -2)) , $((numRows -1)) }" 
 #echo "{ $((numCols -2)) , $((numRows -1)) }" 


#Uncomment out to show the matix array
replaceSpacesWithIndex

spacesChar='[\n\[:space:]]'; 


FullCheckCell_WithTextOutput 1 0


if $foundExit ; then 
  echo yes
else
  echo no
fi

}




#gets the neighbours of the current cell, current index {Row} then {Column} is used as an input
CheckCell()
{

#check to make sure that the exit has not already been found - if so, stop searching 
if ! $foundExit ; then 
    

  #set up inputs
  local currentCell="{ ${1} , ${2} }" 

  local rowIndex=$1
  local colIndex=$2

      local thisCellRow=$((rowIndex ))
     
      local thisCellLine=${lineArray[$thisCellRow]}

      local thisCellCharacter=${thisCellLine:${colIndex}:1}

  #ensure current cell is not white space (should only be needed for the first cell )
  if [[ $thisCellCharacter =~ $spacesChar ]]; then 
 
        #check if this is the end cell if so, set found to true
        if [ "${currentCell}" = "${endCell}" ]; then
          foundExit=true; 
        fi
        

        #check to make sure cell has not been visited 
      if [[ ! " ${visitedArrr[@]} " =~ " ${currentCell} " ]]; then
      
          #add cell to visited
          visitedArrr+=("$currentCell");

            #check to ensure it is valid index
            if ((rowIndex+1 > 0 && rowIndex+1 < numRows )); then 
              #get cell at location
                  local testRow=$((rowIndex+1 ))
                  local testReturnedRow=${lineArray[$testRow]}
                  local testReturnCharacter=${testReturnedRow:${colIndex}:1}

              #test for white 
                [[ $testReturnCharacter =~ $spacesChar ]] && CheckCell $(($1 + 1)) $(($2))
              
            fi


            if ((rowIndex-1 > 0 && rowIndex-1 < numRows )); then 

                  local testRow=$((rowIndex-1 ))
                  local testReturnedRow=${lineArray[$testRow]}
                  local testReturnCharacter=${testReturnedRow:${colIndex}:1}

              #test for white if yes, check this cell, else continue
                [[ $testReturnCharacter =~ $spacesChar  ]] && CheckCell $(($1 - 1)) $(($2))

            fi

              if ((colIndex-1 > 0 && colIndex-1 < numCols)); then 

                  local testCol=$((colIndex-1))
                  local testReturnedRow=${lineArray[$rowIndex]}
                  local testReturnCharacter=${testReturnedRow:${testCol}:1}
              #test for white 
                [[ $testReturnCharacter =~ $spacesChar ]] && CheckCell $(($1)) $(($2 - 1))

            fi

            if ((colIndex+1 > 0 && colIndex+1 < numCols)); then 
                  local testCol=$((colIndex+1))
                  local testReturnedRow=${lineArray[$rowIndex]}
                  local testReturnCharacter=${testReturnedRow:${testCol}:1}
              #test for white 
                [[ $testReturnCharacter =~ $spacesChar  ]] && CheckCell $(($1)) $(($2 + 1))

            fi

      #else
        fi    
      fi

  fi
 
}

replaceSpacesWithIndex()
{
  
    for((i=0;i<numRows;i++)); do
      for((j=0;j<numCols;j++)); do

        local rowItem=${lineArray[${i}]};
        local charItem=${rowItem:${j}:1};

       local spacesChar='[\n\[:space:]]'; 

        # [[ $charItem =~ $spacesChar ]] && echo -n "{${i},${j}}" || echo -n "{ # }"
         [[ $charItem =~ $spacesChar ]] && echo -n "{$(printf "%02d" "${i}"),$(printf "%02d" "${j}")}" || echo -n "{  #  }"
      done
      echo
    done
    

  
}
#gets the neighbours of the current cell, current index {Row} then {Column} is used as an input
FullCheckCell_WithTextOutput()
{

    #check to make sure that the exit has not already been found - if so, stop searching 
    if ! $foundExit ; then 
        

      #set up inputs
      local currentCell="{ ${1} , ${2} }" 

      local rowIndex=$1
      local colIndex=$2

          local thisCellRow=$((rowIndex ))
        
          local thisCellLine=${lineArray[$thisCellRow]}

          local thisCellCharacter=${thisCellLine:${colIndex}:1}
    echo "$thisCellCharacter"
      #ensure current cell is not white space (should only be needed for the first cell )
      if [[ $thisCellCharacter =~ $spacesChar ]]; then 
    
      echo "$currentCell"

            #check if this is the end cell 
            if [ "${currentCell}" = "${endCell}" ]; then
              foundExit=true; 
              echo "FOUND THE EXIT"
            fi
            

            #check to make sure cell has not been visited 
          if [[ ! " ${visitedArrr[@]} " =~ " ${currentCell} " ]]; then
          

          # echo "inside loop ${currentCell}" 

              #add cell to visited
              visitedArrr+=("$currentCell");

                #check to ensure it is valid index
                if ((rowIndex+1 > 0 && rowIndex+1 < numRows )); then 
                  #get cell at location
                      local testRow=$((rowIndex+1 ))
                      local testReturnedRow=${lineArray[$testRow]}
                      local testReturnCharacter=${testReturnedRow:${colIndex}:1}

                  #test for white 
                    [[ $testReturnCharacter =~ $spacesChar ]] && CheckCell $(($1 + 1)) $(($2)) || echo "blocked" $((rowIndex+1)) $((colIndex)) 
                  
                fi


                if ((rowIndex-1 > 0 && rowIndex-1 < numRows )); then 

                      local testRow=$((rowIndex-1 ))
                      local testReturnedRow=${lineArray[$testRow]}
                      local testReturnCharacter=${testReturnedRow:${colIndex}:1}

                  #test for white if yes, check this cell, else continue
                    [[ $testReturnCharacter =~ $spacesChar  ]] && CheckCell $(($1 - 1)) $(($2))|| echo "blocked" $((rowIndex-1)) $((colIndex)) 

                fi


                  if ((colIndex-1 > 0 && colIndex-1 < numCols)); then 

                      local testCol=$((colIndex-1))
                      local testReturnedRow=${lineArray[$rowIndex]}
                      local testReturnCharacter=${testReturnedRow:${testCol}:1}
                  #test for white 
                    [[ $testReturnCharacter =~ $spacesChar ]] && CheckCell $(($1)) $(($2 - 1))|| echo "blocked" $((rowIndex)) $((colIndex-1)) 

                fi

                if ((colIndex+1 > 0 && colIndex+1 < numCols)); then 
                      local testCol=$((colIndex+1))
                      local testReturnedRow=${lineArray[$rowIndex]}
                      local testReturnCharacter=${testReturnedRow:${testCol}:1}
                  #test for white 
                    [[ $testReturnCharacter =~ $spacesChar  ]] && CheckCell $(($1)) $(($2 + 1))   || echo "blocked" $((rowIndex)) $((colIndex+1)) 

                fi

          #else
            fi    
          fi

      fi
 
}



# setup colors and run main
setup_colors
main "${@}"

