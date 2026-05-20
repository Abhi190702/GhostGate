#!/usr/bin/env bash
set -euo pipefail

sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-ghostgate.conf >/dev/null
sudo sysctl --system

cat /proc/sys/net/ipv4/ip_forward
