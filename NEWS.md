## AcidPlyr 0.1.20 (2021-05-18)

### Minor changes

- Need to import `as.DataFrame` from pipette to improve consistency of `list`
  to `DataFrame` coercion, which is currently tricky on Bioconductor 3.13.

## AcidPlyr 0.1.19 (2021-05-18)

### Minor changes

- `mapToDataFrame`: Hardened function in the case when dplyr is not installed.
  Internally the `purrr::map_df` call hands off to dplyr.

## AcidPlyr 0.1.18 (2021-04-27)

### Minor changes

- `mapToDataFrame`: Offloading purrr as a suggested package, since this is the
  only function that calls `map_dfr` internally.
- Removed `map_df` and `map_dfr` as reexported functions.

## AcidPlyr 0.1.17 (2021-03-10)

### Minor changes

- `leftJoin`: Improve error message when user attempts to pass in columns via
  "by" argument that are not unique.

## AcidPlyr 0.1.16 (2021-03-03)

### Minor changes

- Join methods now coerce objects to `DataFrame`, to avoid unwanted issues with
  classed objects.
- `fullJoin` return now retains metadata from `x`, as expected.

## AcidPlyr 0.1.15 (2021-03-02)

### Minor changes

- `mutateAll`: Attempting to remove dependency on internal `as_tibble` method,
  so we can preserve complex S4 columns.

## AcidPlyr 0.1.14 (2021-02-24)

### Minor changes

- NAMESPACE fixes for downstream packages that attempt to use melt method on
  sparse matrix. Now calling some functions from AcidGenerics that mask base
  variants.

## AcidPlyr 0.1.13 (2021-02-20)

### New functions

- Added `rbindToDataFrame`, which is an incredibly useful utility for ensuring
  that nested list elements return 1:1 per row. The function handles complex
  S4 classes such as `IntegerList` and nested ranges.

### Minor changes

- Renamed `unlistToDataFrame` to `mapToDataFrame`, which better matches the
  conventions used in other Acid Genomics packages, as well as purrr.

## AcidPlyr 0.1.12 (2021-02-19)

### Minor changes

- `unlistToDataFrame`: Improved internal code to handle input of `CharacterList`
  and `IntegerList` properly. Reworked internal call to `purrr::map_dfr`.

## AcidPlyr 0.1.11 (2021-02-13)

### Minor changes

- Improved internal code for join methods.

## AcidPlyr 0.1.10 (2021-02-12)

### Minor changes

- Tightened up dependency requirements.

## AcidPlyr 0.1.9 (2021-02-11)

### Minor changes

- Updated reexports to include some useful purrr map reexports.

## AcidPlyr 0.1.8 (2021-02-02)

### New functions

- Migrated `collapseToString` from basejump.

## AcidPlyr 0.1.7 (2021-01-31)

### Minor changes

- Tightened up internal code of join functions.

## AcidPlyr 0.1.6 (2021-01-06)

### Minor changes

- Migrated internal dependency from cli to AcidCLI.

## AcidPlyr 0.1.5 (2021-01-06)

### New functions

- Added new `unlistToDataFrame` utility, inspired by approach used in purrr
  package. Note that package now imports purrr.

## AcidPlyr 0.1.4 (2020-10-12)

### Minor changes

- `mutateAt`: Bug fix to improve internal `list` to `DataFrame` coercion.

## AcidPlyr 0.1.3 (2020-10-12)

### Minor changes

- `melt`: Improved internal code for contingency `table` method support.

## AcidPlyr 0.1.2 (2020-10-12)

### Minor changes

- `melt`: Added back `table` method support, which is used in pointillism.

## AcidPlyr 0.1.1 (2020-10-07)

### New functions

- Migrated functions previously defined in basejump: `melt`, `mutateAll`,
  `mutateIf`, `transmuteAt`, `transmuteIf`, `mutateAt`, `selectIf`.

### Minor changes

- `melt`: Restricted method to only support `matrix` and `DataFrame` here.
  Additional S4 methods that work on `SummarizedExperiment` and
  `SingleCellExperiment` are defined in basejump.

## AcidPlyr 0.1.0 (2020-10-06)

Initial release.

### New functions

- Migrated the join functions from basejump: `innerJoin`, `leftJoin`,
  `rightJoin`, `fullJoin`, `semiJoin`, `antiJoin`.
