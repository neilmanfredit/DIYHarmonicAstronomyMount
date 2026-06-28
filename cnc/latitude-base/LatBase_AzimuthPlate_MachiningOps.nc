; ============================================================
; HEM-001 — CNC Machining Operations
; Part: Latitude Base — Azimuth Plate (HEM-LAT-001)
; Material: 6061-T6 Aluminium, 290×250×18mm stock (15mm finish)
; Machine: 3-axis VMC
; Units: mm | Coolant: Flood
; Revision: 1.0 | 2026-06
; ============================================================
;
; NOTES FOR MACHINIST:
; This is the LOWER fixed plate of the latitude adjustment base.
; It attaches to the tripod head and provides:
;   - The central 3/8" (M10-equivalent) tripod stud interface
;   - Two azimuth arc slots for fine ±8° AZ adjustment
;   - Hinge bracket attachment points (tapped M8)
;   - Thrust bearing recess on BOTTOM face
;
; The BOTTOM FACE is the datum — machine face-down, flip for top.
; Thrust bearing recess must be concentric with central bore ±0.05mm.

; ---- TOOLING ----
; T01 — Ø12mm 3-flute end mill
; T02 — Ø8mm 2-flute end mill
; T03 — Ø6mm 2-flute end mill (arc slots)
; T04 — Ø10.5mm drill (central tripod bore)
; T05 — Ø8.5mm drill (M8 tripod leg adapter holes)
; T06 — Ø6.75mm drill then M8 tap (hinge bracket tapped holes)
; T07 — Ø6.5mm end mill (AZ arc slots — circular interpolation)
; T08 — Ø17mm boring bar (thrust bearing recess — H7)

; ---- OPERATION SEQUENCE ----

; OP-01: FACE MILL — Bottom face (datum)
; Machine bottom face flat. This is the primary datum.
; Tool: T01

; OP-02: THRUST BEARING RECESS — Bottom face, blind 5.5mm
; F8-16M bearing: OD=16mm, bore at 17mm (H7 fit: +0.018/0)
; Concentric with central bore
; Tool: T08 (boring bar essential for H7)
G00 X0 Y0 Z5.0
; [Bore Ø17.000–17.018mm, depth 5.5mm blind from bottom face]

; OP-03: CENTRAL BORE — 3/8" tripod stud (Ø10.5mm through)
; Tool: T04
G00 X0 Y0 Z5.0
G83 Z-16.5 Q1.5 F180 R2.0
G80

; OP-04: FLIP — Machine top face
; Re-datum to top face. Machine 18mm stock to 15mm finished (remove 3mm).

; OP-05: FACE MILL — Top surface
; Tool: T01

; OP-06: PROFILE — Outer boundary 280 × 240mm (r=12mm corners)
; Tool: T01 rough + finish

; OP-07: AZIMUTH ARC SLOTS — 2× (front and rear arcs)
; Arc radius: 110mm from plate centre
; Arc span: ±8° (16° total)
; Slot width: 6.5mm (M6 clearance)
; Method: circular interpolation with T07 Ø6.5mm end mill
;   Front arc: G02/G03 at R110mm, from -8° to +8°, Y positive
;   Rear arc:  mirror at Y negative
; Helical ramp entry to full depth, then circular passes
G00 X0 Y110 Z5.0   ; arc centre at plate centre, entry at 0° = Y+
; [CAM: circular arc slot, R=110, ±8° sweep, Y+ and Y-, through 15mm]

; OP-08: TRIPOD LEG ADAPTER HOLES — 3× Ø8.5mm through (120° spacing, 90mm PCD)
; First hole at 60° from +Y axis
G00 X77.94 Y45 Z5.0    ; 60° from Y+: X=90*sin(60), Y=90*cos(60)
G83 Z-16.0 Q1.5 F180 R2.0
G00 X0 Y-90              ; 180° from Y+ (straight back)
G83 Z-16.0 Q1.5 F180 R2.0
G00 X-77.94 Y45          ; 300°
G83 Z-16.0 Q1.5 F180 R2.0
G80

; OP-09: HINGE BRACKET TAPPED HOLES — 2× M8 (TAPPED, not clearance)
; Positions: X=±100mm, Y=-95mm (front edge side — where hinge brackets attach)
; Tool: T06 drill then hand tap M8 × 1.25
G00 X-100 Y-95 Z5.0
G83 Z-20.0 Q1.5 F150 R2.0   ; drill Ø6.75mm
G00 X100 Y-95
G83 Z-20.0 Q1.5 F150 R2.0
G80
; Hand tap M8 × 1.25 at both holes, depth 18mm minimum

; OP-10: MATERIAL RELIEF POCKETS — 2× hexagonal (weight saving)
; Tool: T02, hex pocket, 8mm deep blind from top
; Centres: X=±85mm, Y=+30mm
; [CAM: hex pockets at specified positions]

; OP-11: BUBBLE LEVEL RECESS — Ø29mm, 5mm deep blind (top face)
; Position: X=+115mm, Y=+95mm (front-right corner area)
; Tool: T02 circular pocket
G00 X115 Y95 Z5.0
; [CAM: circular pocket Ø29mm, depth 5mm blind]

; ---- INSPECTION ----
; [ ] Plate flatness: ≤0.05mm (datum face)
; [ ] Thickness: 15.00 ±0.05mm
; [ ] Central bore: Ø10.5 ±0.1mm, perpendicular to bottom face ±0.05mm
; [ ] Thrust bearing recess: Ø17.000–17.018mm (H7), depth 5.5 ±0.05mm
;     Concentricity to central bore: ≤0.03mm TIR
; [ ] AZ arc slots: radius 110 ±0.1mm, slot width 6.5 ±0.1mm, through
; [ ] Hinge bracket holes: M8 × 1.25, depth ≥18mm, perpendicular ±0.1mm
; [ ] All drilled holes: ±0.1mm position
; [ ] Deburr all edges; chamfer 0.5mm on through-hole exits
