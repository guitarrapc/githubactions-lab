#!/bin/bash
set -euo pipefail

# bash ./src/dummy/gen.sh

for i in {1..10}; do
  echo "$RANDOM" > "./src/dummy/$i.txt"
done
