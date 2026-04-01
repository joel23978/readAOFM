# Reads in and cleans Syndication details data under "Transaction Details" from the AOFM, returns cleaned in a long format

Reads in and cleans Syndication details data under "Transaction Details"
from the AOFM, returns cleaned in a long format

## Usage

``` r
read_syndication(aofm_table, csv = FALSE)
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
if (FALSE) read_transactional("tb_syndication") # \dontrun{}
# downloads Treasury Bond Syndication details data from the AOFM, returns cleaned in a long format
```
