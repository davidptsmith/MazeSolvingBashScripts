# Extension Task Rule 7
***"There should always be a route from any cell to the exit."***

## Introduction 
This script checks to see if there are any cells where there is not a path to the exit and highlights those cells in the ouput. 
If all white space cells can find their way to the exit the command will respond with yes. 

## Instructions: 
CD into /assignment1/extensions and run ./demo.sh

This will run a few built in examples.

Feel free to add other text files to the test. 
Just pipe mage gen into a txt file and make the required changes. 

Note that this test assumes the passing of the previous tests and only tests for fule 7. 

## How it works
First is checks to see if there is a path to the exit
It assumes the other steps have been checked for to ensure a valid maze has been passed to the script 