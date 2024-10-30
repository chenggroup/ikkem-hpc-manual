#!/bin/bash -l

set -e
cd $(dirname $0)

timeout 60 git pull
timeout 60 mkdocs build
