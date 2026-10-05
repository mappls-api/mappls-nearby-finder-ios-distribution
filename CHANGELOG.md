# Changes to the MapplsNearbyFinder SDK for iOS

## 3.0.1

### Changed

- Updated dependency versions. Minimum versions set to `MapplsAPICore (2.1.4)` and `MapplsAPIKit (2.0.8)`.

## 3.0.0 - 05 Oct, 2026

### Added

- Added POI Along Route search support via `MapplsNearbyFinderAlongTheRouteManager`, `MapplsNearbyFinderAlongTheRouteOptions` and `MapplsNearbyFinderAlongTheRouteResponse`.

### Changed

- Migrated nearby search to OAuth 2 based authentication.
- Restructured the project. The standalone example project has been removed and a `Sample` app has been added to the SDK target.

## 2.0.3 - 25 Feb, 2025

### Fixed

- 'bitcode' disabled to support Xcode 15.

## 2.0.2 - 13 Oct, 2023

### Added

- Added request parameter `page` of type `int` in  `MapplsNearbyFinderSearchOptions`.

## 2.0.1 - 02 Jan, 2023

### Fixed

- Dependency version increaded to fix crash. Minimum versions set to `MapplsAPICore (1.0.4)`, `MapplsAPIKit(2.0.8)`.

## 2.0.0 - 14 Jun, 2022

### Changed

- Initial Mappls release.
