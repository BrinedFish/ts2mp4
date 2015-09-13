#!/bin/sh

set -x

OUT_DIR=/home/hatsune/public_html/tv

# $1: queue file

cd $(dirname $0)/../

QUEUE_NAME=$(basename "$1")
TS_NAME=$(echo "$QUEUE_NAME" | sed -e s/\.queue$//)
TMP_MP4_NAME=$(echo "$TS_NAME" | sed -e s/\.ts$/.mp4/)
MP4_NAME=$(sed -n 1p "queue/$QUEUE_NAME" | sed -e s/\.ts$/.mp4/)
PROGRAM_ID=$(sed -n 3p "queue/$QUEUE_NAME")

if [ ${#PROGRAM_ID} -gt 0 ]; then
  PROGRAM_OPT_V="-map 0:p:${PROGRAM_ID}:0"
  PROGRAM_OPT_A="-map 0:p:${PROGRAM_ID}:1"
fi
echo $PROGRAM_OPT_V
echo $PROGRAM_OPT_A

# ffmpeg -i 2015-09-12\ 00：00\ \[ディスカバリー\]名車再生\!AMCペーサー\(二\).ts -map 0:p:340:0 -c:v libx264 -map 0:p:340:1 -c:a libfdk_aac test.mp4
/home/jnakano/ffmpeg/bin/ffmpeg -y -i "ts/$TS_NAME" $PROGRAM_OPT_V -c:v libx264 -preset veryfast -profile main -level 3.1 -s 1280x720 $PROGRAM_OPT_A -c:a libfdk_aac "mp4/$TMP_MP4_NAME"
chmod 777 "mp4/$TMP_MP4_NAME"
mv "mp4/$TMP_MP4_NAME" "$OUT_DIR/$MP4_NAME"

mv "ts/$TS_NAME" ts_finished
mv "queue/$QUEUE_NAME" queue_finished
