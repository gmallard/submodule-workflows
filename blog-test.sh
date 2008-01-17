#!/bin/bash
set -x

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

# Super-repository

# Now, let's create the super-repository for our organizer:

cd ..
mkdir organizer
cd organizer
git init

# Now we add the submodules to the organizer repository:

git submodule add ../mail
git submodule add ../calendar

# The command submodule add clones the mail and calendar repositories under the organizer directory:

git status

cd mail
pwd
ls -a
git branch
git branch -r

# We commit the changes to organizer:

cd ..
pwd
git commit -a -m "Add mail and calendar modules to organizer"

# To see how things work, let's do some changes to our original mail module:

cd ../mail
pwd
echo "work" >> mail.txt
git commit -a -m "Working on mail client"
echo "more work" >> mail.txt
git commit -a -m "Still working on mail client"

# In order to commit these changes to the organizer repository, we go through the cloned repository:

cd ../organizer/mail
git pull
cd ..
git commit -a -m "Organizer version 0.1"

# Even though we may have done lots of commits in our modules, only one commit will appear in organizer.

# This repository layout should work nicely, as long as we don't clone our super-project and start pushing into it, as we will see shortly.

set +x
