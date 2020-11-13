#!/bin/bash
while [ $# -gt 0 ]; do
    case $1 in
        --ref) GITHUB_REF=$2; shift 2; ;;
        *) shift ;;
    esac
done

echo GIT_TAG_SCRIPT=${GITHUB_REF#refs/tags/} >> $GITHUB_ENV
