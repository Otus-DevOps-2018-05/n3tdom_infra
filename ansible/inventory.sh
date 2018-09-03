#!/bin/bash
#launch example ./inventory.sh --list

#debug
# set -e
# echo "Called as: $*" >> inventory.log

if [ "$1" = "--list" ] ; then
    cat $(dirname "$0")/inventory.json

elif [ "$1" = "--host" ]; then
    echo "Not implemented"
    exit -1
fi
