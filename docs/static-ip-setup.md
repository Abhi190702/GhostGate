# Static IP Setup

Day 3 assigns fixed IP addresses to the GhostGate lab network.

Based on the current VMware router VM:

| Interface | Role | Address |
|---|---|---|
| `ens33` | Outside VMware NAT | DHCP, currently `192.168.219.134/24` |
| `ens37` | Inside GhostGate LAN Segment | `10.10.10.1/24` |

The Client VM will later use:

| Machine | Address | Gateway | DNS |
|---|---|---|---|
| GhostGate Router | `10.10.10.1/24` | VMware NAT via `ens33` | DHCP from VMware NAT |
| GhostGate Client | `10.10.10.2/24` | `10.10.10.1` | `10.10.10.1` |

## Router Netplan Config

Edit the router netplan file:

```bash
sudo nano /etc/netplan/00-installer-config.yaml
```

Use this content:

```yaml
network:
  version: 2
  ethernets:
    ens33:
      dhcp4: true
    ens37:
      dhcp4: false
      addresses:
        - 10.10.10.1/24
```

Apply it:

```bash
sudo netplan generate
sudo netplan apply
ip -br a
```

Expected result:

```text
ens33  UP  192.168.219.x/24
ens37  UP  10.10.10.1/24
```

## Router Internet Test

The router should still have internet through VMware NAT:

```bash
ping -c 3 8.8.8.8
ping -c 3 google.com
```

## Client Static IP

On the Client VM, configure the GhostGate LAN adapter.

Ubuntu Desktop GUI path:

1. Open `Settings`.
2. Open `Network`.
3. Select the wired connection.
4. Click the gear icon.
5. Open the `IPv4` tab.
6. Select `Manual`.
7. Fill the values below.
8. Click `Apply`.
9. Turn the wired connection off and on again, or reboot the Client VM.

| Field | Value |
|---|---|
| IPv4 method | Manual |
| Address | `10.10.10.2` |
| Netmask | `255.255.255.0` |
| Gateway | `10.10.10.1` |
| DNS | `10.10.10.1` |

At this point, the Client VM should be able to ping the router:

```bash
ping -c 3 10.10.10.1
```

Client internet access is not expected until IP forwarding and NAT are enabled
on the router.

If Ubuntu Desktop asks for prefix length instead of netmask, use:

```text
24
```

## Client Terminal Fallback

If the Ubuntu Desktop GUI shows the right values but `ip -br a` only shows an
IPv6 address, configure the client with NetworkManager:

```bash
sudo nmcli con add type ethernet ifname ens33 con-name ghostgate-client ipv4.method manual ipv4.addresses 10.10.10.2/24 ipv4.gateway 10.10.10.1 ipv4.dns 10.10.10.1 autoconnect yes
sudo nmcli con up ghostgate-client
ip -br a
ip route
ping -c 3 10.10.10.1
```

Expected client address:

```text
ens33  UP  10.10.10.2/24
```
