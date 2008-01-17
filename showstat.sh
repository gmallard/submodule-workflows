#!/bin/bash
wd=/home/gallard/gw
#
cd $wd/sb.clone.one
echo "status in sb.clone.one"
git status
cd ab
echo "status in sb.clone.one/ab"
git status
#
cd $wd/sb.clone.two
echo "status in sb.clone.two"
git status
cd ab
echo "status in sb.clone.two/ab"
git status

