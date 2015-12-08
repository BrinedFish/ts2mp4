#!/bin/sh

set -x
set -e

# $1: ts file

TS_NAME=$1
TMP_MP4_NAME=$(echo "$TS_NAME" | sed -e s/\.ts$/.mp4/)
PROGRAM_ID=340

if [ ${#PROGRAM_ID} -gt 0 ]; then
  PROGRAM_OPT_V="-map 0:p:${PROGRAM_ID}:0"
  PROGRAM_OPT_A="-map 0:p:${PROGRAM_ID}:1"
fi
echo $PROGRAM_OPT_V
echo $PROGRAM_OPT_A

# ffmpeg -i 2015-09-12\ 00：00\ \[ディスカバリー\]名車再生\!AMCペーサー\(二\).ts -map 0:p:340:0 -c:v libx264 -map 0:p:340:1 -c:a libfdk_aac test.mp4
/home/jnakano/ffmpeg/bin/ffmpeg -y -i "$TS_NAME" -pass 1 $PROGRAM_OPT_V -c:v libx264 -preset slow -profile main -filter:v yadif=1 -level 3.1 -s 720x480 -b:v 1M -an "$TMP_MP4_NAME"
/home/jnakano/ffmpeg/bin/ffmpeg -y -i "$TS_NAME" -pass 2 $PROGRAM_OPT_V -c:v libx264 -preset slow -profile main -filter:v yadif=1 -level 3.1 -s 720x480 -b:v 1M $PROGRAM_OPT_A -c:a libfdk_aac "$TMP_MP4_NAME"

