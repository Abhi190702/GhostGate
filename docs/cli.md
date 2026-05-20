# GhostGate CLI

The `ghostgate` CLI is a small Bash wrapper for common router commands.

## Install On Router VM

From Windows PowerShell, inside the local repository:

```powershell
cd C:\Users\abhij\OneDrive\Desktop\GhostGate\GhostGate
scp -P 2222 -r .\scripts ggserver@127.0.0.1:~/ghostgate-scripts
```

Then SSH into the Router VM:

```powershell
ssh -p 2222 ggserver@127.0.0.1
```

On the Router VM:

```bash
sudo mkdir -p /opt/ghostgate
sudo rm -rf /opt/ghostgate/scripts
sudo mv ~/ghostgate-scripts /opt/ghostgate/scripts
sudo chmod +x /opt/ghostgate/scripts/*
sudo ln -sf /opt/ghostgate/scripts/ghostgate /usr/local/bin/ghostgate
```

## Commands

```bash
ghostgate status
ghostgate dns-logs
ghostgate monitor tcpdump
ghostgate monitor iftop
ghostgate monitor vnstat
ghostgate firewall-on
ghostgate leak-test
```

## Required Packages

For all commands:

```bash
sudo apt install -y tcpdump iftop vnstat dnsutils
```

## Test

```bash
ghostgate status
ghostgate leak-test
```
