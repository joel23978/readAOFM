# Download xlsx.xls files from AOFM DataHub

Download xlsx.xls files from AOFM DataHub

## Usage

``` r
download_aofm_xlsx(security = NULL, type = NULL)
```

## Arguments

- security:

  object you want data on, options include: tb, tib, tn, slf, summary,
  aggregate, ownership, retail, termpremium

- type:

  the specific type of data you want, occasionally optional: dealt,
  settlement, issuance, syndication, buyback, turnover,

## Value

a list of downloaded files

## Examples

``` r
if (FALSE) download_aofm_xlsx("tb", "issuance") # \dontrun{}
# downloads AOFM Treasury Bond Issuance data to data/tb_issuance.xlsx
if (FALSE) download_aofm_xlsx("tb") # \dontrun{}
# downloads all Treasury Bond data from the AOFM Datahub incl
# issunace, syndication details, position data etc to data/
if (FALSE) download_aofm_xlsx() # \dontrun{}
# downloads all data from the AOFM Datahub to data/
```
