#!/bin/sh

ffmpeg -i input.mp4 \
  -c:v libx265 \
  -crf 28 \
  -preset medium \
  -x265-params no-open-gop=1:keyint=300:gop-lookahead=12:bframes=6:weightb=1:hme=1:strong-intra-smoothing=0:rect=0:aq-mode=4 \
  -c:a aac -b:a 192k \
  output.mp4
