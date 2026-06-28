// ============================================================
// Harmonic EQ Mount — RA Axis Housing Plate (FRONT)
// Material: 6061-T6 Aluminium, 10mm thick
// Fits: CSF-17-100-2A-R Harmonic Drive (or equivalent clone)
// Author: Neil Manfred — DIY Harmonic EQ Mount Project
// Revision: 1.0 | 2026-06
// ============================================================
//
// MANUFACTURING NOTES:
// - Machine from 200 x 200 x 10mm 6061-T6 aluminium plate
// - All holes through unless marked as blind
// - Tolerances: general ±0.1mm, bearing bores H7 (+0.018/0)
// - Surface finish: 1.6 Ra on bearing bores, 3.2 Ra elsewhere
// - Deburr all edges, break corners 0.5mm chamfer
// - Anodise or leave natural (apply Boeshield T9 before storage)
//
// CSF-17 KEY DIMENSIONS (verified from Harmonic Drive datasheet):
//   Output flange OD: 79mm
//   Output flange bolt circle: Ø63mm, 6× M4 holes on 60°
//   Input (wave generator) bore: Ø30mm housing bore
//   Unit overall thickness: ~47mm
//   Central bore through-hole: Ø21mm (allows polar scope / cable routing)
// ============================================================

// ---- PARAMETERS (edit here) ----

// Plate overall dimensions
PLATE_W      = 190;   // mm — plate width
PLATE_H      = 190;   // mm — plate height
PLATE_T      = 10;    // mm — plate thickness (material)

// Central bore (for harmonic drive housing + polar scope pass-through)
CENTRAL_BORE = 30.5;  // mm — slip fit for CSF-17 housing boss (30mm nominal, +0.5 clearance)

// Harmonic Drive output flange bolt circle
HD_BOLT_PCD  = 63;    // mm — pitch circle diameter
HD_BOLT_QTY  = 6;     // number of bolts
HD_BOLT_DIA  = 4.3;   // mm — clearance hole for M4 bolt (M4 = Ø4.2 clearance / Ø3.3 tapping)

// Motor mount slots (for belt tension adjustment — 4× M4)
// Motor sits approx 75mm off-centre from harmonic axis
MOTOR_CL_X   = 75;   // mm — motor centreline offset X
MOTOR_CL_Y   = 0;    // mm — motor centreline offset Y (inline horizontally)
MOTOR_SLOT_L = 12;   // mm — slot length for belt tension travel
MOTOR_BOLT_PCD = 31; // mm — NEMA 17 bolt circle (31mm square)
MOTOR_BORE   = 22.1; // mm — NEMA 17 pilot bore clearance (22mm nominal)

// Bearing pocket (rear — for RA output shaft support bearing)
// Using 6002-2RS: OD=32mm, ID=15mm, Width=9mm
BEARING_OD   = 32.05; // mm — H7 pocket (32 +0.025/0)
BEARING_DEPTH = 9.5;  // mm — bearing pocket depth (blind, 9.5mm into 10mm plate)

// Corner mounting holes (for attachment to polar axis body)
CORNER_INSET = 12;    // mm — from plate edge
CORNER_BOLT  = 5.5;   // mm — M5 clearance hole

// ---- GEOMETRY ----

module ra_front_plate() {
    difference() {
        // Base plate with rounded corners
        hull() {
            for (x = [-PLATE_W/2 + 8, PLATE_W/2 - 8])
                for (y = [-PLATE_H/2 + 8, PLATE_H/2 - 8])
                    translate([x, y, 0]) cylinder(r=8, h=PLATE_T, $fn=32);
        }

        // ---- CENTRAL BORE (harmonic housing / polar scope) ----
        translate([0, 0, -0.5])
            cylinder(d=CENTRAL_BORE, h=PLATE_T+1, $fn=64);

        // ---- HARMONIC DRIVE OUTPUT FLANGE BOLT CIRCLE (6× M4) ----
        for (i = [0:HD_BOLT_QTY-1]) {
            angle = i * (360 / HD_BOLT_QTY);
            translate([
                cos(angle) * HD_BOLT_PCD/2,
                sin(angle) * HD_BOLT_PCD/2,
                -0.5
            ])
                cylinder(d=HD_BOLT_DIA, h=PLATE_T+1, $fn=24);
        }

        // ---- MOTOR MOUNT (NEMA 17 — 4 slotted holes) ----
        // Slots oriented radially for belt tension adjustment
        for (sign_x = [-1, 1], sign_y = [-1, 1]) {
            translate([
                MOTOR_CL_X + sign_x * MOTOR_BOLT_PCD/2,
                MOTOR_CL_Y + sign_y * MOTOR_BOLT_PCD/2,
                -0.5
            ])
            hull() {
                cylinder(d=4.3, h=PLATE_T+1, $fn=24);
                translate([MOTOR_SLOT_L * (sign_x > 0 ? 1 : -1) * 0.5, 0, 0])
                    cylinder(d=4.3, h=PLATE_T+1, $fn=24);
            }
        }

        // Motor pilot bore (NEMA 17 centre boss clearance)
        translate([MOTOR_CL_X, MOTOR_CL_Y, -0.5])
            cylinder(d=MOTOR_BORE, h=PLATE_T+1, $fn=48);

        // ---- REAR BEARING POCKET (blind — output shaft support) ----
        // Pocket on REAR face: translate to -Z
        translate([0, 0, PLATE_T - BEARING_DEPTH])
            cylinder(d=BEARING_OD, h=BEARING_DEPTH+0.5, $fn=64);

        // ---- CORNER MOUNTING HOLES (4× M5 clearance) ----
        for (x = [-PLATE_W/2 + CORNER_INSET, PLATE_W/2 - CORNER_INSET])
            for (y = [-PLATE_H/2 + CORNER_INSET, PLATE_H/2 - CORNER_INSET])
                translate([x, y, -0.5])
                    cylinder(d=CORNER_BOLT, h=PLATE_T+1, $fn=24);

        // ---- CABLE ROUTING RELIEF (optional — 15mm slot at bottom) ----
        translate([-7.5, -PLATE_H/2, -0.5])
            cube([15, 12, PLATE_T+1]);
    }
}

// ---- RENDER ----
ra_front_plate();

// ============================================================
// ANNOTATION / INSPECTION REFERENCE
// Uncomment the following to overlay dimension markers in preview:
//
// translate([0,0,11]) color("red") cylinder(d=HD_BOLT_PCD, h=0.5, $fn=60); // HD bolt circle
// translate([MOTOR_CL_X, MOTOR_CL_Y, 11]) color("blue") cylinder(d=MOTOR_BORE, h=0.5, $fn=48); // motor bore
// ============================================================
