#!/bin/sh
cur="$(dirname $0)"
cd $cur
cat CHANGELOG.md |sed -n '/^##/,$p' |head -1 |sed  's/^## \(.*\)/\1/'
