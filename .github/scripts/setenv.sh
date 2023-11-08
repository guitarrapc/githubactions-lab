#!/bin/bash
set -eux

while [ $# -gt 0 ]; do
    case $1 in
        --ref) GITHUB_REF=$2; shift 2; ;;
        *) shift ;;
    esac
done

echo BRANCH_SCRIPT=${GITHUB_REF} | tee -a "$GITHUB_ENV"
echo branch=${GITHUB_REF} | tee -a "$GITHUB_OUTPUT"
