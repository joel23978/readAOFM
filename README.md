---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# readAOFM

`readAOFM` downloads workbook data from the Australian Office of Financial
Management (AOFM) DataHub and returns cleaned R data frames or lists.

## Installation

You can install the development version from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("joel23978/readAOFM")
```

## Primary interface

The main entrypoint is `read_aofm()`.

- `security`: one of `tb`, `tib`, `tn`, `slf`, `summary`, `aggregate`,
  `ownership`, `retail`, `term.premium`; optional when you want all supported
  tables
- `type`: one of `dealt`, `settlement`, `issuance`, `syndication`,
  `buyback`, `turnover`; optional when `security` should return all matching
  supported tables
- `csv`: if `TRUE`, also writes the parsed output to CSV via the underlying
  reader

When `security` is omitted, `read_aofm()` returns a named list of all
supported tables. When only `type` is omitted, it returns all supported
tables for that security.

## Example

``` r
library(readAOFM)

tb_issuance <- read_aofm("tb", "issuance")
head(tb_issuance)

all_tables <- read_aofm()
length(all_tables)

tb_all <- read_aofm("tb")
names(tb_all)
```

## Search helper

`search_aofm()` searches the supported table catalog and returns matching
tables together with ready-to-run `read_aofm()` calls.

``` r
search_aofm("tb issuance")
search_aofm("issuance")
search_aofm("treasury bond")
search_aofm("inflation")
```

If you want the data immediately, set `read = TRUE`:

``` r
tb_issuance <- search_aofm("tb issuance", read = TRUE)
all_issuance <- search_aofm("issuance", read = TRUE)
```

For downstream analysis or charting, add your preferred tidyverse packages in
the calling script:

``` r
library(dplyr)
library(ggplot2)
library(readAOFM)

read_aofm("tb", "issuance") %>%
  filter(name == "coverage_ratio") %>%
  ggplot(aes(x = date_held, y = value)) +
  geom_point() +
  theme_minimal()
```

## Secondary helper

`download_aofm_xlsx()` is still available if you want the raw workbooks saved
locally, but `read_aofm()` is the preferred interface for normal use.

## Disclaimer

The AOFM website may change in ways that require updates to this package.

This package is not affiliated with or endorsed by AOFM. All data is provided
under any terms set out on the AOFM website.
