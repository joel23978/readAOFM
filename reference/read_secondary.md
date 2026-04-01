# Reads in and cleans data under "AGS Secondary Market Turnover" from the AOFM, returns cleaned in a long format

Reads in and cleans data under "AGS Secondary Market Turnover" from the
AOFM, returns cleaned in a long format

## Usage

``` r
read_secondary(aofm_table, csv = FALSE)
```

## Arguments

- aofm_table:

  object to download, typically called from read_aofm()

- csv:

  if `TRUE`, also writes the parsed output to `output/`

## Value

AOFM Transactional data as a dataframe

## Examples

``` r
if (FALSE) read_secondary("tb_turnover") # \dontrun{}
# downloads Treasury Bond Turnover data from the AOFM, returns cleaned in a long format
```
