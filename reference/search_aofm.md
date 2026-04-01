# Search the supported AOFM table catalog

Search the supported AOFM table catalog

## Usage

``` r
search_aofm(query, read = FALSE, csv = FALSE)
```

## Arguments

- query:

  Search string used to match supported AOFM tables

- read:

  if `TRUE`, reads the matched tables via
  [`read_aofm()`](https://joel23978.github.io/readAOFM/reference/read_aofm.md)
  instead of returning the catalog rows

- csv:

  if `TRUE` and `read = TRUE`, also writes matched outputs to CSV via
  [`read_aofm()`](https://joel23978.github.io/readAOFM/reference/read_aofm.md)

## Value

A dataframe of supported table matches, or the result of
[`read_aofm()`](https://joel23978.github.io/readAOFM/reference/read_aofm.md)
when `read = TRUE`

## Examples

``` r
search_aofm("tb issuance")
#>   security     type          id             reader                   read_call
#> 1       tb issuance tb_issuance read_transactional read_aofm("tb", "issuance")
search_aofm("issuance")
#>   security     type           id             reader
#> 1       tb issuance  tb_issuance read_transactional
#> 2      tib issuance tib_issuance read_transactional
#> 3       tn issuance  tn_issuance read_transactional
#>                      read_call
#> 1  read_aofm("tb", "issuance")
#> 2 read_aofm("tib", "issuance")
#> 3  read_aofm("tn", "issuance")
search_aofm("treasury bond")
#>   security        type                     id             reader
#> 1       tb     buyback             tb_buyback read_transactional
#> 2       tb       dealt      tb_position_dealt           read_eom
#> 3       tb    issuance            tb_issuance read_transactional
#> 4       tb  settlement tb_position_settlement           read_eom
#> 5       tb syndication         tb_syndication   read_syndication
#> 6       tb    turnover            tb_turnover     read_secondary
#>                        read_call
#> 1     read_aofm("tb", "buyback")
#> 2       read_aofm("tb", "dealt")
#> 3    read_aofm("tb", "issuance")
#> 4  read_aofm("tb", "settlement")
#> 5 read_aofm("tb", "syndication")
#> 6    read_aofm("tb", "turnover")
search_aofm("inflation")
#>   security        type                      id             reader
#> 1      tib     buyback             tib_buyback read_transactional
#> 2      tib       dealt      tib_position_dealt           read_eom
#> 3      tib    issuance            tib_issuance read_transactional
#> 4      tib  settlement tib_position_settlement           read_eom
#> 5      tib syndication         tib_syndication   read_syndication
#> 6      tib    turnover            tib_turnover     read_secondary
#>                         read_call
#> 1     read_aofm("tib", "buyback")
#> 2       read_aofm("tib", "dealt")
#> 3    read_aofm("tib", "issuance")
#> 4  read_aofm("tib", "settlement")
#> 5 read_aofm("tib", "syndication")
#> 6    read_aofm("tib", "turnover")
if (FALSE) search_aofm("tb issuance", read = TRUE) # \dontrun{}
```
