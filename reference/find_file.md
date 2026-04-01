# Find name of file to download from AOFM

Find name of file to download from AOFM

## Usage

``` r
find_file(security = NULL, type = NULL)
```

## Arguments

- security:

  object you want data on, options include: tb, tib, tn, slf, summary,
  aggregate, ownership, retail, termpremium

- type:

  the specific type of data you want, occasionally optional: dealt,
  settlement, issuance, syndication, buyback, turnover,

## Value

a vector with the file/s which match the input params

## Examples

``` r
if (FALSE) { # \dontrun{
find_file("tb", "issuance")
find_file("tb")
find_file()
} # }
```
