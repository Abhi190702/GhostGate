# Day 2 Checklist

Day 2 builds the virtual lab machines.

## Goal

Create:

- `GhostGate-Router`
- `GhostGate-Client`

The router will eventually forward traffic. The client will eventually use the
router as its only gateway.

## Host Setup

- [X] VMware Workstation Pro installed
- [X] Router ISO downloaded
- [X] Client ISO downloaded
- [X] enough disk space available
- [X] virtualization enabled in BIOS/UEFI if VMware complains

## Router VM

- [X] VM name is `GhostGate-Router`
- [X] OS is Ubuntu Server, Debian, or similar Linux server
- [X] RAM is at least 1024 MB
- [X] disk is at least 15 GB
- [X] Adapter 1 is NAT
- [X] Adapter 2 is LAN Segment
- [X] Adapter 2 LAN Segment name is `GhostGate-Lab`
- [X] OS installation completed
- [X] login works

## Client VM

- [X] VM name is `GhostGate-Client`
- [X] OS is Ubuntu Desktop, Linux Mint, or similar Linux desktop
- [X] RAM is at least 2048 MB
- [X] disk is at least 25 GB
- [X] Adapter 1 is LAN Segment
- [X] Adapter 1 LAN Segment name is `GhostGate-Lab`
- [X] no NAT adapter exists on Client VM
- [X] OS installation completed
- [X] desktop login works

## Screenshots

- [X] Router Adapter 1 NAT screenshot saved
- [X] Router Adapter 2 `GhostGate-Lab` screenshot saved
- [X] Client Adapter 1 `GhostGate-Lab` screenshot saved
- [X] Router login screenshot saved
- [X] Client desktop screenshot saved

## Day 2 Finish Line

Day 2 is complete when both VMs exist, boot, and use the correct adapter layout.

Do not worry if the Client VM cannot access the internet yet. That is expected.

## Suggested Commit

```bash
git add .
git commit -m "Add Day 2 VMware lab setup documentation"
```
