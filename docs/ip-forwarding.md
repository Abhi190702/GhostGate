# IP Forwarding

Day 4 turns the Ubuntu Server VM into a machine that can forward packets between
interfaces.

Current router interfaces:

| Interface | Role |
|---|---|
| `ens33` | outside VMware NAT |
| `ens37` | inside GhostGate LAN |

## Enable Temporarily

On the router VM:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

Verify:

```bash
cat /proc/sys/net/ipv4/ip_forward
```

Expected:

```text
1
```

## Enable Permanently

Create a GhostGate sysctl file:

```bash
sudo nano /etc/sysctl.d/99-ghostgate.conf
```

Add:

```text
net.ipv4.ip_forward=1
```

Apply:

```bash
sudo sysctl --system
```

## Next Step

IP forwarding only allows Linux to pass packets. Client internet still requires
NAT rules, which are covered in `docs/nat-routing.md`.
