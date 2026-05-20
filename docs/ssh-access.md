# SSH Access To Router VM

SSH makes it easier to copy and paste router commands from Windows.

## Router SSH Service

On the Router VM:

```bash
sudo apt install -y openssh-server
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager
```

Expected:

```text
active (running)
```

## VMware NAT Port Forward

If Windows cannot connect directly to the Router VM NAT address, add a VMware
NAT port forward.

In VMware Workstation Pro:

1. Open `Edit`.
2. Open `Virtual Network Editor`.
3. Click `Change Settings`.
4. Select `VMnet8`.
5. Make sure it is the NAT network.
6. Click `NAT Settings`.
7. Click `Add`.
8. Add:

```text
Host port: 2222
Type: TCP
Virtual machine IP address: 192.168.219.134
Virtual machine port: 22
Description: GhostGate Router SSH
```

Then connect from Windows PowerShell:

```powershell
ssh -p 2222 ggserver@127.0.0.1
```

## Firewall Check

On the Router VM:

```bash
sudo ufw status
```

If UFW is active:

```bash
sudo ufw allow ssh
```

Note: the command is `ufw`, not `ufu`.
