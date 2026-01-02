# Changelog

## [Unreleased]

### Changed

- Base docker image updated to pangeo/pangeo-notebook:2025.12.30 [#54](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/54)

### Removed

- Remove `stac_ipyleaflet` [#54](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/54)
- Remove `virtualizarr`, `icechunk` since they are now included in base pangeo-notebook image [#54](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/54)


## [2025.08.14-v2] - 2025-09-19

### Changed

- Pin to `pystac==1.14.1` [#48](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/48)

## [2025.08.14-v1] - 2025-09-10

### Added

- Add `virtualizarr>=2.0.0` [#45](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/45)
- Add `icechunk` [#45](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/45)

### Changed

- Base docker image updated to pangeo/pangeo-notebook:2025.08.14 [#38](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/38) [#45](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/45)
- Use `conda` instead of `mamba` to update environment [#44](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/44)
- Pin to `geoviews-core==1.14.1` [#45](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/45)

### Removed

- Remove `libgdal-arrow-parquet==3.10.3`, `libgdal-netcdf==3.10.3` since they are now included in base pangeo-notebook image [#45](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/45)

## [2025.06.02-v1] - 2025-07-31

### Added

- Add `libgdal-arrow-parquet==3.10.3`, `libgdal-netcdf==3.10.3` [#41](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/41)

### Changed

- Base docker image updated to pangeo/pangeo-notebook:2025.06.02 [#38](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/38)

## [2024.11.11-v1] - 2025-01-24

### Changed

- Base docker image updated to pangeo/pangeo-notebook:2024.11.11 [#31](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/31)


## [2024.08.18-v1] - 2024-09-10

### Changed

- Base docker image updated to pangeo/pangeo-notebook:2024.08.18 [#28]( https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/28)
- Don't allow defaults channel - only conda-forge [#25](https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/pull/25)

## [2024.06.02-v1] - 2024-09-06

Initial release

[Unreleased]: <https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/compare/2025.08.14-v2..main>
[2025.08.14-v1]: <https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/compare/2025.08.14-v1..2025.08.14-v2>
[2025.08.14-v1]: <https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/compare/2025.06.02-v1..2025.08.14-v1>
[2025.06.02-v1]: <https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/compare/2024.11.11-v1..2025.06.02-v1>
[2024.11.11-v1]: <https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/compare/2024.08.18-v1..2024.11.11-v1>
[2024.08.18-v1]: <https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/compare/2024.06.02-v1..2024.08.18-v1>
[2024.06.02-v1]: <https://github.com/NASA-IMPACT/pangeo-notebook-veda-image/tree/2024.06.02-v1>
