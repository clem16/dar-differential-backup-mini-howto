#!/bin/sh

export LANG="en_GB"
svn update > /dev/null
svn update | sed -e "s#At revision \(.\+\).#\1#"
