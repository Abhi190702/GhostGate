#!/usr/bin/env bash
set -euo pipefail

INSIDE_IF="${INSIDE_IF:-ens37}"
OUTSIDE_IF="${OUTSIDE_IF:-ens33}"

while sudo iptables -C FORWARD -i "$INSIDE_IF" -o "$OUTSIDE_IF" -j REJECT 2>/dev/null; do
  sudo iptables -D FORWARD -i "$INSIDE_IF" -o "$OUTSIDE_IF" -j REJECT
done

echo "GhostGate lockdown disabled"
sudo iptables -L FORWARD -v -n
