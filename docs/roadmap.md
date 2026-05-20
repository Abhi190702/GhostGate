# GhostGate Roadmap

This roadmap keeps the project buildable in small pieces. Each phase should end
with something that can be tested and documented.

## Phase 0: Repository Setup

Goal: make the project readable before writing technical scripts.

- Create the repository
- Add the README
- Add the folder structure
- Add architecture notes
- Add roadmap
- Add learning notes
- Add ethical use policy
- Add example configs without secrets

## Phase 1: Virtual Router Foundation

Goal:

```text
Client VM -> Router VM -> Internet
```

Tasks:

- Create the Router VM
- Create the Client VM
- Configure VirtualBox internal network `labnet`
- Assign static IPs
- Enable IP forwarding on the Router VM
- Add NAT rules
- Test client-to-router ping
- Test client-to-internet ping by IP
- Test domain resolution

## Phase 2: DNS and Filtering

Goal:

```text
Client VM -> Router VM DNS -> Internet
```

Tasks:

- Install `dnsmasq`
- Configure the Router VM as DNS resolver
- Enable DNS query logging
- Add a blocklist
- Block simple tracker domains
- Prevent direct DNS leaks

## Phase 3: Monitoring and Firewall

Goal: make traffic visible and controllable.

Tasks:

- Install `tcpdump`
- Install `iftop`
- Install `vnstat`
- Add a monitoring script
- Add basic firewall rules
- Save firewall rules persistently
- Add a basic kill switch

## Phase 4: Tor Gateway Mode

Goal:

```text
Client VM -> Router VM -> Tor -> Internet
```

Tasks:

- Install Tor
- Configure Tor transparent proxy ports
- Redirect client TCP traffic through Tor
- Redirect DNS through Tor DNSPort
- Add `tor-on` and `tor-off` scripts
- Test with a Tor check page

## Phase 5: WireGuard VPN Mode

Goal:

```text
Client VM -> Router VM -> WireGuard VPN -> Internet
```

Tasks:

- Learn WireGuard basics
- Configure a WireGuard server on a VPS or lab VM
- Configure the Router VM as a WireGuard client
- Route client traffic through `wg0`
- Add `vpn-on` and `vpn-off` scripts
- Add a public IP check
- Add a VPN kill switch

## Phase 6: Dashboard and CLI

Goal: make GhostGate easier to inspect and operate.

Tasks:

- Build a Flask dashboard
- Show current mode
- Show recent DNS logs
- Show firewall status
- Show service status
- Show traffic stats
- Add `ghostgate` CLI commands

## Phase 7: Split Tunneling and Polish

Goal: turn the lab into a polished open-source project.

Tasks:

- Add split tunneling configuration
- Add direct/VPN/Tor/block categories
- Add leak test command
- Improve troubleshooting docs
- Add screenshots
- Add a demo video or GIF
- Clean up README and docs

## Build Order

Build the foundation first:

1. Router
2. DNS
3. Monitoring
4. Firewall
5. Tor
6. Dashboard
7. WireGuard
8. Split tunneling

The dashboard and VPN features are more impressive after the routing foundation
is already working.
