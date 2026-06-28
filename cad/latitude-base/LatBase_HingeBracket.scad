// ============================================================
// HEM-001 — Latitude Adjustment Base: HINGE BRACKET
// One of a matched pair. Pivots the altitude plate on the
// azimuth plate. Print/machine 2 identical parts.
// Material: 6061-T6 Aluminium, machined from 80×60×20mm block
// Part No: HEM-LAT-003 (qty 2)
// Revision: 1.0 | 2026-06
// ============================================================
//
// GEOMETRY:
// The bracket is an L-shape or U-clamp that:
//   - Bolts to the AZIMUTH plate (M8 × 2 per bracket, down through)
//   - Provides a precision Ø8mm pivot bore for the M8 hinge bolt
//   - The altitude plate pivot hole aligns with this bore
//
// The pivot bolt is a shoulder bolt or precision ground M8 bolt
// with a Ø8mm h6 shoulder and M8 thread at the end.
// A 6205 bearing (25×52×15mm) can be substituted at each pivot
// for zero-slop rotation — recommended for imaging builds.
//
// For the 6205 bearing option:
//   PIVOT_BORE = 52.05mm (H7) and a 25mm shoulder bolt is used.
// Default here uses a simple M8 pivot bolt (adequate for visual
// and casual imaging use).
// ============================================================

// ---- PARAMETERS ----

// Bracket body
BODY_W  = 60;    // mm — bracket width (left-right)
BODY_H  = 70;    // mm — bracket height (vertical)
BODY_T  = 18;    // mm — bracket thickness (fore-aft)

// Pivot bore (M8 shoulder or precision bolt)
PIVOT_BORE      = 8.2;    // mm — M8 clearance for pivot bolt
// For 6205 bearing upgrade: set to 52.05mm and change PIVOT_H accordingly
PIVOT_H         = BODY_W; // pivot bore runs full width of bracket

// Azimuth plate attachment bolts (2× M8 tapped into az plate)
AZ_BOLT_SPACING = 40;     // mm — spacing between two bolts, along bracket length
AZ_BOLT_BORE    = 8.5;    // mm — M8 clearance through bracket foot
AZ_BOLT_INSET   = 15;     // mm — inset from each end of foot

// Alt plate contact face (top of bracket — where alt plate rests on pivot)
// No fasteners here — alt plate is free to pivot about the bolt

// Foot thickness (where bracket bolts to az plate)
FOOT_T  = 12;    // mm — foot thickness
FOOT_W  = BODY_W;

// ---- GEOMETRY ----

module hinge_bracket() {
    difference() {
        union() {
            // Main vertical body
            cube([BODY_W, BODY_T, BODY_H - FOOT_T]);

            // Foot (extends forward for bolt access)
            translate([0, 0, 0])
                cube([FOOT_W, BODY_T + 20, FOOT_T]);
        }

        // ---- PIVOT BORE (horizontal — runs through bracket width) ----
        // Located at top of vertical body
        translate([-0.5, BODY_T/2, BODY_H - FOOT_T - 20])
            rotate([0, 90, 0])
                cylinder(d=PIVOT_BORE, h=BODY_W+1, $fn=32);

        // ---- AZ PLATE ATTACHMENT BOLTS (2× M8 through foot) ----
        translate([AZ_BOLT_INSET, BODY_T/2, -0.5])
            cylinder(d=AZ_BOLT_BORE, h=FOOT_T+1, $fn=24);
        translate([BODY_W - AZ_BOLT_INSET, BODY_T/2, -0.5])
            cylinder(d=AZ_BOLT_BORE, h=FOOT_T+1, $fn=24);

        // ---- LIGHTENING SLOT (optional — central body) ----
        translate([15, -0.5, FOOT_T + 10])
            cube([BODY_W - 30, BODY_T + 1, BODY_H - FOOT_T - 30]);
    }
}

hinge_bracket();

// Render second bracket alongside for reference
translate([BODY_W + 10, 0, 0]) hinge_bracket();
