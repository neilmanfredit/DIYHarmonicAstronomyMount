# Commissioning Guide
**Project:** HEM-001 | **Revision:** 1.0 | 2026-06

---

## Phase 1 — First Power-On (No Telescope)

1. Confirm all bolts are torqued. Confirm belt tension (1–2mm deflection under 200g).
2. Set latitude on altitude plate (read from scale strip, dial to your latitude).
3. Power on 12V PSU.
4. Listen for brake click (RA brake releases on power-on).
5. Connect to WiFi `HarmonicMount` → open `http://192.168.0.1`.
6. Jog RA east at low speed: mount should move smoothly. Note direction.
7. Jog RA west: should reverse direction.
8. If direction is wrong: set `AXIS1_REVERSE ON` in Config.h, reflash.
9. Repeat for DEC.
10. Slew to 90° offset from home position in RA — time should match expected (300:1 reduction at low speed).

---

## Phase 2 — Mount Outdoors (Daytime, No Telescope)

1. Set up tripod, level, rough-point north.
2. Attach latitude base. Set latitude. Tighten altitude lock.
3. Confirm mount rotates freely in RA (brake released, OnStep active).
4. Confirm DEC moves freely.
5. Manually rotate to various positions — no binding, no belt skip.

---

## Phase 3 — Balance and Polar Alignment

1. Mount RVO 60ED or NexStar 8SE via Vixen saddle.
2. **Balance DEC:** slide OTA fore/aft in saddle until DEC axis holds position when motor disengaged.
3. **Balance RA:** adjust counterweight position on shaft until RA axis holds position when motor disengaged.
4. Power on — OnStep active, brake released.
5. **Rough polar align:** look through polar scope. Position Polaris in outer circle (not centre — use the OnStep polar scope utility or SharpCap's polar alignment tool to get the exact offset position for tonight's date).
6. **Fine polar align:** use SharpCap Pro's polar alignment routine (requires a camera on the OTA). This takes 5–10 minutes and achieves <1 arcmin polar alignment error — adequate for all but the longest exposures.

---

## Phase 4 — OnStep Alignment

1. After polar aligning, perform a 2-star or 3-star alignment in the OnStep web interface or KStars.
2. Slew to a bright star, centre in eyepiece, sync.
3. Slew to a second star in a different part of the sky, centre, sync.
4. Pointing model is now built.
5. Test GOTO: command a slew to a known object. It should land within the eyepiece field of a 25mm eyepiece.

---

## Phase 5 — Tracking Verification

1. Centre a star at high magnification (×150 or higher).
2. Enable tracking (OnStep tracking is on by default after alignment).
3. Watch the star for 5 minutes. It should remain stationary.
4. If the star drifts North-South: polar alignment needs adjustment (altitude error).
5. If the star drifts East-West: polar alignment needs adjustment (azimuth error) OR tracking rate is wrong (check `AXIS1_STEPS_PER_DEGREE` in Config.h).

---

## Phase 6 — Autoguiding Setup

1. Attach guide camera to guide scope (or OAG on main OTA).
2. Connect guide camera to Raspberry Pi or laptop running PHD2.
3. In PHD2: connect mount via "OnStep" (LX200 protocol, port 9999, IP = E4 address).
4. Run PHD2 calibration: should complete in <5 minutes with harmonic drive (low backlash = fast calibration).
5. Start guiding. Target RMS guiding error: <0.8 arcsec with good polar alignment.

---

## Phase 7 — PEC Training (Optional, after stable guiding)

Harmonic drives have a characteristic periodic error with one cycle per input revolution (at motor shaft rate after reduction). This is typically 5–20 arcsec peak-to-peak and is very consistent — making it ideal for PEC training.

In OnStep:
1. Enable PEC recording mode.
2. Guide for 2–3 full worm cycles (for harmonic drives, this is one full revolution of the harmonic output — approximately 1 sidereal hour per degree).
3. OnStep records the correction pattern.
4. Enable PEC playback — PE should drop by 60–80%.

After PEC, typical residual error with PHD2 guiding: 0.3–0.5 arcsec RMS on a good night.
