; ============================================================
; Harmonic EQ Mount — CNC Machining Operations
; Part: RA Front Plate (HEM-RA-001)
; Material: 6061-T6 Aluminium, 200×200×12mm stock (10mm finish)
; Machine: 3-axis vertical machining centre
; Post-processor: Generic Fanuc / Mach4 (adapt as needed)
; Units: mm | Coolant: Flood or mist recommended
; Revision: 1.0 | 2026-06
; ============================================================
;
; NOTE: This file contains TOOLPATH STRATEGY and REPRESENTATIVE
; G-CODE BLOCKS. It is not a complete CNC program.
; Send the .SCAD file to your CAM package (FreeCAD/CAM,
; Fusion 360, or similar) and reference these operations
; and cutting parameters to generate the final NC program.
;
; If sending to an external machinist, supply:
;   1. RA_FrontPlate.scad (CAD geometry)
;   2. RA_FrontPlate_Drawing.svg (2D drawing with dimensions)
;   3. This file (machining intent)
;   4. BOM for tolerance context
; ============================================================

; ---- STOCK SETUP ----
; Stock: 200 × 200 × 12mm 6061-T6 plate
; Origin: Top face centre of stock, Z=0 at top surface
; Finished thickness: 10mm (machine 2mm off top face first)

; ---- TOOLING LIST ----
; T01 — Ø10mm 2-flute carbide end mill (roughing / profiling)
; T02 — Ø6mm 2-flute carbide end mill (slot features / pockets)
; T03 — Ø4.2mm drill (M5 tapping pilot: 4.2mm; or use T04 for clearance)
; T04 — Ø5.5mm drill (M5 clearance holes — corner fixings)
; T05 — Ø4.3mm drill (M4 clearance holes — HD bolt circle)
; T06 — Ø3.3mm drill (M4 tapping pilot if tapping in-situ)
; T07 — Ø22mm boring bar or Ø22mm end mill spiral (motor pilot bore)
; T08 — Ø30.5mm boring bar (central CSF-17 bore — critical dimension)
; T09 — Ø32mm boring bar H7 (rear bearing pocket)
; T10 — Ø10mm ball-nose end mill (chamfer / deburr)
; T11 — Ø15mm end mill (cable slot)

; ---- CUTTING PARAMETERS — 6061-T6 Aluminium ----
; Spindle speed (RPM) and feed (mm/min) by tool diameter:
;
; T01 Ø10mm:  S=8000,  F=1200,  DOC=3mm,  WOC=5mm  (roughing)
;             S=10000, F=800,   DOC=10mm, WOC=0.3mm (finish pass)
; T02 Ø6mm:   S=12000, F=900,   DOC=2mm,  WOC=3mm
; T03/T04/T05 drills: S=3000–4000, F=150–200 (peck drill, Q=1mm)
; T07 Ø22mm bore: S=3000, F=200, DOC=1mm bore passes
; T08 Ø30.5mm bore: S=2500, F=150 (final pass 0.05mm radial)
; T09 Ø32mm H7:    S=2000, F=120 (final pass 0.02mm radial — verify with bore gauge)

; ---- OPERATION SEQUENCE ----

; OP-01: FACE MILL — Top surface
; Remove 2mm from stock to reach 10mm finished thickness
; Tool: T01
; Strategy: Zigzag face mill, 40% WOC, conventional
G00 Z5.0           ; safe height
G00 X-105 Y-105    ; start position
; [CAM to generate face milling passes across 200×200 area]
; DOC: -2.0mm, WOC: 4mm, F=1200

; OP-02: PROFILE — Outer plate boundary
; Contour the 190×190mm rounded rectangle (8mm corner radius)
; Leave 0.2mm stock for finish pass
; Tool: T01
; Strategy: Conventional (climb on 6061 tends to pull — test your machine)
G00 Z5.0
; Rough pass: offset 0.2mm outside finished profile
; [CAM to generate offset contour of rounded rect]
; Finish pass: on profile, DOC full 10mm, F=800, S=10000

; OP-03: CENTRAL BORE — Ø30.5mm CSF-17 housing
; CRITICAL — this is the primary datum for the harmonic drive
; Tool: T08 (boring bar preferred) or T02 spiral interpolation
; Method: Helical bore interpolation with T02, then bore to size with T08
G00 X0 Y0 Z5.0
; Helical entry: T02, helix radius 9mm, pitch 1mm/rev, to Z-10.5
; [CAM: helical interpolate to Ø29mm]
; Final bore: T08, single-point boring, 0.05mm per pass to Ø30.50mm
; Verify with internal micrometer before releasing part

; OP-04: HD OUTPUT BOLT CIRCLE — 6× Ø4.3mm through holes
; Tool: T05
; Pattern: 6 holes on Ø63mm PCD, starting at 90° (12 o'clock)
G00 X0 Y31.5 Z5.0          ; hole 1 — 0° (top)
G83 Z-11.0 Q1.0 F150 R2.0  ; peck drill cycle
; Repeat for 5 remaining holes at 60° increments:
; X=27.3 Y=15.75 (60°), X=27.3 Y=-15.75 (120°), X=0 Y=-31.5 (180°)
; X=-27.3 Y=-15.75 (240°), X=-27.3 Y=15.75 (300°)
G80  ; cancel canned cycle

; OP-05: MOTOR PILOT BORE — Ø22.1mm NEMA17 centre
; Tool: T07 (boring bar) or T02 interpolation
; Centre at X=+75, Y=0
G00 X75 Y0 Z5.0
; Helical interpolate to Ø21mm with T02
; Bore to Ø22.1mm with boring bar

; OP-06: MOTOR BOLT SLOTS — 4× slotted M4 holes
; Tool: T02 (Ø6mm end mill for slot width 4.3mm — ramp in)
; Pattern: ±15.5mm from motor centre (X=75, Y=0)
; Slots run parallel to X-axis (belt tension direction)
; Slot length: 12mm, width: 4.3mm
; Ramp entry to depth, then slot along X ±6mm from hole centre
; X=75±15.5, Y=±15.5 → slots at:
;   X=[53.5..65.5], Y=+15.5
;   X=[84.5..96.5], Y=+15.5
;   X=[53.5..65.5], Y=-15.5
;   X=[84.5..96.5], Y=-15.5

; OP-07: CORNER MOUNTING HOLES — 4× Ø5.5mm through
; Tool: T04
; Positions: X=±83mm, Y=±83mm (12mm inset from 190mm plate edge / 2)
G00 X-83 Y83 Z5.0
G83 Z-11.0 Q1.0 F180 R2.0
; Repeat: X=83 Y=83, X=83 Y=-83, X=-83 Y=-83
G80

; OP-08: CABLE ROUTING SLOT — 15×12mm at bottom centre
; Tool: T11 (Ø10mm) or T02 multi-pass
; Centre at X=0, Y=-83 (bottom edge inset 12mm, 12mm deep slot)
; Strategy: plunge ramp, slot 7.5mm each side of centre, DOC full

; OP-09: REAR BEARING POCKET — Ø32.05mm H7, depth 9.5mm blind
; FLIP PART — machine from rear face
; Re-datum to rear face Z=0 (plate is now upside down)
; Tool: T09 (boring bar) essential for H7 tolerance
; Centre: X=0, Y=0
G00 X0 Y0 Z5.0
; Rough pocket Ø31mm, depth 9.5mm
; [CAM: circular pocket, DOC 1mm, to Z-9.0]
; Finish bore: T09, single-point, 3 passes to Ø32.05mm
; VERIFY with bore gauge: Ø32.000 to Ø32.025mm (H7)

; OP-10: DEBURR AND CHAMFER
; Tool: T10 (ball-nose) or manual deburring
; All through-hole edges: 0.5mm chamfer × 45°
; Plate edges: 0.5mm chamfer × 45° (or hand deburr)

; ---- INSPECTION CHECKLIST ----
; [ ] Overall plate dimensions: 190 ±0.1mm × 190 ±0.1mm × 10 ±0.1mm
; [ ] Central bore: Ø30.50 +0.1/-0.0mm (check with plug gauge)
; [ ] HD bolt circle: 6× holes on PCD Ø63 ±0.05mm (check with CMM or jig)
; [ ] Motor bore: Ø22.1 ±0.05mm
; [ ] Bearing pocket: Ø32.000–32.025mm (H7), depth 9.5 +0/-0.1mm
; [ ] All M5 clearance holes: Ø5.5 ±0.1mm
; [ ] All M4 clearance holes: Ø4.3 ±0.1mm
; [ ] Slot lengths: 12 ±0.2mm, widths 4.3 ±0.1mm
; [ ] Surface finish: bearing pocket and central bore ≤ 1.6 Ra
; [ ] Deburr: no sharp edges, all through-holes chamfered

; ---- NOTES FOR EXTERNAL MACHINIST ----
; 1. Central bore (OP-03) and bearing pocket (OP-09) are the two
;    critical dimensions. Single-point boring is strongly preferred
;    over spiral end mill interpolation for these features.
; 2. The bearing pocket is on the REAR face — confirm orientation
;    before cutting. Mark front face with a marker before flipping.
; 3. Motor slots must be oriented correctly — slots run radially
;    outward from the plate centre (i.e. parallel to the line
;    joining plate centre to motor centre). See drawing.
; 4. Material is aircraft-grade 6061-T6 — excellent machinability.
;    Flood coolant strongly preferred for bores.
; 5. Supply dimensional report (CMM preferred, or caliper + bore gauge)
;    before releasing part.
