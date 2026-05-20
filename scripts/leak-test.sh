#!/usr/bin/env bash
set -euo pipefail

ROUTER_DNS="${ROUTER_DNS:-10.10.10.1}"
INSIDE_IF="${INSIDE_IF:-ens37}"
OUTSIDE_IF="${OUTSIDE_IF:-ens33}"

echo "GhostGate Leak Test"
echo "-------------------"
echo "Inside interface: $INSIDE_IF"
echo "Outside interface: $OUTSIDE_IF"
echo

echo "[IP forwarding]"
cat /proc/sys/net/ipv4/ip_forward
echo

echo "[Interfaces]"
ip -br a
echo

echo "[Default route]"
ip route | sed -n '1,5p'
echo

echo "[DNS listener]"
if command -v ss >/dev/null 2>&1; then
  sudo ss -tulpn | grep ':53' || true
fi
echo

echo "[Router DNS test]"
if command -v dig >/dev/null 2>&1; then
  dig @"$ROUTER_DNS" google.com +short
else
  echo "dig not installed"
fi
echo

echo "[Tor service]"
systemctl is-active tor 2>/dev/null || true
echo

echo "[Tor listeners]"
if command -v ss >/dev/null 2>&1; then
  sudo ss -tulpn | grep -E '9040|5353' || true
fi
echo

echo "[NAT rules]"
sudo iptables -t nat -L POSTROUTING -v -n
echo

echo "[PREROUTING rules]"
sudo iptables -t nat -L PREROUTING -v -n
echo

echo "[FORWARD rules]"
sudo iptables -L FORWARD -v -n
