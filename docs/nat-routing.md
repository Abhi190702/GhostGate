# NAT Routing

NAT lets the Client VM use the Router VM's outside VMware NAT connection.

Current router interfaces:

| Interface | Role |
|---|---|
| `ens33` | outside VMware NAT |
| `ens37` | inside GhostGate LAN |

## Add NAT Rules

On the router VM:

```bash
sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
sudo iptables -A FORWARD -i ens37 -o ens33 -j ACCEPT
sudo iptables -A FORWARD -i ens33 -o ens37 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```

## Check Rules

```bash
sudo iptables -L -v -n
sudo iptables -t nat -L -v -n
```

## Test From Client

After forwarding and NAT are enabled, test from the Client VM:

```bash
ping -c 3 8.8.8.8
```

DNS may still fail until GhostGate DNS is configured.

Current verified result:

```text
Client 10.10.10.2 -> 8.8.8.8 works through Router 10.10.10.1
```
