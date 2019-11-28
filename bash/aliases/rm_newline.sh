#!/bin/bash

if [ "$#" -ne "1" ]; then
    echo "usage: rmn file"
    return 1
fi

r=`tail -c 1 $1`
if [ "$r" != "" ]; then
    echo "File doesn't end with new-line"
    return 1
fi

cat $1 | head -c-1 | sponge $1
return 0
