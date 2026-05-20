# Ubuntu Server Install Notes

These notes are for installing Ubuntu Server on the `GhostGate-Router` VM.

## Featured Server Snaps Page

On the page titled:

```text
Featured server snaps
```

leave every option unchecked.

For GhostGate, do not install:

- microk8s
- nextcloud
- docker
- prometheus
- lxd
- powershell
- any other featured snap

These are not needed for the router VM and they can waste RAM, disk, and boot
time.

## What To Press

Use the keyboard:

1. Press `Tab` until `Done` is highlighted.
2. Press `Enter`.

If you accidentally selected something, move to it and press `Space` to
deselect it.

## After This Page

Ubuntu Server should continue installing the base system.

When installation finishes:

1. Choose `Reboot Now`.
2. If VMware asks about the ISO, disconnect/eject the ISO.
3. Let the VM boot from the virtual disk.
4. Log in with the username and password you created.
5. In VMware, click `I Finished Installing` when the installed system boots.

## First Login Checks

After login, run:

```bash
ip a
ip route
hostname
```

Do not configure GhostGate routing yet. Day 3 will assign the static inside IP
and identify the correct network interface names.
