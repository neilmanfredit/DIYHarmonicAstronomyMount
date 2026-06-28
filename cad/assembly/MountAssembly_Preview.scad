// ============================================================
// HEM-001 — Full Assembly Preview
// Shows all major components in their assembled positions.
// For reference only — not for manufacturing.
// Open in OpenSCAD with Preview (F5) not Render (F6).
// Revision: 1.0 | 2026-06
// ============================================================
//
// COMPONENT POSITIONS (approximate — schematic arrangement):
//   Z=0:       Bottom of azimuth plate (tripod interface)
//   Z=15:      Top of azimuth plate / bottom of hinge brackets
//   Z=85:      Top of altitude plate (latitude = 53°)
//   Z=100:     Bottom of polar axis spine
//   Z=320:     Top of polar spine / RA housing front plate
//   Z=340:     RA harmonic drive output flange
//   Z=400:     DEC housing plate
//   Z=430:     Vixen saddle / telescope
// ============================================================

// Colours for visual differentiation
AZ_COL    = [0.6, 0.7, 0.8, 0.9];   // light blue-grey — azimuth plate
ALT_COL   = [0.5, 0.6, 0.75, 0.9];  // slightly darker — altitude plate
HINGE_COL = [0.4, 0.5, 0.65, 1.0];  // dark — hinge brackets
RA_COL    = [0.7, 0.75, 0.8, 0.9];  // RA housing
DEC_COL   = [0.65, 0.7, 0.78, 0.9]; // DEC housing
HD_COL    = [0.85, 0.7, 0.2, 1.0];  // gold — harmonic drives
MOTOR_COL = [0.3, 0.3, 0.3, 1.0];   // dark grey — motors
SADDLE_COL= [0.5, 0.5, 0.55, 1.0];  // Vixen saddle

LAT = 53.41;  // tilt angle in degrees (Stockport latitude)

// ---- AZIMUTH PLATE ----
color(AZ_COL)
    translate([0, 0, 0])
        cube([280, 240, 15], center=true);  // approximate placeholder

// ---- ALTITUDE PLATE (tilted at latitude angle) ----
color(ALT_COL)
    translate([0, -50, 15])
    rotate([-LAT, 0, 0])
        cube([260, 220, 15], center=true);

// ---- HINGE BRACKETS (pair) ----
color(HINGE_COL) {
    translate([-100, 70, 15])
        cube([60, 18, 70]);
    translate([40, 70, 15])
        cube([60, 18, 70]);
}

// ---- POLAR AXIS SPINE (tilted with altitude plate) ----
color(RA_COL)
    translate([0, -50, 30])
    rotate([-LAT, 0, 0])
    translate([0, 0, 15])
        cube([120, 10, 220], center=true);

// ---- RA HARMONIC DRIVE (schematic cylinder) ----
color(HD_COL)
    translate([0, -90, 180])
    rotate([-LAT, 0, 0])
        cylinder(d=79, h=47, center=true, $fn=48);

// ---- RA MOTOR (schematic) ----
color(MOTOR_COL)
    translate([75, -80, 185])
    rotate([-LAT, 0, 0])
        cube([42, 42, 40], center=true);

// ---- DEC HOUSING ----
color(DEC_COL)
    translate([0, -90, 230])
    rotate([-LAT, 0, 0])
        cube([160, 10, 160], center=true);

// ---- DEC HARMONIC DRIVE (schematic) ----
color(HD_COL)
    translate([0, -85, 260])
    rotate([-LAT, 0, 0])
        cylinder(d=63, h=39, center=true, $fn=48);

// ---- VIXEN SADDLE ----
color(SADDLE_COL)
    translate([0, -80, 300])
    rotate([-LAT, 0, 0])
        cube([100, 10, 50], center=true);

// ---- COUNTERWEIGHT SHAFT ----
color([0.8, 0.8, 0.82, 1.0])
    translate([0, -90, 130])
    rotate([-LAT, 0, 0])
    rotate([90, 0, 0])
        cylinder(d=12, h=280, $fn=16);

// ---- COUNTERWEIGHTS (2× 1kg schematic) ----
color([0.6, 0.62, 0.65, 1.0]) {
    translate([0, -90 - 180, 130])
    rotate([-LAT, 0, 0])
        cylinder(d=80, h=30, center=true, $fn=32);
    translate([0, -90 - 230, 130])
    rotate([-LAT, 0, 0])
        cylinder(d=80, h=30, center=true, $fn=32);
}

// ---- TRIPOD STUB (schematic — indicates tripod head position) ----
color([0.4, 0.4, 0.4, 0.5])
    translate([0, 0, -60])
        cylinder(d=50, h=60, $fn=16);
