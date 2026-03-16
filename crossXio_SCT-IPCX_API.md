# Syscomtec crossXio SCT-IPCX — API Reference

## Product Overview

- **Model:** syscomtec crossXio AVoverIP Controller SCT-IPCX
- **Part of:** 1G crossXio AV-over-IP system (Encoder: SCT-IPE5100, Decoder: SCT-IPD5100, Controller: SCT-IPCX)
- **Purpose:** Central controller for managing encoders (TX) and decoders (RX) on a 1Gbit AVoverIP network
- **Manufacturer:** syscomtec Distribution AG, Keltenring 11, 82041 Oberhaching, Germany
- **Manual Version Referenced:** SCT-IPCX Manual V1.0.1 / SCT-IPKVM-CX Manual V1.0.0

---

## Hardware / Connectivity

| Interface       | Details                            |
|-----------------|------------------------------------|
| LAN1            | RJ45, PoE+ — TX/RX AV network      |
| LAN2            | RJ45 — Control network (Telnet/Web)|
| RS-232          | Phoenix 6-pin connector            |
| USB             | 2x USB 2.0 Type-A                  |
| Power           | 12V/2A external or PoE             |
| Dimensions      | 215 x 25 x 120.2 mm                |
| Weight          | 0.8 kg                             |

---

## Control Methods

| Method       | Details                              |
|--------------|--------------------------------------|
| Telnet       | Port 23, ASCII commands + `<CR>`     |
| SSH          | Supported                            |
| REST API     | HTTP / HTTPS                         |
| Web GUI      | Browser-based, includes command box  |
| RS-232       | Serial passthrough and control       |

---

## Connection Defaults

- **Default Control IP:** `192.168.11.243` (LAN2 port)
- **Default TX/RX Network IP:** `169.254.1.1` (LAN1 port — link-local)
- **Default Web Password:** `admin`
- **Telnet Port:** `23`
- **Command format:** Plain ASCII, terminated with `<CR>` (carriage return)

---

## API Command Reference

### Config — Get Parameters

```
config get version
```
Returns API version and system firmware version.
**Response:** `API version: Vx.x` / `System version: Vx.x.x`

---

```
config get devicelist
```
Returns a list of all discovered TX/RX hostnames on the network.
**Response:** `devicelist is hostname1 hostname2 ...`

---

```
config get ipsetting
```
Returns IP settings used for TX/RX communication (LAN1).
**Response:** `ipsetting is: ipaddr xx.xx.xx.xx netmask xx.xx.xx.xx gateway xx.xx.xx.xx`

---

```
config get ipsetting2
```
Returns IP settings used for Telnet/Web control (LAN2).
**Response:** `ipsetting2 is: ipaddr xx.xx.xx.xx netmask xx.xx.xx.xx gateway xx.xx.xx.xx`

---

```
config get name {alias | hostname}
```
Resolves alias → hostname or hostname → alias. No argument = list all.
**Response:** `hostname's alias is xxxx`

---

```
config get device <hostname>
```
Returns TX/RX device details (IP mode, IP address, MAC, gateway, sink info).

---

```
config get device info <hostname1> <hostname2> ...
```
Returns full JSON info for one or more devices. See Device JSON Info section below.

---

### Config — Set Parameters

```
config set ip4addr <ip> netmask <nm> gateway <gw>
```
Sets IP address for TX/RX communication (LAN1). Takes effect immediately.

---

```
config set ip4addr2 <ip> netmask <nm> gateway <gw>
```
Sets IP address for Telnet/Web control (LAN2). Takes effect immediately.

---

```
config set webloginpasswd <password>
```
Changes the web login password.

---

```
config set reboot
```
Reboots the SCT-IPCX controller.

---

```
config set shutdown
```
Shuts down the SCT-IPCX controller.

---

```
config set restorefactory
```
Resets the SCT-IPCX controller to factory defaults.

---

```
config set debuglog {on | off}
```
Enables or disables debug logging.

---

```
config set device alias <hostname> <alias>
```
Assigns a human-readable alias to a TX or RX device.
> **Note:** Alias cannot contain: `, ; _ @ * & ` or spaces.

---

```
config set device remove <hostname1> <hostname2> ...
```
Removes device records from the controller's list. Hostname or alias accepted.

---

```
config set device ip <hostname1> {autoip|dhcp|static} <ip> <netmask> <gateway>, <hostname2> ...
```
Sets IP address mode for TX/RX devices. Separate multiple devices with commas.
Does **not** take effect until device reboots.

**Example:**
```
config set device ip EX383-341B22FFFFB3 autoip, EX383-341B22FFFFB4 static 169.254.2.110 255.255.0.0 169.254.0.254, mytv dhcp
```

---

```
config set device reboot <hostname1> <hostname2> ...
```
Reboots one or more TX/RX devices.

---

```
config set device restorefactory <hostname1> <hostname2> ...
```
Resets one or more TX/RX devices to factory defaults.

---

```
config set device info key1=value1 key2=value2 ... <hostname1> <hostname2> ...
```
Sets parameters (volume, gain, source input, HDCP, etc.) on one or more devices.

**Example:**
```
config set device info mic_volume=20 audio.mic1.gain=12 audio.lineout1.volume=20 EX143-AABBCCDDEEFF
```

---

```
config set device standby <hostname1> <hostname2> ...
```
Sends CEC standby to the display connected to the specified decoder.
> Requires display to support CEC.

---

```
config set device onetouchplay <hostname1> <hostname2> ...
```
Sends CEC one-touch play (power on) to the display connected to the specified decoder.
> Requires display to support CEC.

---

### Matrix Routing

```
matrix set TX1 RX1 RX2, TX2 RX3 RX4, ...
```
Routes one or more TX sources to one or more RX destinations. Records are comma-separated.
Set TX to `NULL` to disconnect the specified RX(s).

**Example — Route TX to multiple RX:**
```
matrix set MS501-341B22FFFFC2 EX373-341B22800316, MS501-341B22FFFFC2 EX373-341B22800309
```

**Example — Disconnect RX:**
```
matrix set NULL RX1 RX2
```

---

```
matrix get
```
Returns current routing state.

**Response format:**
```
matrix information:
TX1 RX1
TX2 RX3
TX2 RX4
```

---

### Video Wall

```
vw add <vw-name> <rows> <cols> <tx>
```
Creates a new video wall configuration with the specified grid dimensions and source TX.

**Example:**
```
vw add vw1 2 2 tx1
```

---

```
vw add <vw-name> layout <n> <m> <TX> <RX11> <RX12> ... <RXnm>
```
Creates a video wall in one command. RX are listed in display order (left-to-right, top-to-bottom). Use `0` for a position with no change.

**Example:**
```
vw add vw1 layout 2 2 tx1 rx1 rx2 rx3 rx4
```
Creates:
```
tx1→rx1  tx1→rx2
tx1→rx3  tx1→rx4
```

---

```
vw add <vw-name> <rx1> <row> <col> <rx2> <row> <col> ...
```
Assigns RX devices to specific positions within an existing video wall.

**Example:**
```
vw add vw1 rx1 1 1 rx2 1 2 rx3 2 1 rx4 2 2
```

---

```
vw rm <vw-name>
```
Removes a video wall configuration.

---

```
vw change <rx> <tx>
```
Switches a single RX to display a TX full-screen (removes it from any video wall).

---

```
vw change <vw-name> <tx>
```
Redirects all RX in a video wall to a new TX source.

---

```
vw bezelgap <vw-name> <outer_width> <outer_height> <visible_width> <visible_height>
```
Sets bezel compensation. Units are **0.1mm**.

**Example (90.01cm visible width, 91.01cm outer width, 40.52cm visible height, 42.52cm outer height):**
```
vw bezelgap vw1 9001 9101 4052 4252
```

---

```
vw pictureparam <vw-name> <h-shift> <v-shift> <h-scale> <v-scale> <tearing-delay> <rx1> <rx2> ...
```
Fine-tunes image positioning per RX within a video wall.
- `h-shift` / `v-shift`: units of 8 pixels; negative = left/up
- `h-scale`: 1/columns; `v-scale`: 1/rows
- `tearing-delay`: microseconds, range `10000–16000`

---

```
vw get
```
Returns all video wall configurations and their current RX assignments.

---

### Scene Management

```
scene get
```
Lists all saved scenes.

---

```
scene active <scenename>
```
Activates (recalls) a named scene.

**Example:**
```
scene active Office-meeting room
```

---

```
scene set <scenename> <posX> <posY> <tx>
```
Changes the TX source for a specific RX position within a scene.

---

### Multiple View (Multi-window)

```
mv get
```
Returns multiple view assignments for all EX383-type decoders.

---

```
mv set <rx> <tx1> <tx2> ... <txn>
```
Assigns multiple TX sources to a single RX for multi-window display. Supports 1, 4, 9, or 16 sources.

---

### Serial Pass-through

```
serial -b <baud-databits-parity-stopbits> -r {on|off} "<command-string>" <hostname1> <hostname2> ...
```
Sends a serial command through one or more TX/RX devices to their connected RS-232 peripherals.

- `-b` param: e.g. `115200-8n1` (default if omitted)
- `-r on`: appends carriage return to command string (default)
- `command-string`: cannot contain `"` or `,`

**Example:**
```
serial -b 115200-8n1 -r on "KA WE 4E CC" EX383-341B22FFFFB3
```

---

## Device Addressing

Devices are identified by **hostname** (MAC-based, e.g. `EX383-341B22FFFFB3`) or assigned **alias**.

- Aliases must be unique
- Alias restrictions — cannot contain: `, ; _ @ * & ` (space)
- Commands accept either hostname or alias interchangeably

---

## Device JSON Info — Parameter Reference

Returned by `config get device info <hostname>`. Also used as keys in `config set device info`.

### Universal Parameters

| Key        | Type/Range          | Notes                              |
|------------|---------------------|------------------------------------|
| `name`     | string              | Read-only hostname                 |
| `mac`      | string              | Read-only, format AA:BB:CC:DD:EE   |
| `ip_mode`  | autoip/dhcp/static  | `ip_mode=static`                   |
| `ip4addr`  | string              | `ip4addr=192.168.1.100`            |
| `netmask`  | string              | `netmask=255.255.0.0`              |
| `gateway`  | string              | `gateway=192.168.1.1`              |
| `hdcp`     | true/false          | `hdcp=true`                        |
| `sourcein` | vga1/vga2/hdmi1/hdmi2/hdmi3/hdmi4/cvbs1/cvbs2 | `sourcein=hdmi1` |

### Audio Parameters (MX143 / MS500 only)

| Key                        | Range           | Notes                     |
|----------------------------|-----------------|---------------------------|
| `mic_volume`               | 0–100, step 10  |                           |
| `mic_mute`                 | true/false      |                           |
| `audio.<name>.gain`        | 6–24, step 6    | e.g. `audio.mic1.gain=12` |
| `audio.<name>.phantom`     | true/false      | e.g. `audio.mic1.phantom=false` |
| `audio.<name>.volume`      | 0–100, step 10  | e.g. `audio.lineout1.volume=60` |
| `audio.<name>.mute`        | true/false      | e.g. `audio.lineout1.mute=false` |

> Audio `name` values: `mic1`–`mic8`, `linein1`, `linein2`, `lineout1`, `lineout2`

### Encoder Parameters (MX143, MX153, MS500, MS501, EX363)

| Key               | Range       | Notes                           |
|-------------------|-------------|---------------------------------|
| `enc_rc_mode`     | cbr/vbr/fixqp |                               |
| `profile`         | bp/mp/hp    | base/middle/high profile        |
| `cbr_avg_bitrate` | 2–40960     |                                 |
| `vbr_max_bitrate` | 2–40960     |                                 |
| `vbr_min_qp`      | 0–51        |                                 |
| `vbr_max_qp`      | 0–51        |                                 |
| `fixqp_iqp`       | 0–51        |                                 |
| `fixqp_pqp`       | 0–51        |                                 |
| `enc_gop`         | 1–65535     |                                 |
| `enc_fps`         | 1–60        |                                 |
| `transport_type`  | raw/ts      |                                 |

---

## Quick Reference — Common AV Integration Commands

```bash
# Get all devices on network
config get devicelist

# Get current routing state
matrix get

# Route encoder "tx1" to decoders "rx1" and "rx2"
matrix set tx1 rx1 rx2

# Route two encoders to separate decoders
matrix set tx1 rx1 rx2, tx2 rx3 rx4

# Disconnect a decoder
matrix set NULL rx3

# Create a 2x2 video wall (single command)
vw add vw1 layout 2 2 tx1 rx1 rx2 rx3 rx4

# Change video wall source
vw change vw1 tx2

# Recall a scene
scene active "Office-meeting room"

# Reboot a decoder
config set device reboot EX383-341B22FFFFB3

# CEC display standby
config set device standby EX373-341B22800490

# CEC display power on
config set device onetouchplay EX373-341B22800490
```

---

## Notes for Q-SYS Plugin Development

- All commands are **ASCII over TCP port 23** (Telnet) — use `TcpSocketClient` component or Lua TCP socket
- Commands are terminated with `\r` (carriage return only)
- Responses are plain text; matrix/device list responses are multi-line
- The controller auto-discovers TX/RX devices — poll `config get devicelist` on startup
- Device hostnames are MAC-address based and stable; aliases are optional but useful for readability
- The REST API (HTTP/HTTPS) is available but undocumented in the public manual — Telnet is the reliable path for third-party control
- For routing, TX/RX can be referenced by hostname or alias in all commands
- `matrix get` response format: one `TX RX` pair per line

---

## References

- Product page: https://www.syscomtec.com/de/syscomtec-crossxio-avoverip-controller-ip-rs232-poe-sct-ipcx.html
- crossXio product site: https://crossxio.com/
- Manual download: `syscomtec crossXio SCT-IPCX Manual V1.0.1.pdf` (available on product page)
- ManualsLib: https://www.manualslib.com/manual/3665268/Syscomtec-Crossxio-Sct-Ipcx.html
- Encoder manual (SCT-IPE5100): https://www.manualslib.com/manual/3679923/Syscomtec-Crossxio-Sct-Ipe5100.html
