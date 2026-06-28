# RA Failsafe Brake Circuit
**Part:** NC Electromagnetic Brake | **Voltage:** 12V DC  
**Part No:** HEM-ELEC-002 | **Revision:** 1.0 | 2026-06

---

## Why the Brake Exists

The NexStar 8SE weighs 5.5 kg bare (7.5 kg fully rigged). Mounted on the RA axis at arm's length, it generates significant torque. If power is cut unexpectedly — tripped breaker, cable pulled, PSU fault — the RA axis can back-drive freely, swinging the OTA downward and potentially damaging the telescope, the mount, or anything in the way.

The NC (Normally Closed) electromagnetic brake holds the RA motor shaft locked **by default**. It releases only when the 12V coil is energised. Power cut = brake engages automatically.

The brake does **not** apply during normal tracking. The motor holds position via StealthChop, and the brake is released (coil energised) whenever OnStepX is active.

---

## Circuit Diagram

```
12V PSU (+)
    │
    ├────────────────────────────► FYSETC E4 VIN (+)
    │
    └──► Relay Module (coil +)
              │
              Relay Module (coil –) ──► FYSETC E4 GPIO12 (AUX)
              │
              GPIO12 logic:
                HIGH (3.3V) = relay energised = brake RELEASED (coil gets 12V)
                LOW  (0V)   = relay de-energised = brake ENGAGED (spring locks)
                OnStep parks / powers off → GPIO12 LOW → brake engages

Relay COM ──► 12V PSU (+)
Relay NO  ──► Brake coil (+)
Brake coil (–) ──► PSU GND

Flyback diode 1N4007 across brake coil terminals (cathode to + side)
```

---

## Component List

| Component | Spec | Source |
|-----------|------|--------|
| Electromagnetic brake | 12V NC, Ø22mm, NEMA17 shaft (5mm bore) | AliExpress: "electromagnetic brake NEMA17 12V NC spring" |
| Relay module | 1-channel, 5V coil, optocoupler isolated, SRD-05VDC-SL-C | AliExpress |
| Flyback diode | 1N4007 | Any electronics supplier |
| JST-XH connector | 2-pin, for brake coil wires | AliExpress kit |

---

## OnStepX GPIO Configuration

In `firmware/OnStepX_Config.h`:

```c
#define AUX_RELAY_1_PIN  12   // GPIO12 on FYSETC E4 — drives relay coil
```

OnStepX activates this GPIO when the mount is tracking or slewing.  
When the mount is parked or powered off via software, the GPIO goes LOW and the brake engages.

---

## Testing the Brake

Before mounting the telescope:

1. Power on — confirm brake releases (you should hear a light click and the motor shaft should spin freely by hand).
2. Issue park command from OnStep web UI or hand controller.
3. Confirm brake engages (click again, shaft now locked).
4. Cut PSU power directly — confirm brake engages within 0.5 seconds.
5. Try to rotate the RA axis by hand with brake engaged — it should resist firmly.

If the brake hums but does not release: check supply voltage (must be ≥11V). If supply is low, the coil pulls in but doesn't fully release the disc.

If the brake does not engage on power cut: check the relay wiring. The relay should use the **NC (Normally Closed)** contact, not NO. Verify NO/COM/NC pin assignments on your relay module.

---

## Dual-Shaft Motor Requirement

The NC brake mounts on the **rear shaft** of the NEMA17. This requires a **dual-shaft NEMA17** motor — shaft protrudes from both ends. Standard single-shaft motors will not work.

When ordering: search AliExpress for `"NEMA 17 dual shaft stepper motor 42mm"` or `"NEMA17 double shaft 5mm"`. They cost the same as single-shaft variants.

The front shaft drives the GT2 belt. The rear shaft carries the brake disc.
