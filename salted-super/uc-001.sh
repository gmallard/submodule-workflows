#!/bin/bash
set -x
#
# Find out where we are
#
p=$(pwd)
echo $p
#
# Run:
# - Work that changes files in work flow one
# - Pull those changes in work flow two
#
$p/wf-one.sh testa
$p/wf-two.sh testb
#
# Run the above work sequence again, but from the other direction.
#
$p/wf-one.sh testb
$p/wf-two.sh testa
#
# Repeat the above sequence as many times as you like.
#
