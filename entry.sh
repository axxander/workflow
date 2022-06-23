#!/bin/sh

# -x option: print commands ran
# -e option: exit immediately for non-zero return status (error)
set -ex

# format terminal
export TERM=xterm-256color

DATE=`/bin/date +%Y-%m-%d-%H:%M:%S`

# Do we need to do this whole `pipeline` thing? What is the benefit of this?
if [ "$1" = pipeline ]; then
    echo "Starting "$2" pipeline."
    /venv/bin/python src/$2/main.py
    echo "Finished "$2" pipeline."
    exit $?
fi
