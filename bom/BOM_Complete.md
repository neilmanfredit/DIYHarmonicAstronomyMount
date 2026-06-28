# Harmonic Drive Equatorial Mount — Bill of Materials
**Project:** DIY Strain Wave EQ Mount (OnStep/OnStepX)  
**Payload:** Up to 7.5 kg (NexStar 8SE fully rigged)  
**Revision:** 1.0 | Date: 2026-06

---

## SECTION 1 — HARMONIC DRIVE GEARS (Critical — source first)

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 1 | RA Harmonic Drive | CSF-17-100-2A-R or equivalent (100:1, Size 17) | eBay (used/surplus) search: "CSF-17-100" | £80–£150 | Also check: robot-marketplace.co.uk, surplusandsales.co.uk. AliExpress clone: SitoDrive CS-17-I 100:1 (~£65 new) |
| 2 | DEC Harmonic Drive | CSF-14-100-2A-R or equivalent (100:1, Size 14) | eBay (used/surplus) search: "CSF-14-100" | £60–£120 | AliExpress clone: SitoDrive CS-14-I 100:1 (~£50 new) |

**AliExpress clone alternative (if genuine surplus unavailable):**
- Search AliExpress for: `"CSF-17" harmonic reducer 100:1 stepper motor`
- Search AliExpress for: `"strain wave gear" 17 100 hollow shaft`
- Seller to check: SitoDrive, Shenzhen Huikeda, JUNSIN
- Link pattern: aliexpress.com/item/1005008895824297.html (CS-14-I)

> ⚠️ **Verify before ordering:** Confirm the output flange bolt circle and input bore diameter match your motor shaft. CSF-17 input bore is typically Ø8mm or Ø10mm. Request the dimensional drawing from the seller.

---

## SECTION 2 — STEPPER MOTORS

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 3 | RA Stepper Motor | NEMA 17, 40mm body, 1.8°/step, ≥40 N·cm holding torque, 5mm shaft, dual shaft preferred | AliExpress: search "NEMA 17 stepper 42-40 high torque" | £8–£14 each | Recommended: 42HS40-1704 or equivalent |
| 4 | DEC Stepper Motor | Same as above | Same | £8–£14 | Buy 2x identical for interchangeability |

**AliExpress search:** `NEMA 17 stepper motor 42mm 40mm high torque 1.7A`

---

## SECTION 3 — ELECTRONICS

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 5 | Controller Board | FYSETC E4 (ESP32-based, 4x driver slots, OnStep native) | AliExpress: search "FYSETC E4 OnStep" | £25–£35 | First choice for OnStepX compatibility |
| 6 | Stepper Drivers (×2) | TMC2209 UART/SPI, StealthChop, 2.8A peak | AliExpress: search "TMC2209 V3.0 stepper driver" | £4–£7 each | Buy 4 (2 spare). Bigtreetech or MKS brand |
| 7 | RA Failsafe Brake | 12V/24V NC electromagnetic spring brake, NEMA 17 compatible, Ø22mm body | AliExpress: search "electromagnetic brake NEMA17 12V NC spring" | £18–£30 | Normally-Closed type essential. Releases when powered. Mounts on rear shaft |
| 8 | Power Supply | 12V 5A DC switching PSU (60W) | AliExpress / Amazon | £8–£12 | Or 24V 3A for higher torque margin |
| 9 | RJ45 Hand Controller port | ST4 autoguider port breakout (2×5 pin 2.54mm header) | AliExpress: search "RJ45 PCB breakout 2x5" | £2–£4 | For guiding |
| 10 | USB-C / Micro-USB cable | For FYSETC E4 programming/WiFi config | Local / Amazon | £3–£5 | — |
| 11 | 12V relay module (1ch) | For brake coil switching via firmware GPIO | AliExpress | £2–£3 | FYSETC E4 GPIO → relay → brake coil |
| 12 | Wiring / connectors | JST-XH 2.54mm, 4-pin motor connectors, cable sleeving | AliExpress: search "JST XH connector kit" | £5–£8 | Buy a full kit |

---

## SECTION 4 — GT2 BELT DRIVE (Pre-reduction Stage)

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 13 | Motor Pulley (×2) | GT2, 16T, 5mm bore, 6mm belt width | AliExpress: search "GT2 16T pulley 5mm bore" | £1.50–£2.50 each | Fits NEMA 17 5mm shaft directly |
| 14 | Harmonic Input Pulley (×2) | GT2, 48T (3:1 ratio) or 64T (4:1 ratio), 8mm bore, 6mm belt width | AliExpress: search "GT2 48T pulley 8mm bore" | £2–£4 each | Match bore to harmonic input shaft. Machine to size if needed |
| 15 | GT2 Belt (×2) | 6mm wide, 2mm pitch, open-ended, ~300–400mm length | AliExpress: search "GT2 6mm open belt" | £3–£5 per metre | Buy 1m — cut to length on assembly |
| 16 | Belt Tensioner Idler (×2) | GT2, 20T no-tooth smooth, 5mm bore, 6mm belt | AliExpress: search "GT2 smooth idler 5mm" | £1–£2 each | For tensioning adjustment |

**Reduction ratio target:** 16T motor pulley → 48T harmonic input pulley = **3:1**  
Total reduction: 3:1 (belt) × 100:1 (harmonic) = **300:1**  
At 256 microsteps, 200 steps/rev motor → 51,200 microsteps/rev motor shaft → **15,360,000 microsteps/output revolution**

---

## SECTION 5 — STRUCTURAL HARDWARE

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 17 | 6061-T6 Aluminium Plate — RA Housing | 200×200×10mm (qty 2) | metals4u.co.uk / eBay | £12–£18 each | Main RA axis housing plates |
| 18 | 6061-T6 Aluminium Plate — DEC Housing | 160×160×10mm (qty 2) | metals4u.co.uk / eBay | £8–£14 each | DEC axis housing plates |
| 19 | 6061-T6 Aluminium Plate — Polar Axis Body | 250×100×10mm (qty 1) | metals4u.co.uk | £8–£12 | Polar axis spine / body |
| 20 | 6061-T6 Aluminium Round Bar | Ø40mm × 150mm (qty 1) | metals4u.co.uk | £10–£16 | Turned on lathe for RA/DEC shaft stub |
| 21 | M3 Socket Head Cap Screws | M3×8, M3×12, M3×16, M3×20 (100pc assortment) | AliExpress / Amazon | £4–£6 | Grade 12.9 stainless preferred |
| 22 | M4 Socket Head Cap Screws | M4×10, M4×16, M4×20, M4×25 (100pc assortment) | AliExpress / Amazon | £4–£6 | — |
| 23 | M5 Socket Head Cap Screws | M5×16, M5×20, M5×30 (50pc) | AliExpress / Amazon | £3–£5 | Structural plate fasteners |
| 24 | M3/M4/M5 Hex Nuts & Washers | Full assortment | AliExpress: "hex nut washer assortment kit" | £4–£6 | — |
| 25 | Angular Contact Bearings — RA | 6001-2RS or 6002-2RS (×2 pair) — 12×28×8mm or 15×32×9mm | AliExpress: "6002RS angular contact bearing" | £3–£6 pair | Support RA output shaft |
| 26 | Angular Contact Bearings — DEC | 6000-2RS (×2 pair) — 10×26×8mm | AliExpress | £2–£4 pair | Support DEC output shaft |
| 27 | Vixen Dovetail Saddle | Standard 45mm Vixen-style clamp saddle | AliExpress: search "Vixen dovetail saddle telescope" | £12–£20 | Fits both RVO 60ED and NexStar 8SE via Vixen bar |
| 28 | 3/8"-16 Tripod Thumb Screw | For polar axis altitude attachment | Local hardware | £2–£3 | — |
| 29 | Stainless Steel Shaft — RA | Ø10mm × 200mm, h6 tolerance | AliExpress: "stainless shaft 10mm linear rod" | £4–£8 | — |
| 30 | Stainless Steel Shaft — DEC | Ø8mm × 150mm, h6 tolerance | AliExpress | £3–£6 | — |

---

## SECTION 6 — LATITUDE ADJUSTMENT BASE HARDWARE

These items are specific to the four-part latitude base assembly (HEM-LAT-001 through 004). None were in the original BOM — add all of them.

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 31 | 6061-T6 Plate — Azimuth Plate | 290×250×18mm stock (finished 15mm) | metals4u.co.uk | £16–£24 | Buy 18mm stock — face mill to 15mm finish |
| 32 | 6061-T6 Plate — Altitude Plate | 270×230×18mm stock (finished 15mm) | metals4u.co.uk | £14–£22 | Flatness ≤0.05mm critical — specify to machinist |
| 33 | 6061-T6 Block — Hinge Brackets (×2) | 80×60×22mm per bracket | metals4u.co.uk / eBay | £6–£10 each | Machined from flat block or bar off-cut |
| 34 | 6061-T6 Block — Tangent Arm Block | 65×55×45mm | metals4u.co.uk / eBay | £5–£8 | Small block — often available as off-cut |
| 35 | Thrust Bearing | F8-16M (8×16×5mm) — under central tripod stud | AliExpress: search "F8-16M thrust bearing" | £1–£2 | Allows smooth AZ rotation under load |
| 36 | Latitude Pivot Bearings (×2) | 6205-2RS (25×52×15mm) — optional upgrade for hinge pivot | AliExpress: search "6205RS bearing" | £3–£5 each | Standard M8 bolt pivot works for visual use; bearings recommended for imaging |
| 37 | M8 Shoulder Bolt / Precision Pivot (×2) | M8 thread, Ø8mm shoulder, length 80mm | AliExpress: search "M8 shoulder bolt 80mm" or local engineering supplier | £3–£6 each | Pivot bolt for hinge brackets. Must be straight — don't use standard hex bolt |
| 38 | M8 Stainless Threaded Rod — Altitude Lead Screw | M8 × 1.25 pitch, 300mm length, stainless | Local hardware / AliExpress | £3–£5 | Tangent arm drive. 300mm gives 0–70° range from correct starting position |
| 39 | Knurled Altitude Knob | D50mm, M8 thread, aluminium or phenolic | AliExpress: search "knurled knob M8 D50mm large" | £3–£6 | Large knob essential for easy field adjustment in the dark with gloves |
| 40 | M8 Nylon Insert Lock Nut | Stainless, M8 × 1.25 (×4 pack) | Local hardware / AliExpress | £1–£2 | Locking nut on altitude lead screw below knob |
| 41 | Latitude Scale Strip | Adhesive aluminium label, 0–70° in 1° increments, 80mm long | Print on aluminium adhesive sheet or laser engrave | £1–£3 | Self-print template: engrave with scale at tan(θ) × 180 for each degree |
| 42 | M6 Azimuth Clamping Bolts | M6 × 40mm SHCS + penny washers (×4) | Local hardware | £2–£3 | Two bolts per arc slot clamp AZ once polar aligned |
| 43 | M8 Bolts — Hinge Bracket Attachment | M8 × 40mm SHCS stainless (×4) | Local hardware / AliExpress | £2–£3 | Hinge brackets to azimuth plate — Loctite 243 |
| 44 | 3/8"-16 UNC Stainless Steel Stud Insert | Ø22mm OD brass/SS threaded insert, 20mm long | AliExpress: search "3/8 16 UNC threaded insert" or local engineering | £2–£4 | Press into azimuth plate central boss. Alternative: tap M10 (near equivalent) |
| 45 | Bubble Level — Round 28mm | 28mm diameter spirit level, self-adhesive or press-fit | AliExpress: search "28mm circular bubble level" | £1–£2 | Fits into azimuth plate recess — confirms tripod is level before polar aligning |

---

## SECTION 7 — TRIPOD & MOUNTING INTERFACE

> See `docs/TripodMounting.md` for full compatibility notes and setup procedure.

### 7a — Recommended Tripods (UK market, NexStar 8SE payload)

| # | Item | Why | Source | Est. Price (GBP) |
|---|------|-----|--------|-----------------|
| 46 | **Sky-Watcher EQ5 / EQ6 steel tripod** ⭐ Best choice | Heavy (8–10kg), wide stance, damps vibration well, 3/8" centre bolt + 3× M8 leg points. Purpose-built for mounts of this weight class. Used units widely available. | FLO (firstlightoptics.com), eBay | £60–£120 new / £30–£60 used |
| 47 | **Berlebach Report 312 wooden tripod** ⭐ Best for imaging | Wood absorbs high-frequency vibration better than aluminium. 3/8" head, rated 15kg, proven with mounts up to HEQ5 class. | Berlebach dealers (teleskop-service.de ships UK) | £180–£220 |
| 48 | **Manfrotto 190XPRO aluminium tripod** — portable option | 3/8" head, 7kg payload rating, good quality legs. Acceptable for RVO 60ED; marginal for NexStar 8SE at 53° tilt — use sandbag on centre column hook. | Amazon UK / Wex Photo | £90–£130 |
| 49 | **Celestron HD Pro tripod** | Purpose-made astronomy tripod, 2" stainless legs, accessory tray, 3/8" head. Good pairing with this mount. | FLO, Wex, Amazon | £80–£110 |
| 50 | **Gitzo GT2542 carbon tripod** — premium portable option | Carbon damps vibration, lightweight (1.7kg), 3/8" head. Best portable option if budget allows. | Amazon UK / Park Cameras | £400–£500 |

### 7b — Tripod Adapter Hardware

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 51 | 1/4"→3/8" thread adapter bush | For photo tripods with 1/4"-20 UNC head | AliExpress / camera shops | £1–£2 | Only needed for smaller camera tripods — not required for EQ5/EQ6 |
| 52 | Tripod adapter plate — Sky-Watcher EQ5/EQ6 pattern | 3× M8 holes on 120° PCD to match EQ5/EQ6 tripod top + central 3/8" stud | Machine from 5mm 6061 plate (see `cad/tripod-interface/`) | £8–£15 machined | Converts EQ5/EQ6 tripod to accept the azimuth plate central stud |
| 53 | Rubber anti-vibration feet (×3) | 50mm diameter adhesive rubber feet or M8 rubber feet inserts | AliExpress / local hardware | £3–£6 set | Fit under tripod feet — meaningful vibration reduction on hard paving |
| 54 | Sandbag / counterweight hook bag | For hanging from tripod centre column hook under load | Local / Amazon | £5–£10 | Add 3–5kg of ballast to the tripod when using NexStar 8SE — significantly improves stability on light tripods |

### 7c — Permanent Pier Option

For a fixed garden or observatory installation, a concrete pier eliminates all tripod-related vibration and is the best long-term solution.

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 55 | Pier adapter plate | 150mm diameter, 4× M12 anchor bolts on 100mm PCD, central 3/8" stud | Machine from 10mm 6061 plate (add to `cad/tripod-interface/`) | £20–£40 machined | Top plate for 150mm diameter concrete or steel pier |
| 56 | M12 anchor bolts (×4) | M12 × 200mm, stainless, with nuts and washers | Local builder's merchant | £8–£12 set | Cast into concrete pier — set pier before mount is built |

---

## SECTION 8 — POLAR SCOPE / ALIGNMENT

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 57 | Polar Alignment Scope | 1× standard polar scope, Ø30mm tube, illuminated reticle | AliExpress: search "polar alignment scope 30mm" | £12–£20 | Mounts into RA axis bore |

---

## SECTION 9 — OPTIONAL / RECOMMENDED EXTRAS

| # | Item | Spec | Source | Est. Price (GBP) | Notes |
|---|------|------|--------|-----------------|-------|
| 58 | Raspberry Pi Zero 2W | For KStars/INDI remote control | Pi Hut / Amazon | £15–£18 | Enables WiFi plate solving and sequencing |
| 59 | Dew heater controller | 12V PWM 2-channel | AliExpress | £6–£10 | Keep optics clear on damp UK nights |
| 60 | Counterweight shaft | M12 threaded rod, 300mm, stainless | Local hardware | £5–£8 | Ø25mm if machining a proper CW shaft |
| 61 | Counterweights | 1kg × 2, 2kg × 1 (slip-on or screw-lock) | AliExpress: search "telescope counterweight 1kg" | £8–£15 set | Balance for NexStar 8SE load |
| 62 | AS5048A Magnetic Encoder (×2) | For future closed-loop / PEC upgrade | AliExpress: search "AS5048A encoder" | £8–£12 each | Mount on RA and DEC output shafts — future upgrade |

---

## BUDGET SUMMARY (Updated — includes latitude base and tripod)

| Category | Low Estimate (GBP) | High Estimate (GBP) |
|----------|-------------------|---------------------|
| Harmonic drives (genuine surplus) | £140 | £270 |
| Harmonic drives (AliExpress clones) | £100 | £130 |
| Electronics | £65 | £100 |
| Motors + belt drive | £35 | £55 |
| RA/DEC structural aluminium + hardware | £75 | £130 |
| **Latitude base — aluminium stock** | **£45** | **£70** |
| **Latitude base — hardware (bearings, bolts, knob, stud)** | **£25** | **£45** |
| Machining / CNC — RA/DEC plates | £80 | £150 |
| **Machining / CNC — latitude base plates** | **£60** | **£120** |
| **Tripod (Sky-Watcher EQ5 used)** | **£30** | **£60** |
| Extras / contingency | £30 | £50 |
| **TOTAL (genuine surplus gears, used tripod)** | **£585** | **£1,050** |
| **TOTAL (clone gears, used tripod)** | **£545** | **£910** |
| **TOTAL (clone gears, no tripod — you have one)** | **£515** | **£850** |

> The latitude base and tripod add £155–£295 over the original estimate. If you already own a suitable steel astronomy tripod (EQ5/EQ6 class), deduct that line entirely and the budget stays well within target.

---

## SOURCING NOTES

1. **Search eBay UK first** for genuine surplus Harmonic Drive units — search "CSF-17" and "CSF-14". Japanese surplus units from robotics teardowns regularly appear at £60–£150.
2. **AliExpress SitoDrive / Huikeda clones** are a credible alternative. Request a dimensional drawing before ordering to confirm bore, PCD, and output flange pattern.
3. **Aluminium plate:** metals4u.co.uk and eBay (search "6061 aluminium plate") are the most cost-effective UK sources. Buy slightly oversized — the CNC files specify finished dimensions.
4. **Latitude base plates need 15mm stock** — order 18mm and face mill to 15mm. The flatness spec on the altitude plate (≤0.05mm) is strict; mention it explicitly when quoting with a machinist.
5. **Tripod:** if you already own a Sky-Watcher EQ5, EQ6, or HEQ5 tripod, it will work directly with a simple adapter plate. Don't buy a tripod if you have one — source the adapter plate instead (Section 7b, item 52).
6. **All AliExpress items:** filter by ≥4.5★ rating, >50 orders. Avoid sellers with no reviews on that specific item.
