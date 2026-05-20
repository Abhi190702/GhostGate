#!/usr/bin/env bash
set -euo pipefail

INSIDE_IF="${INSIDE_IF:-ens37}"
OUTSIDE_IF="${OUTSIDE_IF:-ens33}"
ROUTER_DNS="${ROUTER_DNS:-10.10.10.1}"

sudo iptables -C FORWARD -i "$INSIDE_IF" -o "$OUTSIDE_IF" -p udp --dport 53 ! -d "$ROUTER_DNS" -j DROP 2>/dev/null \
  || sudo iptables -I FORWARD 1 -i "$INSIDE_IF" -o "$OUTSIDE_IF" -p udp --dport 53 ! -d "$ROUTER_DNS" -j DROP

sudo iptables -C FORWARD -i "$INSIDE_IF" -o "$OUTSIDE_IF" -p tcp --dport 53 ! -d "$ROUTER_DNS" -j DROP 2>/dev/null \
  || sudo iptables -I FORWARD 2 -i "$INSIDE_IF" -o "$OUTSIDE_IF" -p tcp --dport 53 ! -d "$ROUTER_DNS" -j DROP

sudo iptables -C FORWARD -i "$INSIDE_IF" -o "$OUTSIDE_IF" -j REJECT 2>/dev/null \
  || sudo iptables -I FORWARD 1 -i "$INSIDE_IF" -o "$OUTSIDE_IF" -j REJECT

echo "GhostGate lockdown enabled"
sudo iptables -L FORWARD -v -n
