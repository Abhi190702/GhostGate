#!/usr/bin/env bash
set -euo pipefail

OUTSIDE_IF="${OUTSIDE_IF:-ens33}"
INSIDE_IF="${INSIDE_IF:-ens37}"

sudo iptables -t nat -A POSTROUTING -o "$OUTSIDE_IF" -j MASQUERADE
sudo iptables -A FORWARD -i "$INSIDE_IF" -o "$OUTSIDE_IF" -j ACCEPT
sudo iptables -A FORWARD -i "$OUTSIDE_IF" -o "$INSIDE_IF" -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

sudo iptables -L -v -n
sudo iptables -t nat -L -v -n
