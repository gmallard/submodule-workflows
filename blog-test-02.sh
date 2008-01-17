#!/bin/bash

# Let's create a base directory for our project, say ~/pim, and two subdirectories mail and calendar for our modules:

mkdir pim
cd pim
mkdir mail
mkdir calendar

# Now, let's create a git repository for our email client:

cd mail
git init
echo "mail client" > mail.txt
git add mail.txt
git commit -m "Mail client initial commit"

# Same for the calendar:

cd ../calendar
git init
echo "calendar" > cal.txt
git add cal.txt
git commit -m "Calendar initial commit"

# Then, something like:

cd ~/pim
mkdir public
cd public/
git clone --bare ../mail mail.git
git clone --bare ../calendar cal.git
cd ..
mkdir organizer #(supposing we are starting afresh)
cd organizer
git init
git submodule add ../public/mail.git
git submodule add ../public/cal.git
ls -a
ls -a mail
cat .gitmodules
