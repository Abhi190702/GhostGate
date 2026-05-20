# VMware Host Notes

VMware Workstation Pro setup is mostly safer through the graphical UI because
VM creation depends on ISO paths, VM storage locations, and licensing state.

For Day 2, use the UI to create:

- `GhostGate-Router`
- `GhostGate-Client`

Network layout:

| VM | Adapter | VMware setting |
|---|---|---|
| GhostGate-Router | Adapter 1 | NAT |
| GhostGate-Router | Adapter 2 | LAN Segment `GhostGate-Lab` |
| GhostGate-Client | Adapter 1 | LAN Segment `GhostGate-Lab` |

The Client VM must not have direct NAT or Bridged networking while testing
GhostGate.
