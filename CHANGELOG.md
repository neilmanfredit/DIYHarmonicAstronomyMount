# Changelog

All notable changes to this project are documented here.  
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.0.0] — 2026-06

### Added
- Initial release of all CAD files (OpenSCAD)
- RA axis housing plate (CSF-17-100, NEMA17 motor mount, bearing pocket)
- DEC axis housing plate (CSF-14-100, Vixen saddle pattern)
- Polar axis spine / body
- **Latitude adjustment base** — full 4-part assembly:
  - Azimuth plate (tripod interface, ±8° AZ trim)
  - Altitude plate (mount body, tangent arm drive)
  - Hinge bracket pair (pivot axis)
  - Tangent arm drive block
- 2D engineering drawings (SVG) for RA and DEC plates
- CNC machining operations files for all major parts
- OnStepX firmware configuration (FYSETC E4, TMC2209, 300:1 reduction)
- Full electronics wiring guide
- Failsafe brake relay circuit documentation
- Bill of Materials with AliExpress/eBay sourcing
- Tripod mounting and latitude setup guide
- Build guide and commissioning procedure

### Notes
- Designed for UK latitude (~53°N) — edit `firmware/OnStepX_Config.h` for your location
- Tested dimensions against CSF-17-100-2A-R and CSF-14-100-2A-R datasheets
- AliExpress clone compatibility confirmed for SitoDrive CS-17-I and CS-14-I variants
- All SCAD parameters are at the top of each file for easy customisation
