# Configs

This folder stores example configuration files for GhostGate.

Real machine-specific or secret files should stay on the Router VM and should
not be committed.

## Planned Configs

| File | Purpose |
|---|---|
| `dnsmasq.conf.example` | Example DNS resolver configuration |
| `blocklist.conf.example` | Example blocked domains for DNS filtering |
| `torrc.example` | Example Tor transparent proxy configuration |
| `wg0-client.conf.example` | WireGuard client template without private keys |
| `split-tunnel.conf.example` | Example split tunneling categories |

## Secret Handling

Do not commit:

- WireGuard private keys
- real VPS IPs if you want to keep them private
- SSH keys
- `.env` files
- private dashboard passwords
