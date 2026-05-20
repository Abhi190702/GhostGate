# Learning Notes

This file tracks what I learn while building GhostGate.

## Day 1 Notes

### What is a router?

A router forwards network traffic between different networks.

In GhostGate, the Privacy Router VM behaves like a software router. The Client
VM sends traffic to it, and the router VM forwards that traffic toward the
internet.

### What is a gateway?

A gateway is the next machine traffic goes to when it needs to leave the local
network.

For the Client VM, the gateway will be:

```text
10.10.10.1
```

That IP belongs to the Privacy Router VM.

### What is DNS?

DNS converts domain names into IP addresses.

Example:

```text
example.com -> 93.184.216.34
```

GhostGate will use its own DNS resolver so the router can log and block domain
requests.

### What is NAT?

NAT means Network Address Translation.

It allows a private IP such as:

```text
10.10.10.2
```

to access the internet through another machine.

In GhostGate:

```text
Client VM private IP -> Router VM -> Internet
```

### What is IP forwarding?

IP forwarding allows a Linux machine to forward packets between network
interfaces.

This is required because a normal Linux machine does not behave like a router
until forwarding is enabled.

### What is a DNS leak?

A DNS leak happens when DNS requests bypass the protected route.

Example: the client is supposed to ask GhostGate for DNS, but it asks a public
DNS server directly. That can reveal domains even if other traffic is routed
through a VPN or Tor.

### What is a kill switch?

A kill switch blocks traffic when the protected route is down.

In GhostGate, the kill switch should prevent traffic from leaking directly to
the internet if Tor or WireGuard is not active.

## Useful Commands To Learn

```bash
ip a
ip route
ping 10.10.10.1
ping 8.8.8.8
ping example.com
systemctl status dnsmasq
systemctl status tor
sudo iptables -L -v -n
sudo iptables -t nat -L -v -n
sudo tail -f /var/log/dnsmasq.log
sudo tcpdump -i enp0s8
curl ifconfig.me
```

## Daily Learning Pattern

Use this pattern while building:

1. Study the concept briefly.
2. Implement one small feature.
3. Test it with commands.
4. Write what worked and what failed.
5. Commit the progress.

## Day 2 Notes

### Why does the Router VM need two adapters?

The Router VM needs one adapter for the outside network and one adapter for the
inside lab network.

```text
NAT adapter -> host internet
LAN Segment adapter -> Client VM
```

This lets the Router VM sit between the client and the internet.

### Why does the Client VM only get one adapter?

The Client VM gets only the `GhostGate-Lab` LAN Segment adapter so it cannot bypass the
Privacy Router VM.

This is the main security and learning point of the lab: all client traffic must
flow through the router.

### Why use a VMware LAN Segment?

VMware LAN Segment creates a private virtual switch. Only VMs connected to the
same LAN Segment name can talk to each other.

For GhostGate, that LAN Segment name is:

```text
GhostGate-Lab
```

## Day 3 Notes

### Router interface names

Current VMware Router VM interface roles:

```text
ens33 -> outside VMware NAT
ens37 -> inside GhostGate-Lab LAN Segment
```

The outside interface receives an address from VMware DHCP. The inside interface
gets a static GhostGate address:

```text
10.10.10.1/24
```
