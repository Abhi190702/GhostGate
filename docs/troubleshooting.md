# Troubleshooting

This page collects problems that may appear while building GhostGate.

## VMware Cannot Start 64-bit Linux

Possible causes:

- virtualization is disabled in BIOS/UEFI
- Hyper-V or another hypervisor is interfering
- the CPU does not expose virtualization features to VMware

What to check:

- enable Intel VT-x or AMD-V in BIOS/UEFI
- reboot after changing virtualization settings
- check Windows optional features if VMware reports a Hyper-V conflict

## Client VM Has Internet Too Early

If the Client VM can browse the internet before routing is configured, it
probably has a direct NAT or bridged adapter.

Fix:

- shut down the Client VM
- open VMware VM settings
- remove NAT or bridged adapters
- keep only LAN Segment `GhostGate-Lab`

## Router And Client Cannot Communicate

This is usually caused by mismatched LAN Segment names.

Fix:

- Router Adapter 2 must be LAN Segment `GhostGate-Lab`
- Client Adapter 1 must be LAN Segment `GhostGate-Lab`
- spelling must match exactly

Expected Linux addresses:

```text
Router ens37 -> 10.10.10.1/24
Client ens33 -> 10.10.10.2/24
```

If both addresses are correct but ping still says `Destination Host
Unreachable`, shut down both VMs and check VMware:

- Router `Network Adapter 2` is connected
- Router `Network Adapter 2` uses LAN Segment `GhostGate-Lab`
- Client `Network Adapter` is connected
- Client `Network Adapter` uses LAN Segment `GhostGate-Lab`
- both adapters have `Connect at power on` enabled

In VMware settings, the `Connected` checkbox may be greyed out while a VM is
powered off. That is normal. Make sure `Connect at power on` is checked, then
boot the VM.

Then boot the router first, boot the client second, and test:

```bash
ping -c 3 10.10.10.1
```

## Client Cannot Access Internet On Day 2

This is expected.

The client will only reach the internet after:

- static IPs are assigned
- the client gateway is set to `10.10.10.1`
- IP forwarding is enabled on the router
- NAT rules are added on the router

## Client Shows No IPv4 Address

If the Client VM shows only an IPv6 address like `fe80::...`, the static IPv4
profile was not applied.

On Ubuntu Desktop, run:

```bash
sudo nmcli con add type ethernet ifname ens33 con-name ghostgate-client ipv4.method manual ipv4.addresses 10.10.10.2/24 ipv4.gateway 10.10.10.1 ipv4.dns 10.10.10.1 autoconnect yes
sudo nmcli con up ghostgate-client
ip -br a
ping -c 3 10.10.10.1
```

If the connection already exists, modify it instead:

```bash
sudo nmcli con mod ghostgate-client ipv4.method manual ipv4.addresses 10.10.10.2/24 ipv4.gateway 10.10.10.1 ipv4.dns 10.10.10.1
sudo nmcli con up ghostgate-client
```

## Client Shows 10.10.10.24/32

This means `10.10.10.2/24` was typed without the slash, so NetworkManager read
it as the address `10.10.10.24`.

Fix it with:

```bash
sudo nmcli con mod ghostgate-client ipv4.method manual ipv4.addresses 10.10.10.2/24 ipv4.gateway 10.10.10.1 ipv4.dns 10.10.10.1
sudo nmcli con down ghostgate-client
sudo nmcli con up ghostgate-client
ip -br a
ping -c 3 10.10.10.1
```
- DNS is configured

## Do Not Commit Secrets

Never commit:

- WireGuard private keys
- SSH keys
- real `.env` files
- private VPS details
- dashboard passwords
