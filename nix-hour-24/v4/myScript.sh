#!/usr/bin/env bash

passwordFile=$1
while true; do
    echo "The secret is: " $(cat "$passwordFile")
done
