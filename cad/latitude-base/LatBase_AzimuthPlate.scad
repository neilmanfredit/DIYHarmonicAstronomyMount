// ============================================================
// HEM-001 — Latitude Adjustment Base: AZIMUTH PLATE
// The fixed lower plate that sits on the tripod head.
// Material: 6061-T6 Aluminium, 15mm thick
// Part No: HEM-LAT-001
// Revision: 1.0 | 2026-06
// ============================================================
//
// FUNCTION:
// This is the BOTTOM plate of the latitude adjustment assembly.
// It attaches to the tripod via a central 3/8"-16 UNC stud.
// The altitude plate above it tilts on two hinge pivot bolts.
// An azimuth trim ring allows ±8° fine AZ adjustment after
// rough north-pointing of the tripod.
//
// FEATURES:
// - Central 3/8"-16 UNC boss (22mm OD, 15mm tall)
// - Three tripod leg attachment holes (M8, 120° spacing, 90mm PCD)
//   for screw-in tripod adapters (alt: use single central stud only)
// - Azimuth trim arc slots (×2, ±8° travel, M6 clamping bolts)
// - Hinge bracket mounting holes (2× M8, 200mm apart)
// - Bubble level recess (optional — 28mm diameter, 5mm deep)
// - Thrust bearing recess (F8-16M, 8×16×5mm — under central stud)
// - Laser-engraved azimuth scale (±8° in 1° increments)
//   NOTE: engrave scale separately or use adhesive strip
//
// MACHINING NOTES:
// - 15mm thick stock required (stiffness under 7.5kg payload + mount mass)
// - Central boss is a raised feature — machine from 20mm stock, leaving
//   22mm OD × 7mm tall boss at centre, face remainder to 15mm
// - Or: machine flat from 15mm and use a separate threaded insert
// - Hinge bracket holes are TAPPED M8 (do not use clearance holes)
// - AZ arc slots: use Ø6.5mm cutter, 8° arc at 110mm radius
// ============================================================

// ---- PARAMETERS ----
PLATE_W         = 280;    // mm — plate width (left-right)
PLATE_D         = 240;    // mm — plate depth (front-back)
PLATE_T         = 15;     // mm — plate thickness

// Tripod interface
TRIPOD_BOSS_OD  = 28;     // mm — boss outer diameter
TRIPOD_BOSS_H   = 7;      // mm — boss height above plate face
TRIPOD_BORE     = 10.5;   // mm — 3/8" UNC stud clearance (9.53mm + 0.97 clearance)
// Alternatively: tap M10 (9.5mm bore ≈ 3/8" — practical substitute)

THRUST_RECESS_D = 17;     // mm — F8-16M thrust bearing OD recess (16mm + 1mm clearance)
THRUST_RECESS_D_BTM = 9;  // mm — inner bore of thrust recess (allows stud through)
THRUST_RECESS_H = 5.5;    // mm — bearing recess depth (bearing is 5mm thick)

// Tripod leg holes (optional — for screw-in tripod adapter bolts)
TRIPOD_LEG_PCD  = 90;     // mm — pitch circle for leg adapter bolts
TRIPOD_LEG_DIA  = 8.5;    // mm — M8 clearance hole
TRIPOD_LEG_OFFSET = 60;   // degrees — rotation of first leg hole from front

// Hinge pivot attachment
HINGE_SPACING   = 200;    // mm — centre-to-centre distance between hinge brackets
HINGE_BOLT_DIA  = 8.2;    // mm — M8 clearance hole (hinge brackets bolt through here)
// NOTE: hinge brackets clamp OVER the plate edge — see LatBase_HingeBracket.scad

// Azimuth trim arc slots
// Arc centred at plate centre, 110mm radius, ±8° sweep, Ø6.5mm slots
AZ_ARC_R        = 110;    // mm — arc radius
AZ_ARC_DEG      = 8;      // ± degrees of travel
AZ_SLOT_W       = 6.5;    // mm — slot width (M6 clamping bolt)

// Bubble level recess (optional — fits standard 28mm round level)
LEVEL_D         = 29;     // mm — recess diameter
LEVEL_H         = 5;      // mm — recess depth (blind)
LEVEL_X         = PLATE_W/2 - 25;  // position: front-right corner
LEVEL_Y         = PLATE_D/2 - 25;

// Corner radius
CR = 12;

// ---- GEOMETRY ----

module az_plate() {
    difference() {
        // Base plate
        hull() {
            for (x = [-PLATE_W/2 + CR, PLATE_W/2 - CR])
                for (y = [-PLATE_D/2 + CR, PLATE_D/2 - CR])
                    translate([x, y, 0]) cylinder(r=CR, h=PLATE_T, $fn=32);
        }

        // ---- THRUST BEARING RECESS (bottom face — Z=0 face) ----
        // Machine from bottom face, depth 5.5mm blind
        translate([0, 0, -0.5])
            cylinder(d=THRUST_RECESS_D, h=THRUST_RECESS_H+0.5, $fn=48);

        // ---- TRIPOD STUD BORE (central through-hole) ----
        translate([0, 0, -0.5])
            cylinder(d=TRIPOD_BORE, h=PLATE_T+1, $fn=32);

        // ---- TRIPOD BOSS (raised feature — subtract from top face) ----
        // Boss is machined proud on the AZIMUTH TRIM RING above.
        // This plate has a matching recess that the trim ring boss engages.
        // (No boss on this plate — just the bore)

        // ---- TRIPOD LEG ADAPTER HOLES (3× M8 on 90mm PCD) ----
        for (i = [0, 1, 2]) {
            angle = TRIPOD_LEG_OFFSET + i * 120;
            translate([cos(angle)*TRIPOD_LEG_PCD/2, sin(angle)*TRIPOD_LEG_PCD/2, -0.5])
                cylinder(d=TRIPOD_LEG_DIA, h=PLATE_T+1, $fn=24);
        }

        // ---- AZIMUTH TRIM ARC SLOTS (×2 — symmetrical, front and rear) ----
        // Front slot (positive Y side)
        for (a = [-AZ_ARC_DEG : 1 : AZ_ARC_DEG]) {
            translate([sin(a)*AZ_ARC_R, cos(a)*AZ_ARC_R, -0.5])
                cylinder(d=AZ_SLOT_W, h=PLATE_T+1, $fn=20);
        }
        // Rear slot (negative Y side) — second clamping point
        for (a = [-AZ_ARC_DEG : 1 : AZ_ARC_DEG]) {
            translate([sin(a)*AZ_ARC_R, -cos(a)*AZ_ARC_R, -0.5])
                cylinder(d=AZ_SLOT_W, h=PLATE_T+1, $fn=20);
        }

        // ---- HINGE BRACKET BOLT HOLES (×2 — left and right plate sides) ----
        // Hinge brackets straddle the plate at Y=0 (front face of mount)
        translate([-HINGE_SPACING/2, -PLATE_D/2 + 25, -0.5])
            cylinder(d=HINGE_BOLT_DIA, h=PLATE_T+1, $fn=24);
        translate([HINGE_SPACING/2, -PLATE_D/2 + 25, -0.5])
            cylinder(d=HINGE_BOLT_DIA, h=PLATE_T+1, $fn=24);

        // ---- BUBBLE LEVEL RECESS (optional) ----
        translate([LEVEL_X, LEVEL_Y, PLATE_T - LEVEL_H])
            cylinder(d=LEVEL_D, h=LEVEL_H+0.5, $fn=48);

        // ---- MATERIAL RELIEF POCKETS (weight reduction) ----
        // Two symmetric pockets on left/right sides
        for (sign = [-1, 1]) {
            translate([sign * 90, 30, 4])
                cylinder(r=30, h=PLATE_T - 4, $fn=6);  // hex pocket
        }
    }
}

az_plate();

// ---- NOTES ----
// The azimuth trim ring (if implemented separately) sits between
// this plate and the tripod head, rotating on the central stud
// with the thrust bearing beneath. Two M6 bolts through the arc
// slots clamp it once AZ is set.
// For simpler builds: omit the AZ ring and rotate the whole tripod.
// The arc slots are still useful for ±8° without disturbing tripod legs.
