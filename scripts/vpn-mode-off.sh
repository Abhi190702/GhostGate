#!/usr/bin/env bash
set -euo pipefail

INSIDE_IF="${INSIDE_IF:-ens37}"
VPN_IF="${VPN_IF:-wg0}"

while sudo iptables -t nat -C POSTROUTING -o "$VPN_IF" -j MASQUERADE 2>/dev/null; do
  sudo iptables -t nat -D POSTROUTING -o "$VPN_IF" -j MASQUERADE
done

while sudo iptables -C FORWARD -i "$INSIDE_IF" -o "$VPN_IF" -j ACCEPT 2>/dev/null; do
  sudo iptables -D FORWARD -i "$INSIDE_IF" -o "$VPN_IF" -j ACCEPT
done

while sudo iptables -C FORWARD -i "$VPN_IF" -o "$INSIDE_IF" -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT 2>/dev/null; do
  sudo iptables -D FORWARD -i "$VPN_IF" -o "$INSIDE_IF" -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
done

sudo wg-quick down "$VPN_IF" || true

echo "VPN mode disabled on $VPN_IF"
