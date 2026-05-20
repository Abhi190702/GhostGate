# Kill Switch

The kill switch blocks client forwarding unless an approved privacy path is
active.

First version goal:

```text
When lockdown is enabled, normal direct forwarding to ens33 is blocked.
```

## Enable Lockdown

On the Router VM:

```bash
ghostgate lockdown
```

## Disable Lockdown

On the Router VM:

```bash
ghostgate unlock
```

## Test

From the Client VM:

```bash
ping -c 3 8.8.8.8
curl --max-time 10 ifconfig.me
```

Expected in lockdown:

```text
traffic fails unless a privacy route is active
```

Expected after unlock:

```text
normal internet works again
```

Verified:

```text
lockdown: client ping 8.8.8.8 fails with Destination Port Unreachable
unlock: client ping 8.8.8.8 and curl ifconfig.me work again
```

## Rule Order

iptables uses first match wins. The lockdown reject rule must appear above the
normal forwarding accept rule:

```text
REJECT all -- ens37 ens33
ACCEPT all -- ens37 ens33
```

If the reject rule is below the accept rule, lockdown will not block traffic.

## Important

Do not enable persistent lockdown until the rules have been tested. A bad
firewall rule can break the lab path.
