# Reads in and cleans data under "Term Premium Estimates" from the AOFM, returns cleaned in a long format

Reads in and cleans data under "Term Premium Estimates" from the AOFM,
returns cleaned in a long format

## Usage

``` r
read_premium(aofm_table, csv = FALSE)
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
if (FALSE) read_premium("termpremium") # \dontrun{}
# downloads Term Premium data from the AOFM, returns cleaned in a long format
```
