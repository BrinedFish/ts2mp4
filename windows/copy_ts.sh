#!/bin/bash
set -x

cd $(dirname $0)
date
echo $1
echo $2
echo $3
UNIX_PATH=$(cygpath -u "$3")
ORIG_FILE_NAME=$(basename "$UNIX_PATH")
FILE_NAME=$(date +%s)-$RANDOM.ts
ls -l "$UNIX_PATH"
mv "$UNIX_PATH" tmp/$FILE_NAME

#scp -c arcfour -i /home/jnakano/.ssh/id_rsa_nopp_scp_ts_to_ml110 "tmp/$FILE_NAME" 192.168.0.4:tmp/ts2mp4/ts 2>&1 >> log.txt
lftp -u ts2mp4,ts2mp4 192.168.0.4 << _EOD
set cmd:fail-exit yes
cd ts
put "tmp/$FILE_NAME"
quit
_EOD

echo "$ORIG_FILE_NAME" > "tmp/${FILE_NAME}.queue"
echo $1 >> "tmp/${FILE_NAME}.queue"
echo $2 >> "tmp/${FILE_NAME}.queue"
scp -i /home/jnakano/.ssh/id_rsa_nopp_touch_ts_queue_at_ml110 "tmp/${FILE_NAME}.queue" 192.168.0.4:tmp/ts2mp4/queue 2>&1

rm "tmp/${FILE_NAME}.queue"
rm "tmp/$FILE_NAME"
