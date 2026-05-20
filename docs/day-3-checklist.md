# Day 3 Checklist

Day 3 assigns static IP addresses to the GhostGate private lab network.

## Router VM Completed

Observed router state:

```text
ens33 -> VMware NAT, 192.168.219.134/24
ens37 -> GhostGate-Lab, 10.10.10.1/24
```

Completed:

- [x] Router outside interface uses VMware NAT
- [x] Router inside interface uses `10.10.10.1/24`
- [x] Router can ping `8.8.8.8`
- [x] Router can resolve and ping `google.com`

## Client VM Next

Configure Ubuntu Desktop network settings:

First confirm the VMware adapter is back on:

```text
LAN Segment -> GhostGate-Lab
```

| Field | Value |
|---|---|
| IPv4 method | Manual |
| Address | `10.10.10.2` |
| Netmask | `255.255.255.0` |
| Gateway | `10.10.10.1` |
| DNS | `10.10.10.1` |

Expected Day 3 test:

```bash
ping -c 3 10.10.10.1
```

Completed:

- [x] Client IP is `10.10.10.2/24`
- [x] Client gateway is `10.10.10.1`
- [x] Client can ping router at `10.10.10.1`

Client internet is not expected yet. That comes after IP forwarding and NAT.
