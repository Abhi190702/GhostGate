#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/enable-ip-forwarding.sh"
"$SCRIPT_DIR/enable-nat.sh"
"$SCRIPT_DIR/firewall-basic.sh"

if command -v netfilter-persistent >/dev/null 2>&1; then
  sudo netfilter-persistent save
fi

echo "GhostGate baseline routing and firewall applied"
