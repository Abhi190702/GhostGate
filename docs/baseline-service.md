# Baseline Service

The baseline service reapplies GhostGate routing and basic firewall rules at
boot.

It runs:

```bash
enable-ip-forwarding.sh
enable-nat.sh
firewall-basic.sh
```

## Install

After copying scripts to `/opt/ghostgate/scripts`, run on the Router VM:

```bash
sudo cp /opt/ghostgate/scripts/ghostgate-baseline.service /etc/systemd/system/ghostgate-baseline.service
sudo systemctl daemon-reload
sudo systemctl enable --now ghostgate-baseline
```

## Check

```bash
sudo systemctl status ghostgate-baseline --no-pager -l
ghostgate leak-test
```

## Reapply Manually

```bash
ghostgate baseline
```
