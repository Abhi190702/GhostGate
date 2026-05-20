# Day 4 Checklist

Day 4 makes GhostGate route client traffic to the internet and resolve DNS.

## IP Forwarding

- [x] Router IP forwarding enabled
- [x] Client can reach internet IP `8.8.8.8` through router

## NAT

- [x] Router NAT rule added on outside interface `ens33`
- [x] Router forwarding rules allow `ens37` to `ens33`
- [x] Client ping to `8.8.8.8` works

## DNS

- [x] `dnsmasq` installed on Router VM
- [x] `dnsmasq` listens on `10.10.10.1`
- [x] Router resolves `google.com` through `10.10.10.1`
- [x] Client can resolve `google.com`
- [x] DNS logs show client queries from `10.10.10.2`
- [x] Client can install packages through GhostGate
- [x] Client public IP check works with `curl ifconfig.me`
- [x] IPv4 DNS blocklist returns `0.0.0.0` for `doubleclick.net`

## Finish Line

Day 4 is complete when this works from the Client VM:

```bash
ping -c 3 google.com
```

And this shows logs on the Router VM:

```bash
sudo tail -f /var/log/dnsmasq.log
```

Current verified result:

```text
Client -> Router -> DNS -> Internet works
Client -> Router -> NAT -> Internet works
Client -> Router persists after NAT recovery/save
```
