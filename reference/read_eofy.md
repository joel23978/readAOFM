# Reads in and cleans the EOFY Positions - Executive Summary data from the AOFM, returns cleaned in a long format

Reads in and cleans the EOFY Positions - Executive Summary data from the
AOFM, returns cleaned in a long format

## Usage

``` r
read_eofy(aofm_table, csv = FALSE)
```

## Arguments

- aofm_table:

  object to download, "summary" is the only correct input, typically
  called from read_aofm()

- csv:

  if `TRUE`, also writes the parsed output to `output/`

## Value

AOFM eofy data as a dataframe

## Examples

``` r
if (FALSE) read_eofy("summary") # \dontrun{}
# downloads EOFY Positions - Executive Summary  data from the AOFM, returns cleaned in a long format
```
