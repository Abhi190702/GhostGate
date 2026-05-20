#!/usr/bin/env bash
set -euo pipefail

INSIDE_IF="${INSIDE_IF:-ens37}"
MODE="${1:-tcpdump}"

case "$MODE" in
  tcpdump)
    sudo tcpdump -i "$INSIDE_IF"
    ;;
  iftop)
    sudo iftop -i "$INSIDE_IF"
    ;;
  vnstat)
    vnstat -i "$INSIDE_IF"
    ;;
  *)
    echo "Usage: monitor-traffic.sh {tcpdump|iftop|vnstat}"
    exit 1
    ;;
esac
