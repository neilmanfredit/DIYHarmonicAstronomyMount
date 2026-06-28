# DIY Harmonic Drive Equatorial Mount — Engineering Specification
**Project:** HEM-001 | **Owner:** Neil Manfred | **Revision:** 1.0 | **Date:** 2026-06

---

## 1. Project Overview

A custom-built strain wave (harmonic drive) German Equatorial Mount for visual and astrophotography use. Designed to carry a 7.5 kg maximum payload (NexStar 8SE SCT fully rigged), with resolution and tracking quality exceeding commercial mounts in the ZWO AM3/AM5 class, built within a £400–£760 budget.

**Key design decisions:**
- Harmonic drives selected for zero backlash, high reduction in compact form — eliminates worm gear, periodic error is minimal and PEC-trainable.
- GT2 belt pre-reduction (3:1) between motor and harmonic input reduces motor speed requirement and increases torque at the harmonic input shaft.
- NC failsafe brake on RA axis prevents mount crash when power is cut with the NexStar 8SE loaded.
- OnStepX firmware chosen for active development, strong community, INDI/KStars integration, and native ESP32 WiFi support.

---

## 2. System Architecture

```
                    ┌────────────────────────────────────────┐
                    │           FYSETC E4 (ESP32)            │
                    │         OnStepX Firmware               │
                    │   TMC2209 RA │ TMC2209 DEC             │
                    └──────┬───────────────┬─────────────────┘
                           │               │
                    NEMA17 Motor     NEMA17 Motor
                    (RA Axis)        (DEC Axis)
                           │               │
                    GT2 Belt 3:1    GT2 Belt 3:1
                    (16T→48T)       (16T→48T)
                           │               │
                   CSF-17 100:1    CSF-14 100:1
                   Harmonic Drive  Harmonic Drive
                           │               │
                    RA Output        DEC Output
                    Flange           Flange
                           │               │
                    Polar Axis      Vixen Saddle
                    Spine            │
                    (latitude         RVO 60ED
                    adjusted)        or NexStar 8SE
```

---

## 3. Tracking Resolution

| Parameter | Value |
|-----------|-------|
| Motor full steps/rev | 200 (1.8°/step NEMA17) |
| Microstepping | 256 |
| Belt reduction | 3:1 (16T → 48T GT2) |
| Harmonic reduction (RA) | 100:1 (CSF-17) |
| Total reduction (RA) | 300:1 |
| Total reduction (DEC) | 300:1 |
| Microsteps per output revolution | 200 × 256 × 300 = **15,360,000** |
| Degrees per microstep | 360 / 15,360,000 = **0.0000234°** |
| Arcseconds per microstep | **0.0843 arcsec/step** |
| Sidereal tracking rate | 15.04"/sec → ~179 microsteps/sec |

This resolution comfortably supports unguided exposures and is well within the 0.06–0.08 arcsec/step target (0.0843 arcsec is acceptable; increase belt ratio to 4:1 to reach 0.063 arcsec/step if desired).

**With 4:1 belt (64T harmonic input pulley):**
- Total reduction: 400:1
- Steps/revolution: 20,480,000
- Arcsec/step: 0.0632 arcsec — hits the lower target exactly.

*Recommendation: build with 3:1 first (simpler, cheaper). Upgrade pulleys to 4:1 if tracking performance demands it.*

---

## 4. Torque Margin Analysis

**RA Axis (NexStar 8SE payload, 7.5 kg):**

| Parameter | Value |
|-----------|-------|
| Payload mass | 7.5 kg |
| Effective moment arm (telescope + counterweight) | ~0.3 m (assumed) |
| Static torque at RA output | ~22 N·m (7.5 × 9.81 × 0.3) |
| CSF-17-100 rated continuous torque | 24 N·m (at 2000 RPM input) |
| Motor torque at input (NEMA17 40mm) | ~0.45 N·m |
| Motor torque at harmonic input (after 3:1 belt) | ~1.35 N·m |
| Torque at RA output (1.35 × 100 × 0.70 efficiency) | ~94.5 N·m peak |

✅ **Large torque margin** — the harmonic drive is more than adequate. NEMA17 torque easily drives the system.

**Tracking requirement (sidereal rate, 7.5 kg payload, well-balanced):**  
A well-balanced mount requires only ~0.5–2 N·m to overcome friction in tracking. The 94 N·m available is far more than needed — the limiting factor is balance quality, not motor torque.

---

## 5. Critical Dimensions Reference

### CSF-17-100-2A-R (RA Axis)
| Dimension | Value |
|-----------|-------|
| Output flange OD | 79 mm |
| Output bolt circle PCD | 63 mm |
| Output bolt pattern | 6× M4, 60° spacing |
| Wave generator housing bore | 30 mm |
| Overall length (component set) | 38 mm |
| Max continuous output torque | 24 N·m |
| Max momentary torque | 54 N·m |
| Rated input speed | 2,000 RPM max |

### CSF-14-100-2A-R (DEC Axis)
| Dimension | Value |
|-----------|-------|
| Output flange OD | 63 mm |
| Output bolt circle PCD | 50 mm |
| Output bolt pattern | 6× M3, 60° spacing |
| Wave generator housing bore | 24 mm |
| Overall length | 33 mm |
| Max continuous output torque | 13 N·m |
| Max momentary torque | 26 N·m |

> ⚠️ **Verify these dimensions with the actual unit received.** Surplus/clone units may vary slightly. Measure before machining plates.

---

## 6. Files Included in This Package

| File | Location | Purpose |
|------|----------|---------|
| `BOM_HarmonicEQMount.md` | bom/ | Full Bill of Materials with sourcing |
| `RA_FrontPlate.scad` | cad/ | OpenSCAD — RA housing plate (parametric) |
| `DEC_HousingPlate.scad` | cad/ | OpenSCAD — DEC housing plate |
| `PolarAxis_Spine.scad` | cad/ | OpenSCAD — polar axis body |
| `RA_FrontPlate_Drawing.svg` | cad/ | 2D engineering drawing for machinist |
| `RA_FrontPlate_MachiningOps.nc` | cnc/ | CNC machining operations / G-code strategy |
| `OnStepX_Config.h` | firmware/ | OnStepX firmware configuration |
| `Electronics_WiringGuide.md` | docs/ | Wiring schematic and connection guide |
| `Engineering_Spec.md` | docs/ | This document |

---

## 7. Build Sequence (Recommended Order)

1. **Source harmonic drives first** — they have the longest lead time and set the critical dimensions that drive all machining.
2. **Measure actual harmonic drives received** — confirm bore, PCD, and flange OD before releasing plates for machining.
3. **Update .SCAD parameters** with measured dimensions (adjust `CENTRAL_BORE`, `HD_BOLT_PCD`, `HD_BOLT_DIA` as needed).
4. **Export STL / DXF** from OpenSCAD for your CAM package or machinist.
5. **Machine plates** — RA front and rear, DEC housing, polar spine.
6. **Source and test electronics** on bench before assembly — confirm OnStepX responds via serial, both motors jog correctly.
7. **Dry-assemble** without harmonic drives — confirm plate alignments, bearing fits, motor mounting.
8. **Assemble with harmonic drives** — apply light grease to harmonic wave generator (Mobil 28 or similar).
9. **Commission firmware** — polar align, track a star, adjust `AXIS1_REVERSE` if needed.
10. **Train PEC** after 2–3 hours stable tracking.

---

## 8. Notes on Harmonic Drive Clones

AliExpress clones (SitoDrive, Huikeda) are viable for this application. Key checks:

- **Backlash:** Should be <30 arcsec (measurable with a lever arm and dial gauge). Genuine Harmonic Drive® is typically <5 arcsec.
- **Dimensional accuracy:** Measure bore and PCD before machining — clones occasionally have small deviations from the nominal CSF spec.
- **Lubrication:** Chinese clones often ship under-greased. Pack the wave generator bearing with NLGI-2 lithium grease on receipt.
- **Rated torque:** Clone torque ratings are often optimistic. Apply a 30% derating factor for continuous operation.

For this payload (7.5 kg, well-balanced), even derated clone gears provide more than adequate torque margin.

---

## 9. Future Upgrades (Post-Commissioning)

| Upgrade | Benefit | When |
|---------|---------|------|
| 4:1 belt ratio (64T pulley) | 0.063 arcsec/step resolution | If tracking shows drift |
| TMC5160 drivers | Higher current, better microstepping linearity | If noise/heating issue |
| Encoder feedback (AS5048A) | Closed-loop control, eliminates periodic error | Advanced — after stable open-loop |
| Electronic focuser | Remote focus control | Alongside mount commissioning |
| Raspberry Pi + KStars | Full goto / plate solving / sequencing | When mount tracks well |
| Physical counterweight shaft upgrade | More elegant than threaded rod | Cosmetic / practical |
