#!/bin/bash -x

TS=$1
OUT=$2
BASE=$(basename $TS .ts)
[ "${BASE}.ts" = "$(basename $TS)" ] || exit 1

#CPU_CORES=0
CPU_CORES=$(/usr/bin/getconf _NPROCESSORS_ONLN)

#X264_HIGH_HDTV="-f mp4 -vcodec libx264 \
#        -vpre  libx264-hq-ts \
#            -r 30000/1001 -aspect 16:9 -s 1280x720 -bufsize 20000k -maxrate 25000k \
#                -ac 2 -ar 48000 -ab 128k -threads ${CPU_CORES} -strict -2 "
OPTIONS="-c:v libx264 -preset medium -s 640x480"
ffmpeg -y -i $TS ${OPTIONS} $OUT/${BASE}.mp4

exit
