#!/usr/bin/env bash

current=$(/run/current-system/sw/bin/powerprofilesctl get)

case "$current" in
  "power-saver")
    icon=""
    ;;
  "balanced")
    icon=""
    ;;
  "performance")
    icon=""
    ;;
esac

echo "{\"text\": \"$icon\", \"class\": \"$current\", \"tooltip\": \"Power profile: $current\"}"
