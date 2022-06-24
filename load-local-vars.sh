#!/bin/sh

# export local vars
set -a
source vars/build/default.env
source vars/build/local.env
set +a

# potentially use base image shared with other repos
