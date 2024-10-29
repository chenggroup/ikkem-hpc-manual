#!/bin/bash -l

set -e
cd $(dirname $0)

timeout 30 git pull
timeout 30 mkdocs build
