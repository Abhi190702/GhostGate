# Dashboard

This folder contains the GhostGate web dashboard.

The dashboard will run on the Privacy Router VM and show lab status from the
Client VM browser.

Planned URL:

```text
http://10.10.10.1:5000
```

## Planned Pages

| Page | Purpose |
|---|---|
| `/` | Overview, current mode, service health |
| `/dns` | Recent DNS logs and blocked domain count |
| `/firewall` | Firewall mode and rule summary |
| `/status` | Router IP, client IP, Tor status, WireGuard status |

## Planned Stack

- Python
- Flask
- HTML templates
- CSS

The first dashboard version is read-only. Mode switching can be added later
after the CLI scripts are stable.
