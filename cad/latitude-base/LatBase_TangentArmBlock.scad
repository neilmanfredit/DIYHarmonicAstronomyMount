// ============================================================
// HEM-001 — Latitude Adjustment Base: TANGENT ARM BLOCK
// Sits on the azimuth plate, under the front of the altitude plate.
// M8 lead screw threads through it and pushes up on the altitude plate.
// Material: 6061-T6 Aluminium, machined from 60×50×40mm block
// Part No: HEM-LAT-004
// Revision: 1.0 | 2026-06
// ============================================================
//
// HOW THE TANGENT ARM WORKS:
// The block is fixed to the azimuth plate (M5 × 2 bolts).
// An M8 threaded rod passes vertically through the block.
// A large D50mm knurled knob on top drives the rod in/out.
// The tip of the rod contacts the underside of the altitude plate.
// Turning the knob raises or lowers the front of the altitude plate,
// tilting it about the rear hinge pivot — setting the latitude angle.
//
// SCALE CALCULATION:
// Pivot-to-contact distance (tangent arm length) = 180mm (see alt plate)
// At latitude θ, lead screw extension = 180 × tan(θ)
// 1 revolution of M8 rod (1.25mm pitch) = 1.25mm linear = 0.40° at 53°
// Full M8 rod travel needed for 0-70°: 180 × tan(70°) = 495mm — use 200mm rod
// Practical range with 150mm rod: 0° to arctan(150/180) ≈ 39° minimum
// For UK (53°): rod extension = 180 × tan(53.41°) = 242mm — use 300mm M8 rod
//   and adjust datum (compress spring preload) to start from 30° rather than 0°
//
// LOCKING:
// A nylon-insert lock nut on the M8 rod provides friction hold.
// A secondary M6 clamp bolt through a split in the block adds positive lock.
// ============================================================

// ---- PARAMETERS ----

BLOCK_W  = 60;   // mm — block width
BLOCK_D  = 50;   // mm — block depth (front-back)
BLOCK_H  = 40;   // mm — block height

// Lead screw bore
SCREW_BORE   = 7.0;    // mm — M8 minor diameter + clearance for threading in
// NOTE: Tap M8 through full block height OR use a brass M8 insert
SCREW_INSERT = 14;     // mm — OD of brass M8 threaded insert (if used)
SCREW_X      = BLOCK_W/2;
SCREW_Y      = BLOCK_D/2;

// Base mounting holes (M5 × 2, through block, into azimuth plate top face)
MOUNT_BOLT   = 5.3;    // mm — M5 clearance
MOUNT_X_OFFSET = 20;   // mm — half spacing X

// Split clamp slot (for secondary locking)
SPLIT_W      = 2;      // mm — slot width (saw cut)
SPLIT_H      = 20;     // mm — slot depth from top
CLAMP_BOLT_H = BLOCK_H - SPLIT_H/2;  // height of M6 clamping bolt

// Contact pad recess (top face — optional brass or PTFE wear pad)
PAD_D        = 16;     // mm — contact pad diameter
PAD_H        = 3;      // mm — recess depth

// ---- GEOMETRY ----

module tangent_arm_block() {
    difference() {
        // Main block with chamfered top edges
        hull() {
            translate([2, 2, 0]) cube([BLOCK_W-4, BLOCK_D-4, BLOCK_H]);
            translate([0, 0, 0]) cube([BLOCK_W, BLOCK_D, BLOCK_H-3]);
        }

        // ---- LEAD SCREW BORE (M8 — vertical, through full height) ----
        translate([SCREW_X, SCREW_Y, -0.5])
            cylinder(d=SCREW_BORE, h=BLOCK_H+1, $fn=24);

        // ---- CONTACT PAD RECESS (top face) ----
        translate([SCREW_X, SCREW_Y, BLOCK_H - PAD_H])
            cylinder(d=PAD_D, h=PAD_H+0.5, $fn=32);

        // ---- BASE MOUNTING HOLES (2× M5, through bottom) ----
        translate([SCREW_X - MOUNT_X_OFFSET, SCREW_Y, -0.5])
            cylinder(d=MOUNT_BOLT, h=BLOCK_H+1, $fn=24);
        translate([SCREW_X + MOUNT_X_OFFSET, SCREW_Y, -0.5])
            cylinder(d=MOUNT_BOLT, h=BLOCK_H+1, $fn=24);

        // ---- SPLIT CLAMP SLOT (front face — vertical saw cut) ----
        translate([SCREW_X - SPLIT_W/2, -0.5, BLOCK_H - SPLIT_H])
            cube([SPLIT_W, BLOCK_D/2 + 1, SPLIT_H + 0.5]);

        // ---- CLAMP BOLT HOLE (horizontal, M6, through split) ----
        translate([-0.5, SCREW_Y, CLAMP_BOLT_H])
            rotate([0, 90, 0])
                cylinder(d=6.5, h=BLOCK_W+1, $fn=24);

        // ---- WEIGHT REDUCTION POCKETS (sides) ----
        for (side = [0, 1]) {
            translate([side == 0 ? -0.5 : BLOCK_W - 10, 8, 5])
                cube([10.5, BLOCK_D - 16, BLOCK_H - 15]);
        }
    }
}

tangent_arm_block();
