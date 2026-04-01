# Reads in and cleans the "End of Month Positions" data from the AOFM, returns a list

Reads in and cleans the "End of Month Positions" data from the AOFM,
returns a list

## Usage

``` r
read_eom(aofm_table, csv = FALSE)
```

## Arguments

- aofm_table:

  object to download, typically called from read_aofm()

- csv:

  if `TRUE`, also writes the parsed output to `output/`

## Value

AOFM eom data is returned as a list with data frame elements for
FaceValue, MarketValue, Delta, Duration and Tenor

## Examples

``` r
if (FALSE)  read_eom("tb_position_dealt") # \dontrun{}
# downloads Treasury Bond EOM data on a dealt basis from the AOFM
# returns cleaned in a long format
# data is returned as a list with data frame elements for
# FaceValue, MarketValue, Delta, Duration and Tenor
if (FALSE) read_eom("tb_position_settlement") # \dontrun{}
# downloads Treasury Bond EOM data on a settlement basis from the
# AOFM, returns cleaned in a long format as a list with elements for each of
# FaceValue, MarketValue, Delta, Duration and Tenor
```
