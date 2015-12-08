#!/bin/sh

for FILENAME in *.ts; do
  ~/scripts/lftp.sh "$FILENAME" tmp 1.ts && \
  ssh ml110 'cd tmp/ts2mp4/tmp && ./convert_yadif.sh 1.ts' && \
  scp -c arcfour ml110:tmp/ts2mp4/tmp/1.mp4 "${FILENAME%.ts}.mp4" && \
  ssh ml110 'cd tmp/ts2mp4/tmp && rm 1.* ffmpeg2pass*'
done

