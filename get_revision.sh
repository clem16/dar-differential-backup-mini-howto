#!/bin/sh

# Gets the iso day, then appends the unix timestamp.
GITDATE=`git log -1 --format=%ci`
echo ${GITDATE:0:10}-`git log -1 --format=%ct`
