#!/bin/bash
set -x
#
# Find out where we are
#
cmds=/home/gallard/submodule-workflows/salted-super
echo $cmds
#
# Run:
# - Pull all changes in work flow two
# - Work that changes files in work flow one
#
$cmds/wf-two.sh
$cmds/wf-one.sh
#
