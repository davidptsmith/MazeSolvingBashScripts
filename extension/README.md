# Extension Task Rule 7
***"There should always be a route from any cell to the exit."***

## Introduction 
This script checks to see if there are any cells where there is not a path to the exit and highlights those cells in the ouput. 
If there is no error the command will respond with yes. 

## Instructions: 
To run the pass the maze to the script and it will work out first if there is a path to the exit, then it will check for any left over cells and ensure that they cannot find their way out of the maze. 

Pipe in test files from text file with maze or outputs into the function
*eg:*  cat ./extension/Test_2.txt  | ./extension/extension.sh  

## How it works
First is checks to see if there is a path to the exit
It checks any cells that were not visited 
If they still cannot find an exit they are then added to a list of issue cells
if there are errors, these are then highlighted in the output followed by the result "no"