# Dashboard

GhostGate includes a read-only Flask dashboard for inspecting router status.

## Pages

| Page | Purpose |
|---|---|
| `/` | overview, interfaces, routes |
| `/dns` | DNS listeners and recent query logs |
| `/firewall` | forwarding and NAT rules |
| `/traffic` | `vnstat` traffic counters |
| `/status` | service status and leak test output |

## Install On Router VM

From Windows PowerShell, copy the dashboard folder:

```powershell
cd C:\Users\abhij\OneDrive\Desktop\GhostGate\GhostGate
scp -P 2222 -r .\dashboard ggserver@127.0.0.1:~/ghostgate-dashboard
```

SSH into the router:

```powershell
ssh -p 2222 ggserver@127.0.0.1
```

Install dependencies:

```bash
sudo apt install -y python3-flask
sudo rm -rf /opt/ghostgate/dashboard
sudo mkdir -p /opt/ghostgate
sudo mv ~/ghostgate-dashboard /opt/ghostgate/dashboard
```

Allow the dashboard to read firewall rules without prompting for a password:

```bash
echo "ggserver ALL=(root) NOPASSWD: /usr/sbin/iptables" | sudo tee /etc/sudoers.d/ghostgate-dashboard
sudo chmod 440 /etc/sudoers.d/ghostgate-dashboard
```

Run:

```bash
cd /opt/ghostgate/dashboard
python3 app.py
```

Open from the Client VM:

```text
http://10.10.10.1:5000
```

Stop with:

```text
Ctrl + C
```

## Run In Background

For a persistent service, use:

```bash
sudo cp /opt/ghostgate/dashboard/ghostgate-dashboard.service /etc/systemd/system/ghostgate-dashboard.service
sudo systemctl daemon-reload
sudo systemctl enable --now ghostgate-dashboard
sudo systemctl status ghostgate-dashboard --no-pager -l
```

See `docs/dashboard-service.md`.
