#!/bin/bash
PID=$(pgrep -x hypridle)
[[ -z "$PID" ]] && exit
if ps -o state= -p "$PID" | grep -q T; then
    kill -CONT "$PID"
    notify-send -t 1000 "Hypridle active"
else
    kill -STOP "$PID"
    notify-send -t 1000 "Hypridle suspended"
fi
