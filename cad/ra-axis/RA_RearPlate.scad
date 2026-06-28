// ============================================================
// HEM-001 — RA Axis: REAR PLATE / BEARING CARRIER
// The rear plate of the RA housing. Contains the main RA output
// shaft bearing and the electromagnetic brake mount.
// Material: 6061-T6 Aluminium, 10mm thick
// Part No: HEM-RA-002
// Revision: 1.0 | 2026-06
// ============================================================
//
// FUNCTION:
// This plate bolts to the rear face of the RA housing assembly.
// It carries the second RA shaft bearing (6002-2RS) and provides
// the mounting boss for the electromagnetic fail-safe brake.
// The brake mounts on the rear motor shaft (motor shaft protrudes
// rearward — dual-shaft NEMA17 recommended).
//
// BRAKE BOSS GEOMETRY:
// The NC electromagnetic brake body is typically Ø22mm.
// A 4× M3 bolt circle (18mm PCD) secures it to this plate.
// The motor shaft passes through the central bore (Ø5.5mm clearance).
// ============================================================

// ---- PARAMETERS ----
PLATE_W      = 190;
PLATE_H      = 190;
PLATE_T      = 10;

// RA Output shaft bearing pocket (6002-2RS front: OD=32, matched to front plate rear)
// This plate has a THROUGH bore (shaft passes through)
SHAFT_BORE   = 10.5;   // mm — Ø10mm shaft, 0.5mm clearance

// Bearing pocket (6002-2RS: OD=32mm, W=9mm) — FRONT face of this plate
BEARING_OD   = 32.05;  // mm — H7 pocket
BEARING_DEPTH = 9.5;   // mm — blind pocket from front face

// Electromagnetic brake mount
BRAKE_BODY_D = 22.5;   // mm — brake body clearance bore
BRAKE_PCD    = 18;     // mm — brake bolt circle
BRAKE_BOLT_D = 3.4;    // mm — M3 clearance, 4 holes at 90°

// Motor mount through-holes (matches front plate pattern — for long bolts
// that tie front and rear plates together as a housing)
MOTOR_OFFSET_X = 75;   // mm — same as front plate
MOTOR_BOLT_PCD = 31;
HOUSING_BOLT_D = 4.3;  // mm — M4 clearance (long M4 tie bolts)

// Corner mounting holes
CORNER_INSET = 12;
CORNER_BOLT  = 5.5;    // M5 clearance

// ---- GEOMETRY ----
module ra_rear_plate() {
    difference() {
        hull() {
            for (x = [-PLATE_W/2 + 8, PLATE_W/2 - 8])
                for (y = [-PLATE_H/2 + 8, PLATE_H/2 - 8])
                    translate([x, y, 0]) cylinder(r=8, h=PLATE_T, $fn=32);
        }

        // ---- RA OUTPUT SHAFT BORE (central through) ----
        translate([0, 0, -0.5])
            cylinder(d=SHAFT_BORE, h=PLATE_T+1, $fn=32);

        // ---- BEARING POCKET (front face — blind) ----
        translate([0, 0, -0.5])
            cylinder(d=BEARING_OD, h=BEARING_DEPTH+0.5, $fn=64);

        // ---- BRAKE BODY CLEARANCE (motor side, rear face — blind 3mm) ----
        translate([MOTOR_OFFSET_X, 0, PLATE_T - 3])
            cylinder(d=BRAKE_BODY_D, h=3.5, $fn=48);

        // ---- BRAKE BOLT CIRCLE (4× M3 at 90°) ----
        for (a = [0, 90, 180, 270]) {
            translate([
                MOTOR_OFFSET_X + cos(a)*BRAKE_PCD/2,
                sin(a)*BRAKE_PCD/2,
                -0.5
            ])
                cylinder(d=BRAKE_BOLT_D, h=PLATE_T+1, $fn=20);
        }

        // ---- MOTOR SHAFT BORE (through at motor position) ----
        translate([MOTOR_OFFSET_X, 0, -0.5])
            cylinder(d=5.5, h=PLATE_T+1, $fn=24);

        // ---- HOUSING TIE BOLTS (4× M4 — front-to-rear plate tie) ----
        for (sign_x = [-1, 1], sign_y = [-1, 1]) {
            translate([
                MOTOR_OFFSET_X + sign_x*MOTOR_BOLT_PCD/2,
                sign_y*MOTOR_BOLT_PCD/2,
                -0.5
            ])
                cylinder(d=HOUSING_BOLT_D, h=PLATE_T+1, $fn=20);
        }

        // ---- CORNER MOUNTING HOLES (4× M5) ----
        for (x = [-PLATE_W/2 + CORNER_INSET, PLATE_W/2 - CORNER_INSET])
            for (y = [-PLATE_H/2 + CORNER_INSET, PLATE_H/2 - CORNER_INSET])
                translate([x, y, -0.5])
                    cylinder(d=CORNER_BOLT, h=PLATE_T+1, $fn=24);
    }
}

ra_rear_plate();
