#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'Usage: ./merge_with_master.sh f/branch'
    exit 0
else 
    echo 'About to merge' $1 'with master'
fi
git checkout master 
git pull 
git checkout $1
git pull 
git rebase -i master 
git checkout master 
git merge $1
git push -u origin master 
