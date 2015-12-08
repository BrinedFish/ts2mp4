#!/bin/sh

set -e
set -x


FILE_NAME="$1"
DEST_DIR="$2"
DEST_FILE_NAME="$3"

if [ -n "$DEST_FILE_NAME" ]; then
  PUT="put -O \"$DEST_DIR\" \"$FILE_NAME\" -o \"$DEST_FILE_NAME\""
else
  PUT="put -O \"$DEST_DIR\" \"$FILE_NAME\""
fi

echo "Uploading $FILE_NAME"

while : ; do
  lftp -u ts2mp4,ts2mp4 192.168.0.4 << _EOD
set cmd:fail-exit yes
$PUT
quit
_EOD
  [[ $? -ne 0 ]] || break
  echo "Fail, retry..."
  sleep 1
done
echo "Success"
