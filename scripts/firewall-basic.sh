#!/usr/bin/env bash
set -euo pipefail

INSIDE_IF="${INSIDE_IF:-ens37}"
ROUTER_DNS="${ROUTER_DNS:-10.10.10.1}"

sudo iptables -C FORWARD -i "$INSIDE_IF" -p udp --dport 53 ! -d "$ROUTER_DNS" -j DROP 2>/dev/null \
  || sudo iptables -I FORWARD 1 -i "$INSIDE_IF" -p udp --dport 53 ! -d "$ROUTER_DNS" -j DROP

sudo iptables -C FORWARD -i "$INSIDE_IF" -p tcp --dport 53 ! -d "$ROUTER_DNS" -j DROP 2>/dev/null \
  || sudo iptables -I FORWARD 2 -i "$INSIDE_IF" -p tcp --dport 53 ! -d "$ROUTER_DNS" -j DROP

if command -v netfilter-persistent >/dev/null 2>&1; then
  sudo netfilter-persistent save
fi

sudo iptables -L FORWARD -v -n
