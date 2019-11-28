#!/bin/bash

if [ $# -gt 1 ]; then
    echo "usage: up amount"
    return 1
elif [ $# -eq 1 ]; then
    amount=$1
else
    amount=1
fi

if [[ "$amount" == "0" ]]; then
    return 0
fi

if [[ "${amount:0:1}" == "0" ]]; then
    echo "Don't"
    return 1
fi

if [[ $(($amount)) -eq 0 ]]; then
    echo "$amount not an integer"
    return 1
fi

for ((i=0;i<$(($amount));++i)); do
    cd ..
done
