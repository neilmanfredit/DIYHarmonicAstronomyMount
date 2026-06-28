# OnStepX Firmware — Flash Instructions
**Board:** FYSETC E4 (ESP32) | **Firmware:** OnStepX

---

## Prerequisites

- [VS Code](https://code.visualstudio.com/) with [PlatformIO extension](https://platformio.org/install/ide?install=vscode)
- Git
- USB cable (Micro-USB or USB-C depending on E4 board revision)
- Python 3.x (required by PlatformIO)

---

## Steps

```bash
# 1. Clone OnStepX
git clone https://github.com/hjd1964/OnStepX.git
cd OnStepX

# 2. Copy the HEM-001 config into place
cp /path/to/this-repo/firmware/OnStepX_Config.h src/Config.h

# 3. Edit your location (MANDATORY)
nano src/Config.h
# Change LATITUDE and LONGITUDE to your actual coordinates.
# Stockport defaults are pre-set (53.41, -2.16) — update if needed.
# Change WIFI_AP_PASSWORD to something secure before use.
```

Open the `OnStepX` folder in VS Code → PlatformIO will auto-detect the project.

In the PlatformIO sidebar:
1. Select environment: `FYSETC_E4`
2. Click **Build** (tick icon) — should complete with 0 errors
3. Hold the BOOT button on the E4 board, connect USB, release BOOT
4. Click **Upload** (arrow icon)
5. Upload completes — board reboots automatically

---

## Verify

Connect to WiFi SSID `HarmonicMount` (or your custom SSID).  
Open `http://192.168.0.1` in a browser.

You should see the OnStep web interface with RA/DEC readouts.

Alternatively, via serial monitor (9600 baud):
```
:GVP#     → response: On-Step
:GVN#     → response: firmware version string
:Ga#      → response: current local sidereal time
```

---

## Updating

Pull the latest OnStepX, re-apply the config, rebuild:
```bash
cd OnStepX
git pull
cp /path/to/this-repo/firmware/OnStepX_Config.h src/Config.h
# Rebuild and upload as above
```

Always check the OnStepX CHANGELOG before updating — Config.h parameter names occasionally change between major versions.

---

## WiFi Setup (Home Network Mode)

After first boot, configure the E4 to join your home network (rather than creating its own AP):

1. Connect to `HarmonicMount` AP
2. Open `http://192.168.0.1` → Settings → WiFi
3. Enter your home SSID and password
4. Set a static IP in your router's DHCP table for the E4 MAC address
5. Reconnect — the mount is now accessible at your assigned IP from any device on your home network

This allows KStars/INDI on a Raspberry Pi or desktop to connect without a separate AP connection.

---

## INDI Driver

Install on Linux / Raspberry Pi:
```bash
sudo apt-get install indi-onstep
```

In KStars → Ekos → INDI Control Panel → Add device → Telescope → OnStep.  
Connection: Network → IP = your E4's IP, Port = 9999.
