# FYSETC E4 Pin Assignments
**Board:** FYSETC E4 v1.0 (ESP32-based) | **Firmware:** OnStepX  
**Reference:** https://github.com/FYSETC/FYSETC-E4  
**Revision:** 1.0 | 2026-06

> ⚠️ Pin assignments vary between E4 board revisions. Verify against the schematic
> for your specific board before wiring. The assignments below are for the E4 v1.0.

---

## Stepper Driver Sockets

| Socket | OnStep Axis | Signals | TMC2209 UART Addr |
|--------|-------------|---------|------------------|
| E0 | Axis 1 (RA) | STEP / DIR / EN / PDN_UART | 0 (MS1=L, MS2=L) |
| E1 | Axis 2 (DEC) | STEP / DIR / EN / PDN_UART | 1 (MS1=H, MS2=L) |
| E2 | Spare | — | — |
| E3 | Spare | — | — |

The E4 routes a shared UART bus to all four driver sockets. Each driver is addressed individually via MS1/MS2 pads on the TMC2209 module underside.

---

## GPIO Assignments (HEM-001 Configuration)

| GPIO | Function | Config Reference | Signal |
|------|----------|-----------------|--------|
| GPIO2 | Status LED | `STATUS_LED_PIN 2` | Onboard LED — blinks OnStep status codes |
| GPIO12 | Brake relay trigger | `AUX_RELAY_1_PIN 12` | HIGH = relay ON = brake released |
| GPIO34 | ST4 RA+ (East) | OnStep ST4 | Input (3.3V tolerant) |
| GPIO35 | ST4 RA– (West) | OnStep ST4 | Input |
| GPIO36 | ST4 DEC+ (North) | OnStep ST4 | Input |
| GPIO39 | ST4 DEC– (South) | OnStep ST4 | Input |

---

## Power Rails Available on E4

| Rail | Voltage | Max Current | Use |
|------|---------|-------------|-----|
| VIN | 12–24V | Input rail | PSU input |
| 5V | 5V | ~2A | Relay module coil, fans |
| 3.3V | 3.3V | ~300mA | Sensors, encoders |
| Motor power | VIN | Per driver (TMC2209 up to 2A RMS) | Motor coils via driver |

---

## TMC2209 UART Address Configuration

On each BTT or MKS TMC2209 module, two small pads (MS1, MS2) on the underside set the UART address:

| Address | MS1 | MS2 | Mounting |
|---------|-----|-----|---------|
| 0 (RA) | Open (LOW) | Open (LOW) | E0 socket |
| 1 (DEC) | Bridged (HIGH) | Open (LOW) | E1 socket |

Bridge a pad = solder blob across the two exposed pads. Open = leave unsoldered.

---

## USB Port

The E4 uses a Micro-USB or USB-C connector (check your board revision) for programming and serial monitoring. The ESP32 on the E4 includes a USB-Serial converter — no separate FTDI adapter needed.

After programming, the USB port remains available for serial monitoring at 115200 baud.

---

## Heatsinks

Fit heatsinks on all TMC2209 drivers. At 800mA IRUN and 256 microsteps, the drivers run warm. The E4 has 40mm fan headers — fitting a small 40mm fan over the driver area is recommended for extended imaging sessions.
