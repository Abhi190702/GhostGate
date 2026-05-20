# Tor Mode

Tor mode routes Client VM TCP traffic through Tor from the Router VM.

Current normal flow:

```text
Client VM -> Router VM -> VMware NAT -> Internet
```

Tor flow:

```text
Client VM -> Router VM -> Tor transparent proxy -> Tor network -> Internet
```

## Install Tor

On the Router VM:

```bash
sudo apt update
sudo apt install -y tor
```

## Configure Tor

Edit:

```bash
sudo nano /etc/tor/torrc
```

Add at the bottom:

```text
VirtualAddrNetworkIPv4 10.192.0.0/10
AutomapHostsOnResolve 1
TransPort 10.10.10.1:9040
DNSPort 10.10.10.1:5353
```

Restart:

```bash
sudo systemctl restart tor
sudo systemctl status tor --no-pager -l
```

## Enable Tor Mode

On the Router VM:

```bash
sudo /opt/ghostgate/scripts/tor-mode-on.sh
```

Verify the redirect rules:

```bash
sudo iptables -t nat -L PREROUTING -v -n
sudo ss -tulpn | grep -E '9040|5353'
```

## Disable Tor Mode

On the Router VM:

```bash
sudo /opt/ghostgate/scripts/tor-mode-off.sh
```

## Test From Client

Open Firefox in the Client VM:

```text
https://check.torproject.org/
```

You can also run:

```bash
curl --max-time 30 https://check.torproject.org/api/ip
```

The public IP should change from the normal VMware NAT public IP. If it does
not change, Tor mode is not actually carrying the client's TCP traffic yet.

## Troubleshooting

Check Tor service:

```bash
sudo systemctl status tor --no-pager -l
sudo journalctl -u tor --no-pager -n 80
```

Check whether Tor is listening:

```bash
sudo ss -tulpn | grep -E '9040|5353'
```

Expected:

```text
10.10.10.1:9040
10.10.10.1:5353
```

If Tor listens only on `127.0.0.1:9040` and `127.0.0.1:5353`, edit
`/etc/tor/torrc` and use the explicit `10.10.10.1` listener addresses above.

Check current NAT rules:

```bash
sudo iptables -t nat -L PREROUTING -v -n
```

If normal internet works but Tor check does not, turn Tor mode off:

```bash
ghostgate tor-off
```

Then confirm normal mode:

```bash
ping -c 3 google.com
curl --max-time 10 ifconfig.me
```

## Important Limitations

- Tor mode may be slower.
- Tor mode is not magic anonymity.
- Logged-in accounts, cookies, browser fingerprints, and malware can still identify the user.
- This first version focuses on TCP and DNS redirection for the lab client.
