#!/bin/bash
#if [[ $# -eq 0 ]] ; then
#    echo 'Usage: ./merge_with_master.sh f/branch'
#    exit 0
#else 
#    echo 'About to merge' $1 'with master'
#fi
CUR_BRANCH=`git name-rev --name-only HEAD`
echo 'About to merge' $CUR_BRANCH 'with master'

git checkout master 
git pull 
git checkout $CUR_BRANCH
git pull 
git rebase -i master 
git checkout master 
git merge $CUR_BRANCH
git push -u origin master 
