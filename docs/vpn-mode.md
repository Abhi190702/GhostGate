# VPN Mode

VPN mode routes Client VM traffic through a WireGuard tunnel.

Normal mode:

```text
Client VM -> Router VM -> VMware NAT -> Internet
```

VPN mode:

```text
Client VM -> Router VM -> wg0 -> WireGuard Server -> Internet
```

## Requirements

- WireGuard installed on Router VM
- working WireGuard config at `/etc/wireguard/wg0.conf`
- remote WireGuard server or VPS
- server allows forwarding/NAT to the internet

## Install WireGuard

On the Router VM:

```bash
sudo apt update
sudo apt install -y wireguard curl
```

## Add Client Config

Create:

```bash
sudo nano /etc/wireguard/wg0.conf
```

Use `configs/wg0-client.conf.example` as the template.

Do not commit real keys.

## Test WireGuard Only

On the Router VM:

```bash
sudo wg-quick up wg0
sudo wg
curl --max-time 10 ifconfig.me
sudo wg-quick down wg0
```

The public IP should change to the VPN server IP while `wg0` is up.

## Enable GhostGate VPN Mode

After `wg0.conf` works:

```bash
ghostgate vpn-on
```

## Disable VPN Mode

```bash
ghostgate vpn-off
```

## Test From Client VM

```bash
curl --max-time 10 ifconfig.me
ping -c 3 google.com
```

The public IP should be the WireGuard server IP.
