# Day 6 Checklist

Day 6 adds experimental Tor mode.

## Tor Setup

- [x] Install Tor on Router VM
- [x] Add `TransPort 10.10.10.1:9040`
- [x] Add `DNSPort 10.10.10.1:5353`
- [x] Restart Tor successfully
- [x] Confirm Tor service is active

## Tor Scripts

- [x] Install updated GhostGate scripts on Router VM
- [x] Run `ghostgate tor-on`
- [x] Confirm Tor NAT redirect rules exist
- [x] Test Client VM through Tor check site
- [x] Run `ghostgate tor-off`
- [x] Confirm normal mode still works

## Finish Line

Day 6 is complete when:

```text
Client VM can switch between normal mode and Tor mode.
```

Verified:

```text
check.torproject.org/api/ip returned IsTor true
normal mode returned regular public IP after tor-off
```
