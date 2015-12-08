#!/bin/sh
cd $(dirname $0)/..

(ls queue && /usr/bin/inotifywait -q -m -e CLOSE_WRITE --format %w%f queue) | /usr/bin/parallel -j1 -u 'scripts/convert.sh >> logs/parallel.log 2>&1'
