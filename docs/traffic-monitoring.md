# Traffic Monitoring

Traffic monitoring shows that client traffic is passing through the Router VM.

## Install Tools

On the Router VM:

```bash
sudo apt update
sudo apt install -y tcpdump iftop vnstat
```

## Watch Client Packets

Inside GhostGate interface:

```bash
sudo tcpdump -i ens37
```

Stop with:

```text
Ctrl + C
```

## Watch Bandwidth

```bash
sudo iftop -i ens37
```

Stop with:

```text
q
```

## View Traffic Stats

```bash
vnstat
vnstat -i ens37
```

## Simple Demo

1. Run `sudo tcpdump -i ens37` on the Router VM.
2. On the Client VM, run:

```bash
ping -c 3 github.com
curl --max-time 10 example.com
```

3. The Router VM should show packets from `10.10.10.2`.
