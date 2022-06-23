#!/bin/sh

set -ex

export TERM=xterm-256color

DATE=`/bin/date +%Y-%m-%d-%H:%M:%S`

# Execute all tests or tests within a single directory
/venv/bin/pytest -v tests/$1
