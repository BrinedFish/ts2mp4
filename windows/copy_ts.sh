#!/bin/bash
cd $(dirname $0)
echo --- >> log.txt
date >> log.txt
echo $0 >> log.txt
echo $1 >> log.txt
echo $2 >> log.txt
echo $3 >> log.txt
UNIX_PATH=$(cygpath -u "$3")
echo $UNIX_PATH >> log.txt
ORIG_FILE_NAME=$(basename "$UNIX_PATH")
echo $ORIG_FILE_NAME >> log.txt
FILE_NAME=$(date +%s)-$RANDOM.ts
echo $FILE_NAME >> log.txt

mv "$UNIX_PATH" tmp/$FILE_NAME

scp -c arcfour -i /home/jnakano/.ssh/id_rsa_nopp_scp_ts_to_ml110 "tmp/$FILE_NAME" 192.168.0.4:tmp/ts2mp4/ts 2>&1 >> log.txt
echo "$ORIG_FILE_NAME" > "tmp/${FILE_NAME}.queue"
echo $1 >> "tmp/${FILE_NAME}.queue"
echo $2 >> "tmp/${FILE_NAME}.queue"
scp -i /home/jnakano/.ssh/id_rsa_nopp_touch_ts_queue_at_ml110 "tmp/${FILE_NAME}.queue" 192.168.0.4:tmp/ts2mp4/queue 2>&1 >> log.txt

rm "tmp/${FILE_NAME}.queue"
rm "tmp/$FILE_NAME"
