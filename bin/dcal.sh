#!/bin/sh

if pgrep -x dcal; then
	killall dcal
else
	dcal $*
fi
