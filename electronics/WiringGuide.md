# Harmonic EQ Mount — Electronics Wiring Guide
**Controller:** FYSETC E4 (ESP32) | **Drivers:** 2× TMC2209  
**Revision:** 1.0 | 2026-06

---

## 1. Power Architecture

```
12V DC PSU (5A / 60W)
    │
    ├─── FYSETC E4 VIN (12V rail) ─────────── all logic and drivers
    │
    ├─── 12V relay coil (normally energised)
    │         │
    │         └─── RA brake coil (NC electromagnetic brake)
    │              Brake releases when 12V applied. Engages on power cut.
    │
    └─── OPTIONAL: 12V dew heater controller (if added later)
```

**PSU spec:** 12V 5A minimum. 24V 3A is an acceptable upgrade (higher torque/speed from TMC2209).  
If using 24V, confirm FYSETC E4 VIN rating (E4 supports 12–24V — verify on your board version).

---

## 2. FYSETC E4 Pin Assignments

| Function | E4 Pin | Notes |
|----------|--------|-------|
| RA Motor (A1) | E0_STEP / E0_DIR / E0_EN | UART: PDN/UART pin |
| DEC Motor (A2) | E1_STEP / E1_DIR / E1_EN | UART: PDN/UART pin |
| RA TMC2209 UART addr | 0 (MS1=L, MS2=L) | Set via resistors on driver board |
| DEC TMC2209 UART addr | 1 (MS1=H, MS2=L) | Set via resistors on driver board |
| Brake relay trigger | GPIO12 (AUX) | HIGH = relay energised = brake released |
| ST4 guider RA+ | GPIO pin (check E4 pinout) | OnStep ST4 interface |
| ST4 guider RA- | GPIO pin | — |
| ST4 guider DEC+ | GPIO pin | — |
| ST4 guider DEC- | GPIO pin | — |
| Status LED | GPIO2 | Onboard LED — blinks OnStep status |
| USB serial | USB-C / Micro-USB | Programming and INDI connection |

> ⚠️ **Check your specific E4 board revision** — pin assignments can vary slightly.  
> Reference: https://github.com/FYSETC/FYSETC-E4

---

## 3. TMC2209 Driver Configuration

Each TMC2209 module installs into the E4's driver socket. No soldering needed.

**UART address setting (via MS1/MS2 pads on driver module):**

| Driver | UART Addr | MS1 | MS2 |
|--------|-----------|-----|-----|
| RA (Axis1) | 0 | LOW | LOW |
| DEC (Axis2) | 1 | HIGH | LOW |

On BIGTREETECH TMC2209 V1.2+: address is set by bridging the two small pads (MS1, MS2) on the underside of the module.  
LOW = pad not bridged (open). HIGH = pad bridged with solder blob.

**Current setting:**  
TMC2209 current is set via OnStepX firmware (AXIS1_DRIVER_IRUN = 800mA).  
The Vref trimmer pot on the driver is bypassed when using UART mode — the firmware controls current directly.

**Microstep setting:**  
256 microsteps set via firmware (UART). The CFG1/CFG2/CFG3 pins on the E4 are overridden by UART.

---

## 4. Stepper Motor Wiring

NEMA 17 stepper motors have 4 wires (2 coils). Identify coil pairs with a multimeter (continuity between same-coil wires).

**Standard wiring (JST-XH 4-pin connector):**

| Pin | Wire Colour (typical) | Coil |
|-----|----------------------|------|
| 1 | Black | A+ |
| 2 | Green | A- |
| 3 | Red | B+ |
| 4 | Blue | B- |

If the motor runs in the wrong direction, swap either the A pair (black/green) OR the B pair (red/blue) — not both.  
Alternatively, set `AXIS1_REVERSE ON` in firmware (preferred — no rewiring).

---

## 5. RA Failsafe Brake Circuit

The brake is a **Normally Closed (NC)** electromagnetic spring brake mounted on the RA motor shaft.  
- **Power ON:** Coil energised → disc released → motor shaft free to rotate.  
- **Power CUT:** Coil de-energised → spring clamps disc → motor shaft locked.

**Wiring:**

```
FYSETC E4 GPIO12 (AUX output)
    │
    └──► 5V relay module (optocoupler isolated)
              │  (relay coil side: 5V from E4 board 5V rail)
              └──► COM → 12V PSU positive
                   NO  → Brake coil +
                         Brake coil - → PSU GND

Firmware: GPIO12 HIGH when mount active → relay energised → 12V to brake → brake released.
          GPIO12 LOW (park / power cut / OnStep inactive) → relay drops → brake engages.
```

**Relay module note:** Use an optocoupler-isolated relay module (e.g., SRD-05VDC-SL-C type). This protects the ESP32 GPIO from the inductive kick of the brake coil. A 1N4007 flyback diode across the brake coil is also recommended.

**Brake spec to source:** 12V NC spring-loaded electromagnetic brake, Ø22mm body, NEMA17-compatible shaft (5mm bore). AliExpress search: `"electromagnetic brake 12V NC NEMA17 spring"`.

---

## 6. ST4 Autoguider Port

The ST4 port allows a guide camera / PHD2 to send guiding corrections directly to the mount.

**RJ12 (6P4C) pinout — standard ST4:**

| Pin | Function |
|-----|----------|
| 1 | RA+ (East) |
| 2 | DEC- (South) |
| 3 | GND |
| 4 | GND |
| 5 | DEC+ (North) |
| 6 | RA- (West) |

Wire to the FYSETC E4 ST4 header — refer to E4 schematic for exact header location.  
In PHD2: select "OnStep" mount and "ST4" guide mode.

---

## 7. WiFi / INDI Connection

The FYSETC E4 (ESP32) creates a WiFi access point on first boot:

- SSID: `HarmonicMount` (set in Config.h)
- Password: `onstep1234` (change before use)
- Web interface: `http://192.168.0.1` once connected

For permanent home observatory use: configure the E4 as a WiFi client connecting to your home network, then assign a static IP.

**INDI / KStars connection:**
1. Install INDI library + indi-onstep driver on Raspberry Pi or Linux PC.
2. In INDI Control Panel → add "OnStep" driver.
3. Connect to the E4's IP on port 9999 (OnStep LX200 protocol).

---

## 8. Wiring Checklist Before First Power-On

- [ ] 12V PSU connected to E4 VIN — polarity correct
- [ ] Both TMC2209 drivers seated correctly (heat sink up, driver ICs facing right)
- [ ] RA motor 4-wire connector plugged into E4 E0 socket
- [ ] DEC motor 4-wire connector plugged into E4 E1 socket
- [ ] Brake relay wired and tested (apply 12V to relay coil input — confirm brake releases)
- [ ] TMC2209 UART addresses confirmed (check MS1/MS2 pads)
- [ ] USB cable connected for first firmware flash
- [ ] No shorts on motor terminals — check with multimeter before powering
- [ ] 12V PSU fused (3A fuse on positive line — protects against wiring errors)
