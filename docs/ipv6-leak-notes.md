# IPv6 Leak Notes

GhostGate currently routes and filters IPv4 traffic.

During ad-block testing, IPv4 blocking worked:

```text
doubleclick.net -> 0.0.0.0
```

But `getent hosts doubleclick.net` may still show an IPv6 address first.

## Why This Matters

If IPv6 is enabled but not controlled by GhostGate firewall and DNS policy, some
traffic may bypass IPv4-only rules.

## First-Version Approach

For the first GhostGate version, use a simple rule:

```text
Disable or block IPv6 on the lab path until IPv6 routing and firewalling are explicitly supported.
```

## Disable IPv6 On Client Connection

On the Client VM:

```bash
sudo nmcli con mod ghostgate-client ipv6.method disabled
sudo nmcli con down ghostgate-client
sudo nmcli con up ghostgate-client
```

Then check:

```bash
ip -6 route
getent hosts doubleclick.net
getent ahostsv4 doubleclick.net
```

Expected for the block test:

```text
0.0.0.0
```

## Client Check

On the Client VM:

```bash
ip -6 route
getent hosts doubleclick.net
getent ahostsv4 doubleclick.net
```

## Roadmap

Future IPv6 support should include:

- controlled IPv6 routing
- IPv6 firewall rules
- IPv6 DNS blocking
- IPv6 leak test
