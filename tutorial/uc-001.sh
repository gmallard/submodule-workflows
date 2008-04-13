#!/bin/bash
set -x
p=$(pwd)
echo $p
#
$p/wf-one.sh private
$p/wf-two.sh private2
#
$p/wf-one.sh private2
$p/wf-two.sh private
