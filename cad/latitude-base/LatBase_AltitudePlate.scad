// ============================================================
// HEM-001 — Latitude Adjustment Base: ALTITUDE PLATE
// The upper tilting plate. The RA polar spine bolts to the
// top face of this plate. Tilts on hinge pivot to set latitude.
// Material: 6061-T6 Aluminium, 15mm thick
// Part No: HEM-LAT-002
// Revision: 1.0 | 2026-06
// ============================================================
//
// FUNCTION:
// This plate is hinged at its REAR edge (south side) to the
// azimuth plate hinge brackets. The FRONT edge is raised by
// a tangent arm / lead screw drive to set the tilt angle
// (latitude). Range: 0–70° (covers all UK latitudes and most
// of the world).
//
// Latitude for Stockport: 53.41° — set once, lock, leave.
//
// FEATURES:
// - Hinge pivot holes (rear edge, 2× M8 pivot bolts, 200mm apart)
// - Tangent arm socket (front underside — M8 tapped boss)
// - RA polar spine attachment holes (top face, 4× M6, matching spine)
// - Counterweight shaft clearance (Ø25mm slot — CW swings through)
// - Latitude scale window (10mm wide slot at front edge — scale visible
//   through window from outside)
// - Lightening pockets (top face — saves ~20% material)
//
// TANGENT ARM GEOMETRY:
// The tangent arm mechanism converts linear motion (M8 lead screw)
// into angular tilt. For a 100mm pivot-to-contact length:
//   θ = arctan(L / 100)   where L is lead screw extension
//   At 53°: L = 100 × tan(53.41°) = 134.6mm
//   1mm of screw movement ≈ 0.57° at 53° (coarser near vertical,
//   finer near horizontal — adequate for field setup)
// ============================================================

// ---- PARAMETERS ----
PLATE_W         = 260;    // mm — plate width
PLATE_D         = 220;    // mm — plate depth (front-back)
PLATE_T         = 15;     // mm — thickness

// Hinge pivot holes (rear edge — pivots are M8 bolts through hinge brackets)
HINGE_SPACING   = 200;    // mm — matches azimuth plate
HINGE_INSET_Y   = 15;     // mm — inset from rear edge
HINGE_BORE      = 8.2;    // mm — M8 clearance

// Tangent arm socket (front underside — M8 tapped, vertical)
TANGENT_X       = 0;      // centred
TANGENT_INSET_Y = 30;     // mm inset from front edge
TANGENT_BORE    = 6.8;    // mm — M8 tapping pilot (6.75mm)

// RA polar spine attachment (top face — 4× M6, matching PolarAxis_Spine.scad)
// Spine is 120mm wide, mounting holes at ±55mm X, inset from rear
SPINE_HOLE_X    = 55;     // mm — half spacing X
SPINE_HOLE_Y1   = PLATE_D/2 - 30;   // rear pair
SPINE_HOLE_Y2   = PLATE_D/2 - 30 - 140; // front pair (140mm spine hole spacing)
SPINE_BOLT      = 6.5;    // mm — M6 clearance (spine has M6 clearance too)

// Counterweight shaft clearance
// CW shaft swings through when slewing — needs ~50mm wide × 60mm deep slot
CW_SLOT_W       = 52;
CW_SLOT_D       = 65;
CW_SLOT_X       = 0;      // centred
CW_SLOT_Y       = -PLATE_D/2 + CW_SLOT_D/2 + 10; // near front edge

// Latitude scale window (front edge, centred)
LAT_WINDOW_W    = 15;
LAT_WINDOW_H    = 20;
LAT_WINDOW_Y    = -PLATE_D/2 + 8;  // front edge

// Corner radius
CR = 10;

// ---- GEOMETRY ----

module alt_plate() {
    difference() {
        // Base plate
        hull() {
            for (x = [-PLATE_W/2 + CR, PLATE_W/2 - CR])
                for (y = [-PLATE_D/2 + CR, PLATE_D/2 - CR])
                    translate([x, y, 0]) cylinder(r=CR, h=PLATE_T, $fn=32);
        }

        // ---- HINGE PIVOT HOLES (rear edge) ----
        translate([-HINGE_SPACING/2, PLATE_D/2 - HINGE_INSET_Y, -0.5])
            cylinder(d=HINGE_BORE, h=PLATE_T+1, $fn=24);
        translate([HINGE_SPACING/2, PLATE_D/2 - HINGE_INSET_Y, -0.5])
            cylinder(d=HINGE_BORE, h=PLATE_T+1, $fn=24);

        // ---- TANGENT ARM SOCKET (front underside — tapped M8) ----
        // Blind hole from BOTTOM face, depth 20mm
        translate([TANGENT_X, -PLATE_D/2 + TANGENT_INSET_Y, -0.5])
            cylinder(d=TANGENT_BORE, h=20+0.5, $fn=24);

        // ---- RA POLAR SPINE ATTACHMENT (top face, 4× M6 clearance) ----
        for (sign = [-1, 1]) {
            translate([sign*SPINE_HOLE_X, SPINE_HOLE_Y1, -0.5])
                cylinder(d=SPINE_BOLT, h=PLATE_T+1, $fn=24);
            translate([sign*SPINE_HOLE_X, SPINE_HOLE_Y2, -0.5])
                cylinder(d=SPINE_BOLT, h=PLATE_T+1, $fn=24);
        }

        // ---- COUNTERWEIGHT SHAFT CLEARANCE SLOT ----
        translate([CW_SLOT_X - CW_SLOT_W/2, CW_SLOT_Y - CW_SLOT_D/2, -0.5])
            cube([CW_SLOT_W, CW_SLOT_D, PLATE_T+1]);

        // ---- LATITUDE SCALE WINDOW (front edge) ----
        translate([-LAT_WINDOW_W/2, LAT_WINDOW_Y - LAT_WINDOW_H/2, -0.5])
            cube([LAT_WINDOW_W, LAT_WINDOW_H, PLATE_T+1]);

        // ---- LIGHTENING POCKETS (top face — 2 pockets either side) ----
        for (sign = [-1, 1]) {
            translate([sign * 80, 20, PLATE_T - 8])
                cylinder(r=40, h=8.5, $fn=6);  // hexagonal pockets, 8mm deep blind
        }

        // ---- CABLE MANAGEMENT HOLE (central, Ø20mm) ----
        // Routes motor and encoder cables through plate
        translate([0, 50, -0.5])
            cylinder(d=20, h=PLATE_T+1, $fn=32);
    }
}

alt_plate();

// ============================================================
// ASSEMBLY NOTE:
// The altitude plate sits ABOVE the azimuth plate, hinged at rear.
// Hinge brackets (LatBase_HingeBracket.scad) clamp between them.
// The tangent arm block (LatBase_TangentArmBlock.scad) rides under
// the front of this plate, driven by the M8 lead screw.
// Once latitude is set, the altitude knob locks the lead screw.
// A locking bolt through a separate clamp (M6 × 2) adds secondary lock.
// ============================================================
