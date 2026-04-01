# Reads in and cleans data under "Ownership of Australia Government Securities" from the AOFM, returns cleaned in a long format

Reads in and cleans data under "Ownership of Australia Government
Securities" from the AOFM, returns cleaned in a long format

## Usage

``` r
read_ownership(aofm_table, csv = FALSE)
```

## Arguments

- aofm_table:

  object to download, typically called from read_aofm()

- csv:

  if `TRUE`, also writes the parsed output to `output/`

## Value

AOFM ownership data as a list, with elements relating to sheets in the
original file

## Examples

``` r
if (FALSE) read_ownership("ownership_nonresident") # \dontrun{}
```
