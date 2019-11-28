#!/bin/bash

if [ "$#" -ne "2" ]; then
	echo "Usage: $0 file1 file2"
	exit 1
fi

cmp -l $1 $2 | gawk '{printf "%08d %02X %02X\n", $1, strtonum(0$2), strtonum(0$3)}'
