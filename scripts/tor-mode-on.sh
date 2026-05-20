#!/usr/bin/env bash
set -euo pipefail

INSIDE_IF="${INSIDE_IF:-ens37}"
ROUTER_IP="${ROUTER_IP:-10.10.10.1}"
TRANS_PORT="${TRANS_PORT:-9040}"
DNS_PORT="${DNS_PORT:-5353}"

sudo systemctl is-active --quiet tor || sudo systemctl start tor

sudo iptables -t nat -C PREROUTING -i "$INSIDE_IF" -p udp --dport 53 -j DNAT --to-destination "$ROUTER_IP:$DNS_PORT" 2>/dev/null \
  || sudo iptables -t nat -A PREROUTING -i "$INSIDE_IF" -p udp --dport 53 -j DNAT --to-destination "$ROUTER_IP:$DNS_PORT"

sudo iptables -t nat -C PREROUTING -i "$INSIDE_IF" -p tcp --syn -j DNAT --to-destination "$ROUTER_IP:$TRANS_PORT" 2>/dev/null \
  || sudo iptables -t nat -A PREROUTING -i "$INSIDE_IF" -p tcp --syn -j DNAT --to-destination "$ROUTER_IP:$TRANS_PORT"

echo "Tor mode enabled on $INSIDE_IF"
sudo iptables -t nat -L PREROUTING -v -n
