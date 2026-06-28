; ============================================================
; HEM-001 — CNC Machining Operations
; Part: Latitude Base — Altitude Plate (HEM-LAT-002)
; Material: 6061-T6 Aluminium, 290×240×18mm stock (15mm finish)
; Machine: 3-axis vertical machining centre
; Units: mm | Coolant: Flood or mist
; Revision: 1.0 | 2026-06
; ============================================================
;
; NOTES FOR MACHINIST:
; This is the UPPER tilting plate of the latitude adjustment base.
; It hinges at its rear edge (Y-max) and is driven at its front
; edge (Y-min) by a tangent arm lead screw.
; The plate must be FLAT to within 0.05mm across its full face —
; this is the datum for the entire mount's polar alignment accuracy.
;
; Send with:
;   1. LatBase_AltitudePlate.scad (CAD geometry)
;   2. This file (machining intent)
;
; ---- TOOLING ----
; T01 — Ø12mm 3-flute carbide end mill (face + profile)
; T02 — Ø8mm 2-flute carbide end mill (pockets + slots)
; T03 — Ø6mm 2-flute (CW shaft slot + cable hole)
; T04 — Ø5.3mm drill (M5 clearance for spine bolts — later opened to M6.5 if needed)
; T05 — Ø6.5mm drill (M6 clearance holes — spine attachment)
; T06 — Ø8.2mm drill (M8 clearance — hinge pivot holes)
; T07 — Ø6.75mm drill (M8 tapping pilot — tangent arm socket)
; T08 — M8 hand tap (tangent arm socket — tap after drilling)
; T09 — Ø20mm end mill or boring bar (cable management hole)
; T10 — Ø12mm ball-nose (lightening pocket floor cleanup)

; ---- CUTTING PARAMETERS — 6061-T6 ----
; T01 Ø12mm:  S=7000,  F=1400,  DOC=3mm rough / 15mm finish (light WOC)
; T02 Ø8mm:   S=10000, F=1100,  DOC=2mm,  WOC=4mm
; T03 Ø6mm:   S=13000, F=900,   DOC=1.5mm
; Drills:     S=3000–4000, F=150–200, peck Q=1.5mm

; ---- OPERATION SEQUENCE ----

; OP-01: FACE MILL — Top surface
; Stock 18mm → finished 15mm (remove 3mm)
; Tool: T01, zigzag pattern, 40% stepover

; OP-02: PROFILE — Outer plate boundary
; 260 × 220mm rounded rectangle (10mm corner radius)
; Rough (0.3mm stock) + finish pass
; Tool: T01

; OP-03: HINGE PIVOT HOLES — 2× Ø8.2mm through
; Rear edge (Y = +105mm from centre), X = ±100mm
; Tool: T06 (peck drill)
G00 X-100 Y105 Z5.0
G83 Z-16.0 Q1.5 F180 R2.0
G00 X100 Y105
G83 Z-16.0 Q1.5 F180 R2.0
G80

; OP-04: TANGENT ARM SOCKET — Ø6.75mm blind, depth 20mm (BOTTOM FACE)
; FLIP PART for this operation OR machine from bottom if fixturing allows
; Position: X=0, Y=-80mm (front edge inset 30mm)
; Tool: T07 then T08 (tap M8 × 1.25)
G00 X0 Y-80 Z5.0
G83 Z-21.0 Q1.5 F150 R2.0   ; drill
G80
; Hand tap M8 × 1.25 after removing from machine — 20mm depth

; OP-05: SPINE ATTACHMENT HOLES — 4× Ø6.5mm through
; Positions: X=±55mm, Y=+75mm and Y=-65mm
; Tool: T05
G00 X-55 Y75 Z5.0
G83 Z-16.0 Q1.5 F180 R2.0
G00 X55 Y75
G83 Z-16.0 Q1.5 F180 R2.0
G00 X-55 Y-65
G83 Z-16.0 Q1.5 F180 R2.0
G00 X55 Y-65
G83 Z-16.0 Q1.5 F180 R2.0
G80

; OP-06: COUNTERWEIGHT SHAFT SLOT — 52 × 65mm through
; Centre: X=0, Y=-70mm (near front edge — allows CW shaft swing-through)
; Tool: T02 (roughing pocket, multiple passes), T03 (corner cleanup)
; [CAM: rectangular pocket 52×65mm, centre at X=0 Y=-70, through]

; OP-07: LATITUDE SCALE WINDOW — 15 × 20mm through
; Centre: X=0, Y=-102mm (front edge, centred)
; Tool: T03
G00 X0 Y-102 Z5.0
; [CAM: rectangular slot 15×20mm centred at X=0 Y=-102, through]

; OP-08: CABLE MANAGEMENT HOLE — Ø20mm through
; Position: X=0, Y=+50mm
; Tool: T09
G00 X0 Y50 Z5.0
G83 Z-16.0 Q2.0 F150 R2.0
G80

; OP-09: LIGHTENING POCKETS — 2× hexagonal, 8mm deep blind (TOP FACE)
; Centred at X=±80mm, Y=+20mm, inradius=40mm, depth=8mm
; Tool: T02 (helical entry, pocket strategy)
; [CAM: hex pocket at X=-80 Y=20 depth 8mm, and X=80 Y=20 depth 8mm]

; OP-10: CHAMFER ALL THROUGH-HOLE EDGES — 0.5mm × 45°
; Tool: T10 or hand deburr

; ---- INSPECTION ----
; [ ] Plate flatness: ≤0.05mm over full 260×220mm face (critical datum)
; [ ] Thickness: 15.00 ±0.05mm (measure 5 points across face)
; [ ] Hinge pivot holes: Ø8.2 ±0.05mm, parallel to top face within 0.05mm
;     (misaligned pivot holes cause binding under load)
; [ ] Hinge hole spacing: 200.0 ±0.1mm centre-to-centre
; [ ] Spine bolt holes: 110mm × 140mm rectangle, ±0.1mm
; [ ] Tangent arm socket: M8 thread, 18–20mm depth, perpendicular to BOTTOM face

; ---- NOTES ----
; 1. Flatness is the most critical spec on this plate — it directly
;    affects polar alignment accuracy. A warped altitude plate means
;    the polar axis is never truly straight, and drift alignment
;    corrections won't converge.
; 2. The lightening pockets are cosmetic / weight-saving. Omit if
;    your machinist charges by the operation and you're on a budget.
; 3. Anodise recommended — the altitude plate gets handled regularly
;    during setup and natural aluminium scratches easily.
