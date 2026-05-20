# Dashboard Service

The dashboard can run as a background `systemd` service on the Router VM.

## Install Service

After copying the dashboard to `/opt/ghostgate/dashboard`, run on the Router VM:

```bash
sudo cp /opt/ghostgate/dashboard/ghostgate-dashboard.service /etc/systemd/system/ghostgate-dashboard.service
sudo systemctl daemon-reload
sudo systemctl enable --now ghostgate-dashboard
```

## Check Status

```bash
sudo systemctl status ghostgate-dashboard --no-pager -l
```

Expected:

```text
active (running)
```

## Open Dashboard

From the Client VM:

```text
http://10.10.10.1:5000
```

## Stop Or Restart

```bash
sudo systemctl restart ghostgate-dashboard
sudo systemctl stop ghostgate-dashboard
```

## Logs

```bash
sudo journalctl -u ghostgate-dashboard -f
```
