#!/bin/bash
echo "ref"
echo ${{ github.ref }}

echo "dump"
echo ${{ toJson(github) }}
