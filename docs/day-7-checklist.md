# Day 7 Checklist

Day 7 prepares WireGuard VPN mode.

## Router VM

- [ ] Install WireGuard
- [ ] Create `/etc/wireguard/wg0.conf`
- [ ] Confirm `sudo wg-quick up wg0` works
- [ ] Confirm `sudo wg` shows a peer
- [ ] Confirm router public IP changes through VPN

## GhostGate Scripts

- [ ] Install updated scripts
- [ ] Run `ghostgate vpn-on`
- [ ] Confirm client public IP changes through VPN
- [ ] Run `ghostgate vpn-off`
- [ ] Confirm normal mode returns

## Finish Line

Day 7 is complete when:

```text
Client VM -> Router VM -> wg0 -> VPN server -> Internet
```

works.
