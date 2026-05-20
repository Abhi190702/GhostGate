from __future__ import annotations

import os
import subprocess
from pathlib import Path
from typing import Iterable

from flask import Flask, render_template

app = Flask(__name__)

INSIDE_IF = os.environ.get("GHOSTGATE_INSIDE_IF", "ens37")
OUTSIDE_IF = os.environ.get("GHOSTGATE_OUTSIDE_IF", "ens33")
CLIENT_IP = os.environ.get("GHOSTGATE_CLIENT_IP", "10.10.10.2")
ROUTER_DNS = os.environ.get("GHOSTGATE_ROUTER_DNS", "10.10.10.1")
DNS_LOG = Path(os.environ.get("GHOSTGATE_DNS_LOG", "/var/log/dnsmasq.log"))


def run_command(command: Iterable[str], timeout: int = 5) -> str:
    try:
        result = subprocess.run(
            list(command),
            capture_output=True,
            check=False,
            text=True,
            timeout=timeout,
        )
    except FileNotFoundError:
        return f"Command not found: {next(iter(command), '')}"
    except subprocess.TimeoutExpired:
        return "Command timed out"

    output = (result.stdout or "") + (result.stderr or "")
    return output.strip() or "(no output)"


def tail_file(path: Path, lines: int = 80) -> str:
    if not path.exists():
        return f"Log file not found: {path}"
    return run_command(["tail", "-n", str(lines), str(path)])


@app.get("/")
def index():
    status = {
        "inside_if": INSIDE_IF,
        "outside_if": OUTSIDE_IF,
        "client_ip": CLIENT_IP,
        "router_dns": ROUTER_DNS,
        "dnsmasq": run_command(["systemctl", "is-active", "dnsmasq"]),
        "forwarding": run_command(["cat", "/proc/sys/net/ipv4/ip_forward"]),
    }
    return render_template(
        "index.html",
        title="Overview",
        active="overview",
        status=status,
        interfaces=run_command(["ip", "-br", "a"]),
        routes=run_command(["ip", "route"]),
    )


@app.get("/dns")
def dns():
    return render_template(
        "dns.html",
        title="DNS",
        active="dns",
        listener=run_command(["ss", "-tulpn"]),
        logs=tail_file(DNS_LOG),
    )


@app.get("/firewall")
def firewall():
    return render_template(
        "firewall.html",
        title="Firewall",
        active="firewall",
        forward=run_command(["sudo", "-n", "iptables", "-L", "FORWARD", "-v", "-n"]),
        nat=run_command(["sudo", "-n", "iptables", "-t", "nat", "-L", "POSTROUTING", "-v", "-n"]),
    )


@app.get("/traffic")
def traffic():
    return render_template(
        "traffic.html",
        title="Traffic",
        active="traffic",
        vnstat=run_command(["vnstat", "-i", INSIDE_IF]),
    )


@app.get("/status")
def status():
    return render_template(
        "status.html",
        title="Status",
        active="status",
        services=run_command(["systemctl", "status", "dnsmasq", "--no-pager", "-l"]),
        leak_test=run_command(["/opt/ghostgate/scripts/leak-test.sh"], timeout=10),
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
