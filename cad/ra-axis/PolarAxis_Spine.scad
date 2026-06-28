// ============================================================
// Harmonic EQ Mount — Polar Axis Spine / Body
// Material: 6061-T6 Aluminium, 10mm thick
// Function: Main structural backbone. RA housing plate bolts
//           to front. Tripod/AZ head bolts to bottom.
//           Altitude adjustment mechanism integrated.
// Author: Neil Manfred | Revision: 1.0 | 2026-06
// ============================================================
//
// DESIGN OVERVIEW:
// The polar axis spine is an L-shaped or wedge-profile plate.
// The RA axis is horizontal, set at the observer's latitude
// by an altitude adjuster (slotted arc).
// This file produces the MAIN BODY — a flat plate with:
//   - RA plate attachment holes (front face, 4× M5)
//   - Tripod attachment holes (bottom, 3/8"-16 threaded insert)
//   - Altitude adjustment arc slot (±20° travel from centre)
//   - Azimuth adjustment slots (±5° travel)
//   - Counterweight shaft boss hole (M12 thread insert, bottom)
// ============================================================

// ---- PARAMETERS ----

SPINE_W    = 120;    // mm — body width
SPINE_H    = 220;    // mm — body height
SPINE_T    = 10;     // mm — thickness

// RA plate attachment (matches RA_FrontPlate.scad corner holes)
// 4× M5 bolts on 166mm × 166mm pattern (190mm plate, 12mm inset each side)
RA_ATTACH_X = 83;   // half-spacing X
RA_ATTACH_Y = 83;   // half-spacing Y
RA_BOLT     = 5.0;  // M5 tapping pilot (4.2mm) or clearance (5.5mm)
// NOTE: Set to 5.0 for clearance; change to 4.2 for tapping if spine is the threaded side

// Altitude arc slot
// Centred at the bottom of the plate; arc allows polar altitude adjustment
ARC_RADIUS  = 60;   // mm — radius of adjustment arc
ARC_ANGLE   = 20;   // ±degrees either side of centre
ARC_WIDTH   = 6.5;  // mm — slot width for M6 bolt

// Tripod mount (bottom — 3/8"-16 UNC insert, or 10mm clearance for bolt)
TRIPOD_BORE = 10.0; // mm — 3/8" UNC = 9.53mm bore; use 10mm for bronze insert
TRIPOD_X    = 0;
TRIPOD_Y    = -SPINE_H/2 + 20;

// Counterweight shaft (Ø12mm through + M12 insert for threaded rod)
CW_BORE     = 12.5;
CW_X        = 0;
CW_Y        = -SPINE_H/2 + 50;

// Corner lightening pockets (optional — saves ~15% material)
POCKET_R    = 20;

// ---- GEOMETRY ----

module polar_spine() {
    difference() {
        // Main body (rounded rect)
        hull() {
            for (x = [-SPINE_W/2 + 10, SPINE_W/2 - 10])
                for (y = [-SPINE_H/2 + 10, SPINE_H/2 - 10])
                    translate([x, y, 0]) cylinder(r=10, h=SPINE_T, $fn=32);
        }

        // ---- RA PLATE ATTACHMENT (4× M5) ----
        for (x = [-RA_ATTACH_X/2, RA_ATTACH_X/2])
            for (y = [SPINE_H/2 - 30, SPINE_H/2 - 30 - RA_ATTACH_Y])
                translate([x, y, -0.5])
                    cylinder(d=RA_BOLT, h=SPINE_T+1, $fn=24);

        // ---- ALTITUDE ADJUSTMENT ARC SLOT ----
        // Slot centred at (0, -ARC_RADIUS) from plate centre
        // Arc sweeps ±ARC_ANGLE degrees
        for (a = [-ARC_ANGLE : 2 : ARC_ANGLE]) {
            translate([
                sin(a) * ARC_RADIUS,
                -SPINE_H/4 + cos(a) * ARC_RADIUS - ARC_RADIUS,
                -0.5
            ])
                cylinder(d=ARC_WIDTH, h=SPINE_T+1, $fn=20);
        }

        // ---- TRIPOD MOUNT (bottom centre) ----
        translate([TRIPOD_X, TRIPOD_Y, -0.5])
            cylinder(d=TRIPOD_BORE, h=SPINE_T+1, $fn=32);

        // ---- COUNTERWEIGHT SHAFT BOSS ----
        translate([CW_X, CW_Y, -0.5])
            cylinder(d=CW_BORE, h=SPINE_T+1, $fn=32);

        // ---- MATERIAL RELIEF POCKETS (2× triangular corners top) ----
        // These reduce material without losing structural stiffness
        translate([-SPINE_W/2 + 5, SPINE_H/2 - 5 - POCKET_R*1.5, -0.5])
            cylinder(r=POCKET_R, h=SPINE_T+1, $fn=6);
        translate([SPINE_W/2 - 5, SPINE_H/2 - 5 - POCKET_R*1.5, -0.5])
            cylinder(r=POCKET_R, h=SPINE_T+1, $fn=6);

        // ---- AZIMUTH ADJUSTMENT SLOTS (2× bottom, horizontal) ----
        // Allows fine AZ trim ±5°
        for (sign = [-1, 1]) {
            translate([sign * 25, TRIPOD_Y + 25, -0.5])
            hull() {
                cylinder(d=5.5, h=SPINE_T+1, $fn=20);
                translate([sign * 8, 0, 0])
                    cylinder(d=5.5, h=SPINE_T+1, $fn=20);
            }
        }
    }
}

polar_spine();
