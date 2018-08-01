#!/bin/bash
#launch example ./get-inventory.sh --list

if [ "$1" = "--list" ] ; then
    cat $(dirname "$0")/inventory.json
else
  exit
fi
