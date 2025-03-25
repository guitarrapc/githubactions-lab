#!/bin/bash
set -eo pipefail

docker run -it -v .:/github ghcr.io/woodruffw/zizmor:1.5.2 /github
