# DNS Logging

GhostGate uses `dnsmasq` query logging to show what domains the Client VM asks
for.

## View Recent Logs

On the Router VM:

```bash
sudo tail -n 50 /var/log/dnsmasq.log
```

## Follow Logs Live

On the Router VM:

```bash
sudo tail -f /var/log/dnsmasq.log
```

Then on the Client VM, browse or run:

```bash
ping -c 3 google.com
curl --max-time 10 ifconfig.me
```

Expected log pattern:

```text
query[A] google.com from 10.10.10.2
forwarded google.com to 1.1.1.1
reply google.com is ...
```

## Why This Matters

DNS logging proves the Client VM is using GhostGate as its resolver. This is the
first visible privacy-control feature of the router.
