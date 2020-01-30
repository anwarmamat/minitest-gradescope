This folder includes all the files except the solution. Autograder copies all the files
from this folder and student submission to the /autograder/source folder and executes
run_atuograder script.

This folder includes:

1. All the test files
2. All the necessary files that student do not have to submit
3. score.txt: This file includes all the test names and their score.


The plugin reads the project path from the environment variable
GRADESCOPE_PATH. Default GRADESCOPE_PATH=/autograder/source

If you want to use a differene path,  must set
export GRADESCOPE_PATH=/autograder/source
