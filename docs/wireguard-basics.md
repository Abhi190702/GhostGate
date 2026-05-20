# WireGuard Basics

WireGuard is the VPN layer planned for GhostGate.

## Key Ideas

| Term | Meaning |
|---|---|
| Interface | Virtual network adapter, usually `wg0` |
| Private key | Secret key for one machine |
| Public key | Shareable key generated from the private key |
| Peer | Another WireGuard machine |
| Endpoint | Public IP and UDP port of the peer |
| AllowedIPs | Which traffic should enter the tunnel |

## GhostGate VPN Goal

Final flow:

```text
Client VM -> Router VM -> wg0 -> VPS WireGuard Server -> Internet
```

In this mode, websites see the VPS public IP instead of the home network IP.

## First Implementation Plan

1. Configure a WireGuard server on a VPS.
2. Configure the Router VM as a WireGuard client.
3. Bring up `wg0` on the Router VM.
4. NAT Client VM traffic through `wg0`.
5. Add `ghostgate vpn-on`.
6. Add `ghostgate vpn-off`.

## Safety

Never commit real WireGuard private keys.

Use `.example` files in the repository and keep real configs only on the Router
VM and VPS.
