# Scripts

This folder will contain GhostGate automation scripts.

Scripts should be written for the Linux Privacy Router VM, not for the Windows
host machine.

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

## Safety Notes

- Read every script before running it with `sudo`.
- Do not run firewall scripts over SSH until you understand the rules.
- Keep interface names configurable because VirtualBox names may differ.
- Never commit VPN private keys or real VPS secrets.
