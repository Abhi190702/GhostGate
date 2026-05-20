# DNS Resolver

GhostGate uses `dnsmasq` on the Router VM so the Client VM can use the router
as its DNS server.

Current network:

| Machine | IP |
|---|---|
| Router inside interface `ens37` | `10.10.10.1/24` |
| Client interface `ens33` | `10.10.10.2/24` |

## Install dnsmasq

On the Router VM:

```bash
sudo apt update
sudo apt install -y dnsmasq
```

## Configure GhostGate DNS

Create a dedicated config file:

```bash
sudo nano /etc/dnsmasq.d/ghostgate.conf
```

Add:

```text
interface=ens37
listen-address=10.10.10.1
bind-interfaces

server=1.1.1.1
server=8.8.8.8

log-queries
log-facility=/var/log/dnsmasq.log
```

Restart:

```bash
sudo systemctl restart dnsmasq
sudo systemctl status dnsmasq --no-pager
```

Ubuntu may print this resolver helper warning:

```text
Failed to set DNS configuration: Link lo is loopback device.
```

If `dnsmasq` is still `active (running)` and `dig @10.10.10.1 google.com`
returns an answer, GhostGate DNS is working.

## Test From Router

```bash
dig @10.10.10.1 google.com
```

If `dig` is missing:

```bash
sudo apt install -y dnsutils
```

## Test From Client

The Client VM already uses:

```text
DNS: 10.10.10.1
```

Test:

```bash
ping -c 3 google.com
```

## View DNS Logs

On the Router VM:

```bash
sudo tail -f /var/log/dnsmasq.log
```

Then browse or ping domains from the Client VM and watch the DNS requests appear.

Verified result:

```text
dnsmasq logs show queries from 10.10.10.2
```
