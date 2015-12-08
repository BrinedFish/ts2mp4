inotifywait -m -e CLOSE_WRITE --format %w%f queue | parallel -j1 -u scripts/convert.sh
