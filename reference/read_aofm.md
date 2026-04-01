# Reads in and cleans any data from the AOFM, returns cleaned in a long format

Reads in and cleans any data from the AOFM, returns cleaned in a long
format

## Usage

``` r
read_aofm(security = NULL, type = NULL, csv = FALSE)
```

## Arguments

- security:

  object you want data on, options include: tb, tib, tn, slf, summary,
  aggregate, ownership, retail, termpremium. Optional; when omitted, all
  supported tables are returned.

- type:

  the specific type of data you want, optional when the inputs resolve
  to one or more supported tables: dealt, settlement, issuance,
  syndication, buyback, turnover,

- csv:

  if `TRUE`, also writes the parsed output to a CSV file via the
  underlying reader

## Value

AOFM selected AOFM data as a dataframe, list, or named list of table
results when the inputs match multiple supported tables

## Examples

``` r
if (FALSE) read_aofm("tb", "issuance") # \dontrun{}
# downloads Treasury Bond Issunace data from the AOFM
# returns cleaned in a long format
```
