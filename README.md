# GhostGate

**GhostGate** is a virtual privacy router lab built for learning Linux networking, privacy engineering, DNS filtering, firewalling, Tor routing, WireGuard VPN, traffic monitoring, and self-hosted VPN concepts.

The project simulates a Raspberry Pi-style privacy router completely inside VMware virtual machines, without requiring extra hardware.

---

## Project Vision

The goal of GhostGate is to help students and beginners understand how network traffic flows through routers, DNS servers, firewalls, VPN tunnels, and anonymity networks.

Instead of only using VPN or Tor tools, GhostGate focuses on understanding how these systems work internally.

GhostGate is not a commercial VPN replacement or a tool claiming perfect anonymity. It is an educational project for learning how to reduce traceability and understand privacy limitations.

---

## Basic Architecture

```text
Client VM
Ubuntu Desktop / Linux Mint
IP: 10.10.10.2
        |
        | Internal Virtual Network
        v
Privacy Router VM
Ubuntu Server / Debian
IP: 10.10.10.1
        |
        | NAT / DNS / Firewall / VPN / Tor
        v
Host Machine Wi-Fi
        |
        v
Internet
```

---

## Advanced VPS VPN Architecture

```text
Client VM
   ↓
Privacy Router VM
   ↓ encrypted WireGuard tunnel
VPS WireGuard Server
   ↓
Internet
```

In this architecture, the Client VM sends traffic to the Privacy Router VM.  
The Privacy Router VM then sends traffic through an encrypted WireGuard tunnel to a VPS server.

Websites see the VPS server IP instead of the home network IP.

---

## Planned Features

- Virtual router using Linux
- NAT-based internet sharing
- Static IP routing
- DNS resolver using dnsmasq
- DNS query logging
- Ad and tracker blocking
- Firewall rules using iptables/nftables
- DNS leak prevention
- Traffic monitoring using tcpdump, iftop, vnstat
- Tor gateway mode
- WireGuard VPN mode
- Self-hosted VPS VPN support
- Kill switch
- Split tunneling
- Web dashboard
- CLI commands
- Full documentation and learning notes

---

## Project Modes

| Mode | Description |
|---|---|
| Normal Mode | Client VM routes through Router VM normally |
| Monitor Mode | Router VM monitors traffic and DNS queries |
| Block Mode | Router VM blocks ads and trackers |
| Tor Mode | Client VM traffic is routed through Tor |
| VPN Mode | Client VM traffic is routed through WireGuard VPN |
| Lockdown Mode | Blocks traffic unless privacy route is active |

---

## Learning Goals

By building GhostGate, I aim to learn:

- Linux networking
- IP addressing
- Subnets
- Gateways
- DNS
- NAT
- Packet forwarding
- Firewalls
- VPN tunneling
- Tor routing
- Traffic monitoring
- Bash scripting
- Cloud VPS basics
- Privacy engineering limitations

---

## Tech Stack

| Component | Tool |
|---|---|
| Virtualization | VMware Workstation Pro |
| Router OS | Ubuntu Server / Debian |
| Client OS | Ubuntu Desktop / Linux Mint |
| DNS | dnsmasq |
| Firewall | iptables / nftables |
| Monitoring | tcpdump, iftop, vnstat |
| VPN | WireGuard |
| Anonymity Network | Tor |
| Dashboard | Flask / HTML / CSS |
| Scripts | Bash |
| Version Control | Git and GitHub |

---

## Month 1 Roadmap

### Phase 0: Repository Setup

- Create GitHub repository
- Add README
- Add folder structure
- Add documentation files
- Add project vision
- Add ethical use policy

---

### Phase 1: Virtual Router Foundation

Goal:

```text
Client VM → Router VM → Internet
```

Tasks:

- Create Router VM
- Create Client VM
- Configure VMware LAN Segment network
- Assign static IP addresses
- Enable IP forwarding on Router VM
- Configure NAT using iptables
- Test internet access from Client VM through Router VM

---

### Phase 2: DNS and Filtering

Goal:

```text
Client VM → Router VM DNS → Internet
```

Tasks:

- Install dnsmasq
- Configure Router VM as DNS resolver
- Enable DNS query logging
- Add domain blocklist
- Block ad/tracker domains
- Prevent direct DNS leaks

---

### Phase 3: Monitoring and Firewall

Goal:

```text
Client VM → Router VM → Monitored/Filtered Internet
```

Tasks:

- Install tcpdump
- Install iftop
- Install vnstat
- Monitor packet flow
- Monitor bandwidth
- Create firewall rules
- Save firewall rules persistently
- Add basic kill switch

---

### Phase 4: Tor Gateway Mode

Goal:

```text
Client VM → Router VM → Tor → Internet
```

Tasks:

- Install Tor on Router VM
- Configure Tor transparent proxy
- Redirect client TCP traffic through Tor
- Redirect DNS through Tor DNSPort
- Add `tor-on` and `tor-off` scripts
- Test Tor routing

---

### Phase 5: WireGuard VPN Mode

Goal:

```text
Client VM → Router VM → WireGuard VPN → Internet
```

Tasks:

- Learn WireGuard basics
- Configure WireGuard client on Router VM
- Configure WireGuard server on VPS or lab VM
- Route Client VM traffic through WireGuard tunnel
- Add VPN kill switch
- Add public IP check

---

### Phase 6: Dashboard and CLI

Goal:

Create simple controls and visibility.

Tasks:

- Build Flask dashboard
- Show current mode
- Show DNS logs
- Show firewall status
- Show service status
- Show traffic stats
- Add GhostGate CLI commands

Example commands:

```bash
ghostgate status
ghostgate monitor
ghostgate dns-logs
ghostgate tor-on
ghostgate tor-off
ghostgate vpn-on
ghostgate vpn-off
ghostgate lockdown
ghostgate unlock
ghostgate leak-test
```

---

### Phase 7: Split Tunneling and Polish

Goal:

Add advanced routing options and prepare project for public use.

Tasks:

- Add split tunneling concept
- Add direct/VPN/Tor routing rules
- Add leak test script
- Improve documentation
- Add screenshots
- Add troubleshooting guide
- Add demo video or GIF

---

## Repository Structure

```text
GhostGate/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── docs/
│   ├── architecture.md
│   ├── roadmap.md
│   ├── learning-notes.md
│   ├── ethical-use.md
│   ├── day-1-checklist.md
│   ├── day-2-checklist.md
│   ├── day-3-checklist.md
│   ├── vmware-setup.md
│   ├── ubuntu-server-install.md
│   ├── static-ip-setup.md
│   ├── ip-forwarding.md
│   ├── nat-routing.md
│   ├── dns.md
│   ├── firewall.md
│   ├── tor-mode.md
│   ├── vpn-mode.md
│   ├── split-tunneling.md
│   └── troubleshooting.md
│
├── scripts/
│   ├── enable-ip-forwarding.sh
│   ├── enable-nat.sh
│   ├── firewall-basic.sh
│   ├── dns-logs.sh
│   ├── monitor-traffic.sh
│   ├── tor-mode-on.sh
│   ├── tor-mode-off.sh
│   ├── vpn-mode-on.sh
│   ├── vpn-mode-off.sh
│   ├── killswitch-on.sh
│   ├── killswitch-off.sh
│   ├── leak-test.sh
│   └── ghostgate
│
├── configs/
│   ├── dnsmasq.conf.example
│   ├── blocklist.conf.example
│   ├── torrc.example
│   ├── wg0-client.conf.example
│   └── split-tunnel.conf.example
│
├── dashboard/
│   ├── app.py
│   ├── requirements.txt
│   ├── templates/
│   │   ├── index.html
│   │   ├── dns.html
│   │   ├── firewall.html
│   │   └── status.html
│   └── static/
│       └── style.css
│
└── screenshots/
    ├── architecture.png
    ├── dashboard.png
    ├── dns-logs.png
    └── tor-mode.png
```

---

## Day 1 Status

Project officially started.

Current phase:

```text
Phase 0: Repository setup and planning
```

Completed:

- Repository initialized
- README created
- Project vision added
- Planned features listed
- Roadmap created
- Architecture documented
- Learning goals defined
- Ethical use policy added
- Example configs added
- Day 1 checklist added

---

## Documentation Index

- [Architecture](docs/architecture.md)
- [Roadmap](docs/roadmap.md)
- [Learning Notes](docs/learning-notes.md)
- [Ethical Use](docs/ethical-use.md)
- [Day 1 Checklist](docs/day-1-checklist.md)
- [VMware Setup](docs/vmware-setup.md)
- [Ubuntu Server Install Notes](docs/ubuntu-server-install.md)
- [Static IP Setup](docs/static-ip-setup.md)
- [IP Forwarding](docs/ip-forwarding.md)
- [NAT Routing](docs/nat-routing.md)
- [Day 2 Checklist](docs/day-2-checklist.md)
- [Day 3 Checklist](docs/day-3-checklist.md)
- [Troubleshooting](docs/troubleshooting.md)

---

## First Major Milestone

The first technical milestone is:

```text
Client VM → Router VM → Internet
```

The Client VM should not have direct internet access.  
It should access the internet only through the Router VM.

This proves that the virtual router foundation is working.

---

## Educational Purpose

GhostGate is strictly an educational networking and privacy engineering project.

It is intended for:

- learning networking
- understanding DNS
- understanding NAT
- learning firewall rules
- studying VPN tunnels
- studying Tor routing
- traffic monitoring
- defensive security learning
- personal lab experimentation

---

## Ethical Use

GhostGate should not be used for:

- illegal activity
- unauthorized access
- abuse of networks
- hiding harmful activity
- attacking websites, services, or users
- bypassing systems in harmful ways

The purpose of this project is to understand how privacy systems work and what their limitations are.

---

## Privacy Reality

GhostGate does not provide perfect anonymity.

Even with VPN or Tor, privacy can still be affected by:

- browser fingerprinting
- cookies
- account logins
- malware
- timing correlation
- DNS leaks
- misconfiguration
- VPS provider logs
- Tor exit node behavior

The realistic goal is:

```text
Reduce traceability.
Understand leaks.
Build safer systems.
```

---

## Future Ideas

Possible future upgrades:

- Provider templates for Oracle Cloud, Google Cloud, Azure, and AWS
- Bring Your Own VPS setup wizard
- Web-based mode switcher
- Automatic blocklist updater
- DNS-over-HTTPS support
- DNS-over-TLS support
- Better split tunneling
- Traffic charts
- Exportable logs
- Docker-based lab version
- OpenWrt version
- Raspberry Pi hardware version

---

## Disclaimer

GhostGate is a learning project.  
It is not a guarantee of anonymity, invisibility, or security.

Use it responsibly and only in environments where you have permission.

---

## License

This project is licensed under the MIT License.
