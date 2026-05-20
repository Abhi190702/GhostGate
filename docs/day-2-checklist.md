# Day 2 Checklist

Day 2 builds the virtual lab machines.

## Goal

Create:

- `GhostGate-Router`
- `GhostGate-Client`

The router will eventually forward traffic. The client will eventually use the
router as its only gateway.

## Host Setup

- [ ] VMware Workstation Pro installed
- [ ] Router ISO downloaded
- [ ] Client ISO downloaded
- [ ] enough disk space available
- [ ] virtualization enabled in BIOS/UEFI if VMware complains

## Router VM

- [ ] VM name is `GhostGate-Router`
- [ ] OS is Ubuntu Server, Debian, or similar Linux server
- [ ] RAM is at least 1024 MB
- [ ] disk is at least 15 GB
- [ ] Adapter 1 is NAT
- [ ] Adapter 2 is LAN Segment
- [ ] Adapter 2 LAN Segment name is `GhostGate-Lab`
- [ ] OS installation completed
- [ ] login works

## Client VM

- [ ] VM name is `GhostGate-Client`
- [ ] OS is Ubuntu Desktop, Linux Mint, or similar Linux desktop
- [ ] RAM is at least 2048 MB
- [ ] disk is at least 25 GB
- [ ] Adapter 1 is LAN Segment
- [ ] Adapter 1 LAN Segment name is `GhostGate-Lab`
- [ ] no NAT adapter exists on Client VM
- [ ] OS installation completed
- [ ] desktop login works

## Screenshots

- [ ] Router Adapter 1 NAT screenshot saved
- [ ] Router Adapter 2 `GhostGate-Lab` screenshot saved
- [ ] Client Adapter 1 `GhostGate-Lab` screenshot saved
- [ ] Router login screenshot saved
- [ ] Client desktop screenshot saved

## Day 2 Finish Line

Day 2 is complete when both VMs exist, boot, and use the correct adapter layout.

Do not worry if the Client VM cannot access the internet yet. That is expected.

## Suggested Commit

```bash
git add .
git commit -m "Add Day 2 VMware lab setup documentation"
```
