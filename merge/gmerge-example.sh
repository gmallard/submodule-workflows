#!/bin/bash
mkdir playground
cd playground
git init
echo "hello, world" > greeting
git add greeting 
git commit -m "Add greeting on master"
git checkout -b left
git mv greeting saludo
git commit -a -m "Rename greeting on left"
git checkout master
git rm greeting
git commit -a -m "Delete greeting on master"
git merge left
