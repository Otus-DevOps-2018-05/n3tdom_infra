#!/bin/bash
#launch example ./get-inventory.sh --list

#debug
# set -e
# echo "Called as: $*" >> inventory.log

if [ "$1" = "--list" ] ; then 
    cat $(dirname "$0")/inventory.json

elif [ "$1" = "--host" ]; then
# Not implemented
    echo "{}"
fi
