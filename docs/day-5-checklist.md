# Day 5 Checklist

Day 5 turns the working router into a more privacy-aware router.

## Goals

- reduce IPv6 leaks for the first version
- block direct DNS bypass attempts
- add traffic monitoring tools
- add first GhostGate CLI commands

## IPv6 Leak Control

- [x] Disable IPv6 in the Client VM GhostGate connection
- [x] Confirm GhostGate DNS still works after IPv6 change
- [x] Confirm IPv4 blocklist still returns `0.0.0.0`

## Basic Firewall

- [x] Add DNS leak block rules for UDP port 53
- [x] Add DNS leak block rules for TCP port 53
- [x] Save firewall rules
- [x] Confirm normal DNS still works through `10.10.10.1`
- [x] Confirm lockdown blocks client internet
- [x] Confirm unlock restores client internet

## Monitoring

- [x] Install `tcpdump`
- [x] Install `iftop`
- [x] Install `vnstat`
- [x] Verify `ghostgate monitor vnstat`
- [ ] Watch client traffic live on router inside interface `ens37`
- [ ] Save notes or screenshots

## CLI

- [x] Add `ghostgate status`
- [x] Add `ghostgate dns-logs`
- [x] Add `ghostgate monitor`
- [x] Add `ghostgate leak-test`
- [x] Install CLI on Router VM

## Current Verified Commands

```bash
ghostgate status
ghostgate leak-test
ghostgate monitor vnstat
```

## Finish Line

Day 5 is complete when:

```bash
ghostgate status
ghostgate leak-test
ghostgate dns-logs
```

work on the Router VM.

## Dashboard

- [x] Read-only dashboard opens from Client VM
- [x] Dashboard runs as a `systemd` service
