#!/usr/bin/env bash
set -euo pipefail

INSIDE_IF="${INSIDE_IF:-ens37}"
VPN_IF="${VPN_IF:-wg0}"

if [ ! -f "/etc/wireguard/$VPN_IF.conf" ]; then
  echo "Missing /etc/wireguard/$VPN_IF.conf"
  exit 1
fi

sudo wg-quick up "$VPN_IF" || true

sudo iptables -t nat -C POSTROUTING -o "$VPN_IF" -j MASQUERADE 2>/dev/null \
  || sudo iptables -t nat -A POSTROUTING -o "$VPN_IF" -j MASQUERADE

sudo iptables -C FORWARD -i "$INSIDE_IF" -o "$VPN_IF" -j ACCEPT 2>/dev/null \
  || sudo iptables -I FORWARD 1 -i "$INSIDE_IF" -o "$VPN_IF" -j ACCEPT

sudo iptables -C FORWARD -i "$VPN_IF" -o "$INSIDE_IF" -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT 2>/dev/null \
  || sudo iptables -I FORWARD 2 -i "$VPN_IF" -o "$INSIDE_IF" -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

echo "VPN mode enabled on $VPN_IF"
sudo wg
