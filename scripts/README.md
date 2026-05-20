# Scripts

This folder will contain GhostGate automation scripts.

Most scripts should be written for the Linux Privacy Router VM. Host notes live
under `scripts/host/`.

## Planned Scripts

| Script | Purpose |
|---|---|
| `enable-ip-forwarding.sh` | Enable Linux packet forwarding |
| `enable-nat.sh` | Add NAT rules for client internet access |
| `firewall-basic.sh` | Apply basic firewall and DNS leak rules |
| `dns-logs.sh` | Show recent `dnsmasq` query logs |
| `monitor-traffic.sh` | Open traffic monitoring tools |
| `tor-mode-on.sh` | Route client traffic through Tor |
| `tor-mode-off.sh` | Disable Tor routing mode |
| `vpn-mode-on.sh` | Route client traffic through WireGuard |
| `vpn-mode-off.sh` | Disable WireGuard routing mode |
| `killswitch-on.sh` | Block leaks when protected mode is required |
| `killswitch-off.sh` | Remove lockdown rules |
| `leak-test.sh` | Check public IP, DNS route, Tor, WireGuard, and default route |
| `ghostgate` | Main CLI wrapper |

## Current Implemented Scripts

- `enable-ip-forwarding.sh`
- `enable-nat.sh`
- `apply-baseline.sh`
- `dns-logs.sh`
- `firewall-basic.sh`
- `monitor-traffic.sh`
- `leak-test.sh`
- `tor-mode-on.sh`
- `tor-mode-off.sh`
- `killswitch-on.sh`
- `killswitch-off.sh`
- `ghostgate`

## Host Helpers

| Script | Purpose |
|---|---|
| `host/vmware-notes.md` | VMware Workstation Pro host setup notes |

## Safety Notes

- Read every script before running it with `sudo`.
- Do not run firewall scripts over SSH until you understand the rules.
- Keep interface names configurable because VMware interface names may differ.
- Never commit VPN private keys or real VPS secrets.
