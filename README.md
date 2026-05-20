# GhostGate

GhostGate is a virtual privacy router lab built for learning Linux networking, privacy engineering, DNS filtering, firewalling, Tor routing, WireGuard VPN, traffic monitoring, and self-hosted VPN concepts.

The project simulates a Raspberry Pi-style privacy router completely inside virtual machines, without requiring extra hardware.

---

## Project Vision

The goal of GhostGate is to help students and beginners understand how network traffic flows through routers, DNS servers, firewalls, VPN tunnels, and anonymity networks.

Instead of only using VPN or Tor tools, GhostGate focuses on understanding how these systems work internally.

---

## Architecture

Basic architecture:

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
