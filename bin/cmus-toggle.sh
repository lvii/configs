#!/bin/sh
# cmus - toggle play/pause

STATE=`cmus-remote -Q | grep status | cut -d " " -f2`

if [ "$STATE" = "paused" ]; then cmus-remote -p; fi
if [ "$STATE" = "playing" ]; then cmus-remote -u; fi
