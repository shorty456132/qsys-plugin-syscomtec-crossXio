# Q-SYS Plugin: Syscomtec crossXio SCT-IPCX

A Q-SYS control plugin for the **Syscomtec crossXio SCT-IPCX** AVoverIP Controller. Enables full control of AV matrix routing, video walls, scenes, and device management via TCP/Telnet from within a Q-SYS design.

**Version:** 1.0.0
**License:** [GNU GPLv3](LICENSE)

---

## Overview

The Syscomtec crossXio system is a 1Gbit AVoverIP platform consisting of:

- **SCT-IPE5100** — Encoder (TX)
- **SCT-IPD5100** — Decoder (RX)
- **SCT-IPCX** — Controller

This plugin communicates with the SCT-IPCX controller over **Telnet (TCP port 23)** using its ASCII command API.

---

## Requirements

- Q-SYS Designer software
- Syscomtec crossXio SCT-IPCX controller on the control network
- Network access from the Q-SYS Core to the controller's LAN2 interface

---

## Installation

1. Copy `Syscomtec-crossXio.qplug` to your Q-SYS plugins directory.
2. In Q-SYS Designer, search for **"Syscomtec crossXio"** in the component library and add it to your design.

---

## Configuration

### Properties

| Property | Default | Description |
|---|---|---|
| Debug Print | Tx/Rx | Log level: None, Tx/Rx, Tx, Rx, All |
| Poll Rate | 10s | Status poll interval (5–60 seconds) |
| Max Devices | 16 | Maximum discoverable devices (8–64) |
| Video Wall Count | 4 | Number of video wall slots (1–8) |
| Scene Count | 16 | Number of scene slots (1–32) |

### Connection Setup

1. Enter the controller's IP address (LAN2 default: `192.168.11.243`).
2. Set Telnet port (default: `23`).
3. Click **Connect** to establish the TCP connection.
4. The plugin auto-discovers TX/RX devices on connection.

---

## Features

### Matrix Routing
- Route any TX (encoder) source to one or more RX (decoder) destinations
- Query and display the current routing state
- Disconnect individual receivers

### Video Walls
- Configure up to 8 video wall presets (rows × columns grid)
- Switch video wall sources
- Bezel compensation and picture parameter tuning

### Scene Management
- List and recall up to 32 named scenes stored on the controller

### Device Management
- Auto-discover all TX/RX devices on the network
- Assign human-readable aliases to devices
- Reboot individual devices
- CEC display control (standby / wake)
- Configure IP settings (static / DHCP / auto-IP)

### Audio Control
- Per-channel gain, volume, and mute
- Phantom power control for microphone inputs

### Custom Commands
- Send raw ASCII commands directly to the controller via the **Setup** page
- View the last response for debugging

---

## UI Pages

| Page | Description |
|---|---|
| Control | Connection, device discovery, matrix routing |
| Video Walls | Create and switch video wall configurations |
| Scenes | Recall stored scenes |
| Devices | Per-device alias, reboot, and CEC controls |
| Setup | Raw command input and last response display |

---

## API Reference

See [`crossXio_SCT-IPCX_API.md`](crossXio_SCT-IPCX_API.md) for the full controller command reference, including device parameters, connection defaults, and examples.

---

## Network Defaults

| Interface | Default IP | Purpose |
|---|---|---|
| LAN1 | 169.254.1.1 | AV network (TX/RX devices) |
| LAN2 | 192.168.11.243 | Control network (Telnet / Web) |

---

## License

This plugin is licensed under the [GNU General Public License v3.0](LICENSE).
