# Parts Sourcing Notes
**Project:** HEM-001 | **Revision:** 1.0 | 2026-06

---

## Harmonic Drives — The Critical Decision

The harmonic drive units dictate cost, quality, and critical dimensions. You have three realistic routes.

### Route 1 — Genuine Harmonic Drive® Surplus (Best quality, variable availability)

Search eBay UK and eBay Germany for:
- `CSF-17-100` — any suffix (2A-R, 2UH, etc.)
- `CSF-14-100` — any suffix
- `HD Systems harmonic reducer`

Japanese industrial surplus from robotics teardowns appears regularly. Expect £60–£150 for a CSF-14, £80–£200 for a CSF-17. Backlash will be <5 arcsec even on used units.

**Inspection on receipt:** if you can, run the unit by hand and feel for roughness. A smooth, consistent feel with no notchiness is good. Some grease depletion is normal — replenish before assembly.

### Route 2 — Chinese Clones from AliExpress (Best value, consistent availability)

Reliable brands to search:
- **SitoDrive** — search `"SitoDrive CS-17" 100:1` and `"SitoDrive CS-14" 100:1`
- **Huikeda** — search `"Huikeda harmonic reducer size 17"`
- **JUNSIN** — search `"JUNSIN harmonic drive CSF-17"`

AliExpress direct links (search these terms — links expire):
- `site:aliexpress.com CSF-17-100 harmonic reducer NEMA17`
- `site:aliexpress.com strain wave gear size 17 100:1 stepper motor`

Typical price: £50–£80 for CS-17, £40–£60 for CS-14. New, guaranteed dimensions.

**What to check when ordering:**
- Confirm input bore size (8mm or 10mm — ask seller before ordering)
- Confirm output flange bolt circle PCD (should be 63mm for size 17, 50mm for size 14)
- Request a dimensional drawing (most sellers have one — just ask)
- Confirm the unit ships with grease (most do; top up with Mobil 28 or Kyodo Yushi LRL3)

**Backlash on clones:** typically 15–40 arcsec. For this application (OnStep + PHD2 autoguiding), this is perfectly acceptable. PHD2 compensates for periodic error; backlash in a tracking mount (always moving in the same direction in RA) is essentially irrelevant.

### Route 3 — Robot-marketplace / Industrial Surplus Suppliers

- robot-marketplace.co.uk
- surplusandsales.co.uk
- tradebearings.com (ships to UK)

These carry genuine or OEM-equivalent units at mid-range prices. Longer lead times than AliExpress but more reliable sizing.

---

## Aluminium Plate

UK sources for 6061-T6 aluminium plate:

| Supplier | Notes | URL |
|----------|-------|-----|
| metals4u.co.uk | Good stock, cut-to-size service | metals4u.co.uk |
| aaluminium.co.uk | Competitive pricing on full sheets | aaluminium.co.uk |
| eBay UK | Search "6061 aluminium plate" — offcuts often cheap | ebay.co.uk |
| Online Metals (US) | If buying in bulk (not UK) | onlinemetals.com |

**Buy slightly oversized** — order 10mm extra in each dimension. The CNC files specify finished dimensions; stock needs to allow for edge cleanup.

For the latitude base plates (15mm thick): metals4u sell cut-to-size pieces. Order `280×250×15mm` for the azimuth plate and `270×230×15mm` for the altitude plate.

---

## Electronics

All electronics items can be sourced from **AliExpress** with reliable delivery times. Filter by:
- ≥4.5 star rating
- ≥50 orders on that specific listing
- Seller with >95% positive feedback

Alternatively, UK suppliers for faster delivery:
- **Ooznest.co.uk** — TMC2209 drivers, NEMA17 motors, GT2 belts and pulleys
- **3DJake.co.uk** — motors and electronics
- **Amazon UK** — FYSETC E4 is often available from FBA sellers (check description carefully — "FYSETC E4" specifically, not just "FYSETC board")

**FYSETC E4 specifically:** as of 2026, the E4 is stocked by several Amazon UK sellers. Expect £28–£40. Verify it ships with the correct TMC socket pitch for TMC2209 modules.

---

## Machining Services (UK)

If you don't have access to a VMC or lathe:

| Service | Notes |
|---------|-------|
| Xometry.eu | Online CNC quoting, collects UK orders |
| Protolabs.co.uk | Fast turnaround, higher price |
| Local engineering shops | Search "CNC machining [your city]" — often cheapest for simple aluminium work |
| MakerSpaces | Some have VMCs (Hackspace Manchester, London Hackspace) — machine yourself |
| eBay "CNC machining service" | Small shops offering custom work — mixed quality, get quotes from 3+ |

**What to send:**
1. STL file (exported from OpenSCAD)
2. The corresponding `_MachiningOps.nc` file (explains critical tolerances and sequence)
3. Material: 6061-T6 aluminium
4. Finish: natural or clear anodise

Typical quote for the full plate set (8 parts): £250–£500. The latitude base plates and bearing pockets are the most expensive operations due to flatness and boring requirements.

---

## Counterweights

AliExpress sells compatible slip-on counterweights in 1kg and 2kg sizes. Search `"telescope counterweight 1kg astronomy"`. Ensure the bore matches your CW shaft diameter (12mm for M12 threaded rod).

For heavier payloads beyond the NexStar 8SE, add a third 2kg counterweight — the M12 shaft length (300mm) accommodates up to 3×2kg comfortably.
