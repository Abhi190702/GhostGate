# Basic Firewall

GhostGate uses firewall rules to reduce accidental leaks.

The first firewall goal is simple:

```text
Client DNS must go to 10.10.10.1, not directly to outside DNS servers.
```

## Current Interfaces

| Interface | Role |
|---|---|
| `ens33` | outside VMware NAT |
| `ens37` | inside GhostGate LAN |

## DNS Leak Block Rules

These rules block forwarded DNS traffic from the Client VM to any destination
other than the router DNS address.

On the Router VM:

```bash
sudo iptables -I FORWARD 1 -i ens37 -p udp --dport 53 ! -d 10.10.10.1 -j DROP
sudo iptables -I FORWARD 2 -i ens37 -p tcp --dport 53 ! -d 10.10.10.1 -j DROP
```

Save:

```bash
sudo netfilter-persistent save
```

## Test Normal DNS Still Works

On the Client VM:

```bash
ping -c 3 google.com
getent ahostsv4 doubleclick.net
```

Expected:

```text
google.com resolves
doubleclick.net returns 0.0.0.0
```

## Test Direct DNS Bypass

On the Client VM:

```bash
dig @8.8.8.8 google.com
```

Expected after the firewall rule:

```text
connection timed out
```

DNS through GhostGate should still work:

```bash
dig @10.10.10.1 google.com
```
