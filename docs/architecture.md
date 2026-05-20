# GhostGate Architecture

GhostGate uses a small virtual lab to show how traffic moves through a router,
DNS resolver, firewall, VPN tunnel, and Tor gateway.

The first version uses two VMware virtual machines:

- Client VM
- Privacy Router VM

The Client VM should not have a direct internet adapter. It sends traffic to the
Privacy Router VM, and the router decides how that traffic leaves the lab.

## Basic Flow

```text
Client VM -> Privacy Router VM -> Host Wi-Fi -> Internet
```

## Network Plan

| Machine | Role | Example IP |
|---|---|---|
| Client VM | User machine inside the lab | 10.10.10.2 |
| Privacy Router VM | Gateway, DNS, firewall, tunnel controller | 10.10.10.1 |

## VMware Adapter Plan

### Privacy Router VM

| Adapter | VMware setting | Purpose |
|---|---|---|
| Adapter 1 | NAT | Gives the router VM internet access through the Windows host |
| Adapter 2 | LAN Segment: `GhostGate-Lab` | Connects the router VM to the client VM |

### Client VM

| Adapter | VMware setting | Purpose |
|---|---|---|
| Adapter 1 | LAN Segment: `GhostGate-Lab` | Forces the client to use the router VM as gateway |

## Router Responsibilities

The Privacy Router VM will eventually handle:

- IP forwarding
- NAT
- DNS resolution
- DNS query logging
- DNS filtering
- firewall rules
- traffic monitoring
- Tor gateway mode
- WireGuard VPN mode
- leak prevention

## First Technical Milestone

The first major goal is:

```text
Client VM -> Router VM -> Internet
```

When this works, the client VM can reach the internet even though it only has an
private VMware LAN Segment adapter.

## Advanced VPN Flow

Later, GhostGate can route traffic through a self-hosted WireGuard VPN server:

```text
Client VM
   |
   v
Privacy Router VM
   |
   | encrypted WireGuard tunnel
   v
VPS WireGuard Server
   |
   v
Internet
```

In that mode, websites see the VPS public IP instead of the home network IP.
