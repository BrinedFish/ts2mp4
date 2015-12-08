#!/bin/bash
set -x
set -e

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

echo "$ORIG_FILE_NAME" > "tmp/${FILE_NAME}.queue"
echo $1 >> "tmp/${FILE_NAME}.queue"
echo $2 >> "tmp/${FILE_NAME}.queue"

#scp -c arcfour -i /home/jnakano/.ssh/id_rsa_nopp_scp_ts_to_ml110 "tmp/$FILE_NAME" 192.168.0.4:tmp/ts2mp4/ts >> log.txt 2>&1
#lftp -u ts2mp4,ts2mp4 192.168.0.4 << _EOD
#set cmd:fail-exit yes
#cd ts
#put "tmp/$FILE_NAME"
#quit
#_EOD
#wput --basename=tmp/ tmp/$FILE_NAME ftp://ts2mp4:ts2mp4@192.168.0.4/ts/
./lftp.sh "tmp/$FILE_NAME" ts

scp -i /home/jnakano/.ssh/id_rsa_nopp_touch_ts_queue_at_ml110 "tmp/${FILE_NAME}.queue" 192.168.0.4:tmp/ts2mp4/queue 2>&1

rm "tmp/$FILE_NAME"
rm "tmp/${FILE_NAME}.queue"
