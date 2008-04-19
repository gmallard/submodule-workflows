#!/bin/bash
set -x
#
# Housekeeping: set up working directory for this test.
#
here=$(dirname $0)
. $here/../common/setvars
#
chown -R $user.$group $public/*
find $public -type d -exec chmod 2775 {} \;
find $public -type f -exec chmod 664 {} \;
