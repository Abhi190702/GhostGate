# DNS Ad And Tracker Blocking

GhostGate can block domains by returning `0.0.0.0` from `dnsmasq`.

## Add Blocklist

On the Router VM:

```bash
sudo nano /etc/dnsmasq.d/blocklist.conf
```

Add:

```text
address=/doubleclick.net/0.0.0.0
address=/googlesyndication.com/0.0.0.0
address=/google-analytics.com/0.0.0.0
address=/facebook.net/0.0.0.0
```

Restart:

```bash
sudo systemctl restart dnsmasq
```

## Test From Client

On the Client VM:

```bash
getent hosts doubleclick.net
```

Expected:

```text
0.0.0.0 doubleclick.net
```

If Ubuntu shows an IPv6 address first, test IPv4 specifically:

```bash
getent ahostsv4 doubleclick.net
```

Expected:

```text
0.0.0.0 STREAM doubleclick.net
0.0.0.0 DGRAM
0.0.0.0 RAW
```

If `nslookup` is installed:

```bash
nslookup doubleclick.net 10.10.10.1
```

Expected answer:

```text
Address: 0.0.0.0
```

## View Logs

On the Router VM:

```bash
sudo tail -f /var/log/dnsmasq.log
```

The logs should show the blocked domain query from `10.10.10.2`.

Current verified result:

```text
IPv4 DNS blocking works for doubleclick.net
```

## IPv6 Note

If `getent hosts doubleclick.net` shows an IPv6 address, that is an IPv6 path.
For the first GhostGate version, handle this by blocking IPv6 on the lab path or
disabling IPv6 in the Client VM network profile.
