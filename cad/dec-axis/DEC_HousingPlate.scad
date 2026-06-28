// ============================================================
// Harmonic EQ Mount — DEC Axis Housing Plate
// Material: 6061-T6 Aluminium, 10mm thick
// Fits: CSF-14-100-2A-R Harmonic Drive (or equivalent clone)
// Author: Neil Manfred — DIY Harmonic EQ Mount Project
// Revision: 1.0 | 2026-06
// ============================================================
//
// CSF-14 KEY DIMENSIONS (from Harmonic Drive datasheet):
//   Output flange OD: 63mm
//   Output flange bolt circle: Ø50mm, 6× M3 holes on 60°
//   Wave generator housing bore: Ø24mm
//   Unit overall thickness: ~39mm
//   Central through-bore: Ø17mm minimum
// ============================================================

// ---- PARAMETERS ----

PLATE_W      = 160;
PLATE_H      = 160;
PLATE_T      = 10;

CENTRAL_BORE = 24.5;  // CSF-14 housing boss slip fit

// DEC harmonic output bolt circle
HD_BOLT_PCD  = 50;
HD_BOLT_QTY  = 6;
HD_BOLT_DIA  = 3.4;   // M3 clearance

// Motor mount — NEMA17 (same as RA)
MOTOR_CL_X   = 60;
MOTOR_CL_Y   = 0;
MOTOR_SLOT_L = 10;
MOTOR_BOLT_PCD = 31;
MOTOR_BORE   = 22.1;

// Bearing pocket — 6000-2RS: OD=26mm, ID=10mm, W=8mm
BEARING_OD   = 26.05;
BEARING_DEPTH = 8.5;

// Vixen saddle mounting holes (4× M6 — 60mm × 40mm pattern)
SADDLE_HOLE_X = 30;  // half-spacing X
SADDLE_HOLE_Y = 20;  // half-spacing Y
SADDLE_BOLT   = 6.5; // M6 clearance

CORNER_INSET = 10;
CORNER_BOLT  = 5.5;

// ---- GEOMETRY ----

module dec_housing_plate() {
    difference() {
        // Base plate
        hull() {
            for (x = [-PLATE_W/2 + 8, PLATE_W/2 - 8])
                for (y = [-PLATE_H/2 + 8, PLATE_H/2 - 8])
                    translate([x, y, 0]) cylinder(r=8, h=PLATE_T, $fn=32);
        }

        // Central bore
        translate([0, 0, -0.5])
            cylinder(d=CENTRAL_BORE, h=PLATE_T+1, $fn=64);

        // HD output flange bolt circle (6× M3)
        for (i = [0:HD_BOLT_QTY-1]) {
            angle = i * 60;
            translate([
                cos(angle) * HD_BOLT_PCD/2,
                sin(angle) * HD_BOLT_PCD/2,
                -0.5
            ])
                cylinder(d=HD_BOLT_DIA, h=PLATE_T+1, $fn=24);
        }

        // Motor mount slots (NEMA 17)
        for (sign_x = [-1, 1], sign_y = [-1, 1]) {
            translate([
                MOTOR_CL_X + sign_x * MOTOR_BOLT_PCD/2,
                MOTOR_CL_Y + sign_y * MOTOR_BOLT_PCD/2,
                -0.5
            ])
            hull() {
                cylinder(d=3.4, h=PLATE_T+1, $fn=24);
                translate([MOTOR_SLOT_L * (sign_x > 0 ? 1 : -1) * 0.4, 0, 0])
                    cylinder(d=3.4, h=PLATE_T+1, $fn=24);
            }
        }
        translate([MOTOR_CL_X, MOTOR_CL_Y, -0.5])
            cylinder(d=MOTOR_BORE, h=PLATE_T+1, $fn=48);

        // Bearing pocket (rear face)
        translate([0, 0, PLATE_T - BEARING_DEPTH])
            cylinder(d=BEARING_OD, h=BEARING_DEPTH+0.5, $fn=64);

        // Vixen saddle mounting holes (4× M6)
        for (x = [-SADDLE_HOLE_X, SADDLE_HOLE_X])
            for (y = [-SADDLE_HOLE_Y, SADDLE_HOLE_Y])
                translate([x, y, -0.5])
                    cylinder(d=SADDLE_BOLT, h=PLATE_T+1, $fn=24);

        // Corner mounting holes (4× M5)
        for (x = [-PLATE_W/2 + CORNER_INSET, PLATE_W/2 - CORNER_INSET])
            for (y = [-PLATE_H/2 + CORNER_INSET, PLATE_H/2 - CORNER_INSET])
                translate([x, y, -0.5])
                    cylinder(d=CORNER_BOLT, h=PLATE_T+1, $fn=24);
    }
}

dec_housing_plate();
