#!/usr/bin/env bash

# path on the gradescope server
cd /autograder/source/src

#if the environement variable is set
#cd $GRADESCOPE_PATH/src

rm -f results.json 

ruby public.rb --gradescope >/dev/null

#cat $GRADESCOPE_PATH/results.json

cat results.json


