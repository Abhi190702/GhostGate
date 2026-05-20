# VMware Workstation Pro Setup

Day 2 creates the two virtual machines that will become the GhostGate lab.

The target topology is:

```text
Client VM -> VMware LAN Segment: GhostGate-Lab -> Privacy Router VM -> VMware NAT -> Internet
```

## Important Rule

The Client VM must not have direct NAT or bridged networking.

If the Client VM has direct internet access, it can bypass GhostGate. The whole
point of this lab is to force the Client VM to use the Privacy Router VM as its
only gateway.

## VMware Network Design

Use two different network roles:

| Network | VMware setting | Purpose |
|---|---|---|
| Outside network | NAT | Lets the Router VM reach the internet through the Windows host |
| Inside lab network | LAN Segment: `GhostGate-Lab` | Private network between Router VM and Client VM |

LAN Segment is preferred over Host-only because it avoids host DHCP confusion
and keeps the inside lab network clean.

## VM 1: Privacy Router VM

Suggested settings:

| Setting | Value |
|---|---|
| Name | `GhostGate-Router` |
| OS | Ubuntu Server LTS or Debian |
| RAM | 2048 MB |
| CPU | 2 cores |
| Disk | 20 GB, dynamically allocated |

### Router VM Network Adapters

| Adapter | VMware setting | Purpose |
|---|---|---|
| Network Adapter 1 | NAT | Outside internet side |
| Network Adapter 2 | LAN Segment: `GhostGate-Lab` | Inside client side |

Later, inside Ubuntu Server, these interfaces may appear as names like:

```text
ens33 = NAT / outside
ens37 = LAN Segment / inside
```

Do not hard-code those names until you confirm them with:

```bash
ip a
```

## VM 2: Client VM

Suggested settings:

| Setting | Value |
|---|---|
| Name | `GhostGate-Client` |
| OS | Ubuntu Desktop, Linux Mint, or your existing Ubuntu VM |
| RAM | 4096 MB preferred |
| CPU | 2 cores preferred |
| Disk | 25 GB minimum |

### Client VM Network Adapter

| Adapter | VMware setting | Purpose |
|---|---|---|
| Network Adapter 1 | LAN Segment: `GhostGate-Lab` | Forces client traffic to the router |

Do not give the Client VM NAT or Bridged networking during GhostGate tests.

During the Ubuntu Desktop installation only, it is acceptable to temporarily use
NAT if the installer needs internet access or gets stuck. After installation is
complete, switch the Client VM back to LAN Segment `GhostGate-Lab`.

## Creating The LAN Segment

In VMware Workstation Pro:

1. Shut down the VM before editing adapters.
2. Open VM settings.
3. Select the network adapter.
4. Choose `LAN segment`.
5. Create or select:

```text
GhostGate-Lab
```

Use the exact same LAN Segment name for Router Adapter 2 and Client Adapter 1.

## Expected State After Day 2

At the end of Day 2:

- Router VM exists
- Client VM exists
- Router VM has two adapters
- Client VM has one GhostGate test adapter
- Router Adapter 1 is NAT
- Router Adapter 2 is LAN Segment `GhostGate-Lab`
- Client Adapter 1 is LAN Segment `GhostGate-Lab`
- Ubuntu Server is installed on the Router VM
- Ubuntu Desktop or Linux Mint is available as the Client VM

Internet routing from the Client VM is not expected to work yet. That comes
after static IPs, IP forwarding, NAT, and DNS are configured.

## Screenshots To Save

Save screenshots into the `screenshots/` folder:

- `router-adapter-1-nat.png`
- `router-adapter-2-ghostgate-lab.png`
- `client-adapter-1-ghostgate-lab.png`
- `router-login.png`
- `client-desktop.png`

## Validation

Before moving to Day 3, confirm:

- Router VM boots successfully
- Client VM boots successfully
- Router VM Adapter 1 is NAT
- Router VM Adapter 2 is LAN Segment `GhostGate-Lab`
- Client VM test adapter is LAN Segment `GhostGate-Lab`
- Client VM does not have direct NAT or Bridged access during GhostGate tests

## Common Mistakes

### Mistake: Client VM has NAT enabled

Problem: the client can bypass GhostGate.

Fix: remove NAT from the Client VM while testing GhostGate, or disable that
adapter and keep only LAN Segment `GhostGate-Lab`.

### Mistake: Router and Client use different LAN Segment names

Problem: the VMs are on different isolated networks.

Fix: both inside adapters must use exactly:

```text
GhostGate-Lab
```

### Mistake: Expecting internet on Client VM during Day 2

Problem: the client is isolated by design.

Fix: wait for Day 3 and Day 4. Internet access requires static IPs, router
gateway settings, IP forwarding, and NAT.
