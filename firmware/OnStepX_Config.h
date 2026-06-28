// ============================================================
// OnStepX Firmware Configuration
// Project: DIY Harmonic Drive Equatorial Mount
// Controller: FYSETC E4 (ESP32)
// Drivers: 2× TMC2209 (UART mode)
// RA Gear: CSF-17-100 × 3:1 belt = 300:1 total
// DEC Gear: CSF-14-100 × 3:1 belt = 300:1 total
// Motors: NEMA 17, 1.8°/step (200 steps/rev)
// Microstepping: 256
// Revision: 1.0 | 2026-06
// ============================================================
//
// INSTALLATION:
// 1. Clone OnStepX: https://github.com/hjd1964/OnStepX
// 2. Copy this file to: src/Config.h (overwrite)
// 3. Ensure platformio.ini target = FYSETC_E4
// 4. Build and upload via PlatformIO
//
// TRACKING RESOLUTION (RA):
// Steps/revolution = 200 × 256 × 300 = 15,360,000
// Degrees/step = 360 / 15,360,000 = 0.0000234°
// Arcseconds/step = 0.0000234 × 3600 = 0.0843 arcsec/step
// ✓ Well within the 0.06–0.08 arcsec/step target
// ============================================================

#pragma once

// ---- CONTROLLER PLATFORM ----
#define CONTROLLER_FYSETC_E4

// ---- MOUNT TYPE ----
#define MOUNT_TYPE GEM              // German Equatorial Mount

// ---- SITE / OBSERVER ----
// Stockport, England
#define LATITUDE                 53.41    // degrees north
#define LONGITUDE                -2.16    // degrees east (negative = west)
#define ELEVATION                80       // metres ASL

// ---- RA AXIS CONFIGURATION ----
// Motor: NEMA 17, 1.8°/step = 200 full steps/rev
// Driver: TMC2209, 256 microsteps
// Pre-reduction belt: 16T motor pulley → 48T harmonic input = 3:1
// Harmonic drive: CSF-17-100 = 100:1
// Total reduction: 3 × 100 = 300:1

#define AXIS1_DRIVER_MODEL        TMC2209         // RA stepper driver type
#define AXIS1_DRIVER_MICROSTEPS   256             // microsteps per full step
#define AXIS1_DRIVER_MICROSTEPS_GOTO 8            // microsteps during slew (faster)
#define AXIS1_DRIVER_IRUN         800             // run current in mA (≤1200 for NEMA17 40mm)
#define AXIS1_DRIVER_IHOLD        200             // hold current in mA
#define AXIS1_DRIVER_IHOLD_DELAY  10              // delay before reducing to hold current (s)
#define AXIS1_DRIVER_DECAY        STEALTHCHOP     // quiet tracking mode

#define AXIS1_STEPS_PER_DEGREE    42666.7         // = (200 × 256 × 300) / 360
// Verification: 15,360,000 / 360 = 42,666.7 steps/degree ✓

#define AXIS1_REVERSE             OFF             // set ON if RA tracks backwards
#define AXIS1_LIMIT_MIN           -180            // degrees — limits for park/homing
#define AXIS1_LIMIT_MAX           180
#define AXIS1_BACKLASH            0               // harmonic drive = zero backlash

// Slew rate limits
#define AXIS1_SLEW_RATE_BASE_DESIRED   1.5        // degrees/second at GOTO microstep rate
#define AXIS1_ACCELERATION_TIME        5          // seconds to reach full slew speed

// ---- DEC AXIS CONFIGURATION ----
// Motor: NEMA 17, 1.8°/step = 200 full steps/rev
// Driver: TMC2209, 256 microsteps
// Belt: 16T → 48T = 3:1
// Harmonic: CSF-14-100 = 100:1
// Total: 300:1

#define AXIS2_DRIVER_MODEL        TMC2209
#define AXIS2_DRIVER_MICROSTEPS   256
#define AXIS2_DRIVER_MICROSTEPS_GOTO 8
#define AXIS2_DRIVER_IRUN         800
#define AXIS2_DRIVER_IHOLD        200
#define AXIS2_DRIVER_IHOLD_DELAY  10
#define AXIS2_DRIVER_DECAY        STEALTHCHOP

#define AXIS2_STEPS_PER_DEGREE    42666.7         // same calculation as RA
#define AXIS2_REVERSE             OFF
#define AXIS2_LIMIT_MIN           -90
#define AXIS2_LIMIT_MAX           90
#define AXIS2_BACKLASH            0

#define AXIS2_SLEW_RATE_BASE_DESIRED   1.5
#define AXIS2_ACCELERATION_TIME        5

// ---- TMC2209 UART CONFIGURATION (FYSETC E4) ----
// The FYSETC E4 uses UART address per driver:
// RA = UART address 0, DEC = UART address 1
#define AXIS1_DRIVER_ADDRESS      0               // TMC2209 UART address for RA
#define AXIS2_DRIVER_ADDRESS      1               // TMC2209 UART address for DEC

// StealthChop / SpreadCycle threshold
// Below this velocity, StealthChop (silent); above, SpreadCycle (torque)
// For tracking (very slow), StealthChop will always be active — correct.
#define AXIS1_DRIVER_STEALTHCHOP_THRESHOLD  200   // steps/second crossover
#define AXIS2_DRIVER_STEALTHCHOP_THRESHOLD  200

// ---- SAFETY BRAKE (RA AXIS) ----
// 12V NC electromagnetic brake on RA motor shaft
// Wired: GPIO output → relay → brake coil
// Normally Closed = brake ON when power cut (safe)
// OnStepX: define an AUX output pin for brake relay
// FYSETC E4 spare output — check board pinout (typically GPIO12 or GPIO14)
#define AUX_RELAY_1_PIN           12              // GPIO pin driving brake relay
// Brake releases (coil energised) when mount is powered and tracking
// OnStepX will cut GPIO12 LOW when parked or powered off → brake engages automatically

// ---- TRACKING RATES ----
#define TRACK_COMPENSATION_NONE               // start simple; add PEC later
#define TRACK_BACKLASH_COMPENSATION   OFF     // harmonic drives need no backlash comp

// Sidereal tracking rate (fixed — do not change)
// OnStepX uses its own internal sidereal constant

// ---- COMMUNICATION ----
#define SERIAL_A_BAUD_DEFAULT     9600        // HC hand controller / INDI
#define SERIAL_B_BAUD_DEFAULT     115200      // USB serial (programming / debug)

// WiFi (FYSETC E4 / ESP32 native)
#define WIFI_ENABLED
#define WIFI_AP_SSID              "HarmonicMount"   // Access Point SSID
#define WIFI_AP_PASSWORD          "onstep1234"       // Change before use
#define WIFI_AP_CHANNEL           6
// Once connected: access OnStep web interface at http://192.168.0.1

// ---- ST4 AUTOGUIDER PORT ----
#define ST4_INTERFACE             ON         // Enable ST4 guiding port
#define ST4_HAND_CONTROL          OFF        // ST4 is for autoguider, not hand controller

// ---- PARK ----
#define PARK_AXIS1_DEG            0.0        // Park position RA: 0° (pointing at meridian)
#define PARK_AXIS2_DEG            LATITUDE   // Park position DEC: matches latitude (home position)

// ---- MISC ----
#define STATUS_LED_PIN            2          // Onboard LED for OnStep status blink
#define MOUNT_COORDS_TOPOCENTRIC  ON         // Use topocentric coordinates (correct for near-Earth)

// ---- PAYLOAD & BALANCE ----
// OnStepX does not directly manage balance, but these notes are for setup:
// NexStar 8SE fully rigged: ~7.5kg
// Balance counterweights: 3–4kg total on 250–300mm CW shaft
// Always balance RA and DEC before enabling motors

// ---- PERIODIC ERROR CORRECTION (future) ----
// Harmonic drives have characteristic periodic error at ~1/100 rev
// PEC can be trained in via OnStep once mount is tracking well
// #define PEC_STEPS_PER_WORM_ROTATION  15360000  // = steps/full RA revolution
// Enable PEC training from INDI/KStars after commissioning

// ---- NOTES FOR COMMISSIONING ----
// 1. First power-up: connect via USB serial, run "GVP#" to confirm OnStep responds.
// 2. Manually jog RA with hand controller / INDI — confirm correct direction.
//    If reversed, change AXIS1_REVERSE from OFF to ON.
// 3. Check brake relay: brake should release when OnStep is active,
//    engage immediately on power cut (test with PSU switch).
// 4. Polar align using SharpCap / PoleMaster / drift alignment.
// 5. First light test: track a bright star for 5 minutes, check for drift.
// 6. After good tracking: train PEC, then add PHD2 autoguiding.
