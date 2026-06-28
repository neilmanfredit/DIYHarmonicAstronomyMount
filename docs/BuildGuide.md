# Build Guide — HEM-001 Harmonic Drive EQ Mount
**Revision:** 1.0 | 2026-06

---

## Overview

This guide takes you from a bag of parts to a tracking mount. It is sequenced to minimise rework — each stage depends on the previous one being confirmed before proceeding.

**Estimated build time:** 40–80 hours (machining and electronics excluded)  
**Skill level required:** Intermediate (comfortable with metric fasteners, basic electronics, Linux/firmware flashing)

---

## Stage 0 — Before You Order Anything

1. **Decide on harmonic drive source** — surplus genuine or AliExpress clone. See `docs/PartsSourcing.md`.
2. **Order harmonic drives first.** They take 2–6 weeks from AliExpress, or may require waiting for eBay surplus to appear.
3. **When drives arrive:** measure them. Record:
   - Input shaft bore (nominal: CSF-17 = 8mm or 10mm; CSF-14 = 8mm)
   - Output flange bolt circle PCD (nominal: CSF-17 = 63mm; CSF-14 = 50mm)
   - Number of output bolts and thread size (nominal: CSF-17 = 6× M4; CSF-14 = 6× M3)
   - Housing boss OD (nominal: CSF-17 = 30mm; CSF-14 = 24mm)
4. **Update SCAD parameters** with measured values before sending to machinist.

---

## Stage 1 — Machining

### Order of machining

| Priority | Part | File | Why |
|----------|------|------|-----|
| 1 | RA Front Plate | `cad/ra-axis/RA_FrontPlate.scad` | Critical — drives all RA assembly |
| 2 | RA Rear Plate | `cad/ra-axis/RA_RearPlate.scad` | Pair with front plate |
| 3 | Latitude Base — Altitude Plate | `cad/latitude-base/LatBase_AltitudePlate.scad` | Flatness critical |
| 4 | Latitude Base — Azimuth Plate | `cad/latitude-base/LatBase_AzimuthPlate.scad` | Thrust bearing fit |
| 5 | DEC Housing Plate | `cad/dec-axis/DEC_HousingPlate.scad` | DEC axis |
| 6 | Hinge Brackets (×2) | `cad/latitude-base/LatBase_HingeBracket.scad` | Latitude assembly |
| 7 | Tangent Arm Block | `cad/latitude-base/LatBase_TangentArmBlock.scad` | Latitude drive |
| 8 | Polar Axis Spine | `cad/ra-axis/PolarAxis_Spine.scad` | Main body |

### Sending to an external machinist

Supply each part with:
- The `.scad` file exported as STL (OpenSCAD → Design → Render → Export as STL)
- The corresponding `_Drawing.svg` or `_MachiningOps.nc` file
- Material specification: **6061-T6 Aluminium**
- Finish: **Natural (uncoated) or clear anodise**
- Key tolerances called out in the ops files — highlight bearing bores and pivot holes

Typical UK machining quotes for this part set: £250–£500 depending on machinist and quantity of setups.

---

## Stage 2 — Electronics Bench Test

Before assembling any mechanics, confirm the electronics work on the bench.

### 2a — Flash OnStepX

1. Clone OnStepX: `git clone https://github.com/hjd1964/OnStepX`
2. Copy `firmware/OnStepX_Config.h` to `src/Config.h`
3. Edit LATITUDE and LONGITUDE for your location
4. Open in VS Code with PlatformIO extension
5. Select environment: `FYSETC_E4`
6. Build and upload via USB

Confirm serial response:
```
minicom -D /dev/ttyUSB0 -b 9600
Type: :GVP#
Expected response: On-Step
```

### 2b — Motor Jog Test

1. Connect one NEMA17 to E0 port (RA motor)
2. Connect second NEMA17 to E1 port (DEC motor)
3. Power on 12V PSU
4. Connect to WiFi SSID `HarmonicMount`, password `onstep1234`
5. Open `http://192.168.0.1` in browser
6. Use jog controls to move RA and DEC
7. If motor runs in wrong direction: set `AXIS1_REVERSE ON` in Config.h and reflash

### 2c — Brake Test

1. Wire brake relay per `electronics/BrakeCircuit.md`
2. Confirm brake releases when 12V applied to relay coil
3. Cut power — confirm brake engages within 0.5 seconds
4. If brake hums but doesn't release: check 12V supply voltage (should be 11.8–13V)

---

## Stage 3 — Latitude Base Assembly

1. **Thrust bearing:** press F8-16M thrust bearing into azimuth plate bottom recess. Light interference fit — use a press or bench vice with wooden blocks.
2. **Hinge brackets:** bolt to azimuth plate top face, rear edge. M8 × 40mm bolts, torque to 15 N·m. Loctite 243 on threads.
3. **Altitude plate:** rest on hinge brackets. Insert M8 pivot bolts through hinge bracket bores and altitude plate rear holes. Run an M8 nut up to hand-tight — the pivot must rotate freely.
4. **Tangent arm block:** bolt to azimuth plate top face at front. M5 × 20mm bolts.
5. **Lead screw:** thread M8 × 300mm stainless rod up through tangent arm block. Add nylon-insert locknut at bottom (below block), then knurled knob above. Thread tip contacts altitude plate underside at tangent arm socket.
6. **Test:** turn knob — altitude plate should tilt smoothly with no binding. Full range: 0–70°.
7. **Fit latitude scale strip:** adhesive aluminium strip on azimuth plate front face. Mark 53° line at correct position (verified with a protractor or digital angle gauge).

---

## Stage 4 — RA Axis Assembly

1. **Bearings:** press 6002-2RS bearings into front and rear plate pockets. Use a press — do not hammer.
2. **RA shaft:** insert Ø10mm stainless shaft through front plate bearing, through harmonic drive central bore, through rear plate bearing. Fix with M6 circlip or shoulder bolt at each end.
3. **Harmonic drive:** mount CSF-17 output flange to front plate using 6× M4 × 12mm socket head screws. Torque to 3.5 N·m. Loctite 243.
4. **GT2 pulleys:** press 48T pulley onto harmonic drive input shaft. Press 16T pulley onto NEMA17 motor shaft. Key both with M4 grub screws onto flat.
5. **Motor:** bolt NEMA17 to motor slot on front plate. Leave slot bolts loose.
6. **Belt:** fit GT2 belt, tension by sliding motor in slots until belt deflects 1–2mm under 200g finger pressure. Tighten motor bolts.
7. **Brake:** mount NC electromagnetic brake on rear motor shaft (dual-shaft motor). Bolt to rear plate brake boss (4× M3). Connect brake wires to relay module.

---

## Stage 5 — DEC Axis Assembly

Identical procedure to RA but using CSF-14 and smaller plate. No brake on DEC axis.

1. Press 6000-2RS bearings into DEC plate pockets.
2. Mount CSF-14 to DEC plate (6× M3 × 10mm).
3. Fit GT2 pulleys and belt (same 3:1 ratio).
4. Mount Vixen saddle plate to DEC output (4× M6 × 16mm into DEC output flange adapter — machine a simple DEC saddle adapter plate from 5mm aluminium).

---

## Stage 6 — Full Assembly

1. Bolt polar axis spine to altitude plate (4× M6 × 20mm, top face).
2. Mount RA axis assembly to top of spine (4× M5 × 16mm into spine's top mounting face).
3. Mount DEC axis assembly to RA output side (4× M5 via RA output adapter plate).
4. Route motor wires and brake wire through cable management holes.
5. Connect to FYSETC E4 (in an enclosure — 3D print one using `cad/electronics-box/` — to be added in v1.1).
6. Mount polar alignment scope into RA axis central bore.

---

## Stage 7 — Commissioning

See `docs/Commissioning.md` for full OnStep setup, polar alignment, and first-light procedure.

**Key checks before first power-on with telescope mounted:**
- [ ] All structural bolts torqued and Loctited
- [ ] Belt tension correct on both axes
- [ ] Brake wired and tested (stage 2c)
- [ ] Balance confirmed (RA and DEC both neutral when motors disengaged)
- [ ] Polar scope installed and illuminated (battery-powered reticle)
- [ ] Latitude set to 53° (or your local latitude)
- [ ] OnStep WiFi confirmed working
