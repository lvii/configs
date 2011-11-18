#!/bin/sh

PROJECT_DIR=~/build

old_dir=`pwd`
for dir in $PROJECT_DIR/*; do
    if [ -d $dir/.git ]; then 
        cd $dir
        if [ "`git status | grep 'Your branch is ahead of'`" != "" ]; then
            git push -u origin master
        fi
    fi
done
cd $old_dir
