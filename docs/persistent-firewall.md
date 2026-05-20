# Persistent Firewall

The current IP forwarding and NAT rules work, but raw `iptables` rules do not
survive reboot by default.

Day 5 should make the working router state persistent.

## Current Working Rules

Router interfaces:

| Interface | Role |
|---|---|
| `ens33` | outside VMware NAT |
| `ens37` | inside GhostGate LAN |

Current NAT and forwarding commands:

```bash
sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
sudo iptables -A FORWARD -i ens37 -o ens33 -j ACCEPT
sudo iptables -A FORWARD -i ens33 -o ens37 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```

## Persist IP Forwarding

Already covered by:

```text
/etc/sysctl.d/99-ghostgate.conf
```

Expected content:

```text
net.ipv4.ip_forward=1
```

## Persist iptables Rules

On Ubuntu Server:

```bash
sudo apt install -y iptables-persistent
sudo netfilter-persistent save
sudo systemctl enable netfilter-persistent
```

During install, if asked whether to save current IPv4 rules, choose `Yes`.

## Reboot Test

```bash
sudo reboot
```

After reboot, verify on the router:

```bash
cat /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -L -v -n
sudo iptables -L -v -n
```

Then verify on the client:

```bash
ping -c 3 10.10.10.1
ping -c 3 8.8.8.8
ping -c 3 google.com
curl ifconfig.me
```

Verified after recovery:

```text
Client ping 10.10.10.1 works
Client ping 8.8.8.8 works
Client ping google.com works
Client curl ifconfig.me works
```
