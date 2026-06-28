# Tripod Mounting & Latitude Adjustment Guide
**Project:** HEM-001 Harmonic Drive EQ Mount  
**Revision:** 1.0 | 2026-06

---

## 1. How the Mount Attaches to a Tripod

### The Problem with Most DIY Mounts

Most homebrew EQ mounts treat the tripod interface as an afterthought — a single bolt through the centre, with nothing to stop the mount rotating freely in azimuth or rocking under load. For astrophotography, this is the fastest route to star trails.

The HEM-001 latitude base solves this properly, following the same mechanical architecture used on Losmandy and iOptron commercial mounts.

---

## 2. The Three-Plate Latitude Adjustment System

The latitude base is a **four-component assembly** that sits between the tripod head and the RA polar spine:

```
TRIPOD HEAD
     │
     ▼
┌─────────────────────────────────────┐
│  AZIMUTH PLATE (HEM-LAT-001)        │  ← Fixed to tripod. 3/8" central stud.
│  - 3/8"-16 UNC central stud         │    Rotates freely for coarse AZ.
│  - Thrust bearing underneath         │    Two M6 clamping bolts lock AZ.
│  - Two AZ arc slots (±8°)            │
│  - Hinge bracket mounting holes      │
└─────────────┬───────────────────────┘
              │ (hinge brackets, left and right)
              ▼
┌─────────────────────────────────────┐
│  ALTITUDE PLATE (HEM-LAT-002)       │  ← Tilts on pivot to set latitude.
│  - Hinges at rear (south edge)       │    Tangent arm drives front up/down.
│  - Tangent arm socket at front       │    Latitude scale visible at front window.
│  - 4× M6 spine attachment holes      │    Lock once set — don't adjust at night.
└─────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│  RA POLAR SPINE (HEM-RA-003)         │  ← Bolts to altitude plate top face.
│  - RA and DEC axis assemblies on top │    This is the main mount body.
└─────────────────────────────────────┘
```

---

## 3. Tripod Compatibility and Interface Options

### Option A — Standard Photo Tripod (recommended for portability)

Most quality photo tripods have a **3/8"-16 UNC** threaded stud on the head. The azimuth plate's central boss screws directly onto this.

**Procedure:**
1. Level the tripod using the built-in bubble level or a separate level on the accessory tray.
2. Rough-point the tripod north (compass or Polaris).
3. Screw the azimuth plate onto the tripod head. **Do not overtighten** — the thrust bearing underneath must be able to rotate freely for AZ adjustment.
4. Insert the two M6 AZ clamping bolts through the arc slots but leave them loose.

**Tripod requirements for the NexStar 8SE payload (7.5 kg mount + OTA):**
- Minimum leg section: 28mm diameter aluminium or carbon
- Minimum leg wall thickness: 1.5mm
- Recommended: Manfrotto 190, Gitzo GT2 series, or dedicated astronomy tripod
- Celestron/Sky-Watcher steel tripod: ✅ Ideal — heavy enough to damp vibration

### Option B — Dedicated Astronomy Steel Tripod

Sky-Watcher and Celestron steel tripods (supplied with EQ3 / EQ5 / CG-5 mounts) use a **M12 central bolt** and three accessory tray screws. A **tripod adapter plate** (see `cad/tripod-interface/TripodAdapter_3_8.scad`) converts this to the standard 3/8" stud pattern.

The adapter plate:
- Sits on the tripod head's flat top face
- Is secured by the M12 central bolt
- Provides a 3/8"-16 UNC stud protruding upward for the azimuth plate

### Option C — Pier / Permanent Observatory Installation

For a permanent pier, machine the azimuth plate base with a **Ø150mm flat face** and four M12 anchor bolt holes on a 120mm PCD. This matches standard commercial pier top plates. The azimuth adjustment becomes a one-time setup operation rather than a field procedure.

---

## 4. Setting Latitude

### Step 1 — Rough Set

Before attaching the telescope, set the altitude plate angle to approximately your latitude. For Stockport (53.41°N), this is 53°.

Use the laser-engraved or adhesive scale strip at the front of the altitude plate. The window in the altitude plate's front edge lets you read the scale against a reference line scribed on the azimuth plate.

Turn the **D50mm knurled altitude knob** clockwise to raise the front of the altitude plate (increasing tilt angle). The M8 lead screw has a 1.25mm pitch — one full turn = 1.25mm travel, which equals approximately 0.40° at 53° latitude.

### Step 2 — Fine Set During Polar Alignment

Once the telescope is mounted and tracking:

1. Use the **polar scope** (30mm bore through the RA axis) to centre Polaris in the reticle.
2. If Polaris is too high: lower the altitude plate slightly (loosen knob, let plate settle).
3. If Polaris is too low: raise the altitude plate.
4. Use the AZ trim slots (M6 bolts, ±8° travel) for left-right fine correction.

### Step 3 — Lock and Verify

Once polar aligned:
1. Tighten the altitude knob locknut (nylon insert nut on M8 rod, above the knob).
2. Tighten the secondary M6 clamp bolt on the tangent arm block.
3. Tighten both M6 AZ clamping bolts through the arc slots.
4. Do not touch the latitude adjustment again that session.

### Step 4 — Software Verification

In OnStepX via the web interface or INDI/KStars:
- Confirm site latitude matches your actual latitude (edit `firmware/OnStepX_Config.h` LATITUDE parameter)
- Perform a 2-star or 3-star alignment
- Check pointing accuracy — if stars are consistently off in one direction, revisit polar alignment before adjusting the model

---

## 5. Latitude Range

The tangent arm geometry supports **0° to 70° latitude** without modification. This covers:

| Location | Latitude |
|----------|----------|
| Stockport (design target) | 53.41°N |
| London | 51.5°N |
| Edinburgh | 55.9°N |
| Inverness | 57.5°N |
| Southern Spain | 36°N |
| Equatorial (visual only) | 0° |
| Southern hemisphere | Up to 70°S with mount flipped |

For latitudes above 65°, a second tangent arm block position is required (shift the block contact point further from the hinge). This is a simple remachining of the azimuth plate tangent arm socket position — documented in `cnc/latitude-base/`.

---

## 6. Balance and Centre of Gravity

This is critical. An unbalanced mount on a photo tripod will vibrate, flex, and — with the NexStar 8SE — can tip the tripod.

**Rules:**
1. The combined centre of gravity of mount + OTA + counterweights must be **directly above the tripod centre** in both RA and DEC axes.
2. In RA: adjust counterweight position on the CW shaft until the RA axis is balanced (no tendency to rotate when clutch is disengaged).
3. In DEC: slide the telescope in the Vixen saddle until DEC axis is balanced.
4. Always balance **before** powering the motors.
5. For the NexStar 8SE (5.5 kg OTA at ~300mm from DEC axis): expect 3–4 kg of counterweight at 200mm on the shaft.

**Tripod centre-of-mass check:**
With the mount assembled and polar aligned (tilted at 53°), check that the vertical projection of the OTA+mount+CW centre of mass falls within the tripod footprint. At 53° tilt with a long SCT, this can be marginal. Add a third leg brace or use a wider-stance tripod if the system feels tippy.

---

## 7. Vibration Damping

The steel tripod legs are your best vibration damper. Additional measures:

- **Tennis balls under tripod feet** — classic and genuinely effective on hard floors/paving.
- **Sand-filled legs** — fill hollow aluminium tripod legs with dry sand (seal with tape) for ~3dB vibration reduction.
- **Concrete pad** — if fixed outdoors, a 400×400×150mm concrete pad with embedded pier bolts eliminates tripod vibration entirely.
- **Foam pad under feet** — 20mm dense foam under each foot damps high-frequency shutter and slew vibrations.

The harmonic drive itself contributes to vibration damping — the flexspline absorbs input shaft vibration before it reaches the output, which is one reason harmonic drive mounts image better than equivalent worm gear mounts at the same price point.

---

## 8. Field Setup Procedure (Summary)

1. Set up tripod, level, rough-point north.
2. Attach azimuth plate — central stud, leave AZ bolts finger-tight.
3. Set latitude on altitude plate (turn knob to scale reading).
4. Attach RA polar spine — 4× M6 bolts.
5. Attach telescope via Vixen saddle.
6. Balance RA and DEC axes.
7. Power on — OnStep initialises, connect via WiFi.
8. Polar align using polar scope (rough) then SharpCap / drift method (fine).
9. Lock all clamp bolts.
10. 2-star or 3-star alignment in KStars/INDI.
11. Start imaging.
