#!/usr/bin/env bash

set -euo pipefail

passwordFile=$1
while true; do
    secret=$(cat "$passwordFile") || exit 1;
    echo "The secret is: $secret"
done
