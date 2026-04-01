# Reads in and cleans data under "Transaction Details" from the AOFM, returns cleaned in a long format (excl. issunace via conversion and syndication details)

Reads in and cleans data under "Transaction Details" from the AOFM,
returns cleaned in a long format (excl. issunace via conversion and
syndication details)

## Usage

``` r
read_transactional(aofm_table, csv = FALSE)
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
if (FALSE) read_transactional("tb_issunace") # \dontrun{}
# downloads Treasury Bond Issunace data from the AOFM, returns cleaned in a long format
if (FALSE) read_transactional("slf") # \dontrun{}
# downloads Securities Lending Facility data from the AOFM, returns cleaned in a long format
```
