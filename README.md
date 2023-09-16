
<!-- README.md is generated from README.Rmd. Please edit that file -->

# readAOFM

{readAOFM} exists with the goal of making it easier to download data
from the AOFM’s datahub.

The package enables you to read most of the datasets from the [AOFM’s
datahub](https://www.aofm.gov.au/data-hub) with the exception of *Other
Historical Datasets.*

## Installation

<!-- You can install readAOFM from [GitHub](https://github.com/) with: -->
<!-- ``` r -->
<!-- # install.packages("devtools") -->
<!-- devtools::install_github("joel23978/readAOFM") -->
<!-- ``` -->

## Example

``` r
library(here)
source(here("script", "tidy_data.R"))

print(read_aofm("tb", "issuance"))
```

    #> # A tibble: 23,322 × 7
    #>    date_held  tender_number maturity   isin         date_settled name      value
    #>    <date>     <chr>         <date>     <chr>        <date>       <chr>     <dbl>
    #>  1 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   coupon   1.5 e1
    #>  2 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   amount_… 1.5 e8
    #>  3 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   amount_… 1.5 e8
    #>  4 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   amount_… 5.22e8
    #>  5 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   coverag… 3.52e0
    #>  6 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   weighte… 1.53e1
    #>  7 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   lowest_… 1.52e1
    #>  8 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   highest… 1.53e1
    #>  9 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   highest… 1.63e1
    #> 10 1982-09-17 TB2           1992-03-16 AU0000XCLQA2 1982-09-22   weighte… 1.55e1
    #> # ℹ 23,312 more rows

The read_aofm function takes up to four arguments:

- security, \## options include; tb, tib, tn, slf, summary, aggregate,
  ownership, retail, term.premium
- type, \## options include; dealt, settlement, issuance, syndication,
  buyback, turnover
- csv = FALSE, \## defaults to FALSE, if TRUE it will output a csv to
  /ouput with the cleaned data
- data.index = index, \## an index of data on the AOFM website, pulled
  from index.R

The function needs to be written to an object like the below:

- Where the excel files has multiple sheets the data is written to a
  list object with a list element for each sheet.
- The “Notes” sheet in the orignal files is not read into R

``` r
tb_issuance <- read_aofm("tb", "issuance")
```

To see the index of files/arguments to pass, use:

``` r
browse_tables()
#>     Argument 1  Argument 2                                 AOFM Category
#> 1      summary        <NA>               End of Financial Year Positions
#> 2    aggregate       dealt                        End of Month Positions
#> 3    aggregate  settlement                        End of Month Positions
#> 4           tb       dealt                        End of Month Positions
#> 5           tb  settlement                        End of Month Positions
#> 6          tib       dealt                        End of Month Positions
#> 7          tib  settlement                        End of Month Positions
#> 8           tn       dealt                        End of Month Positions
#> 9           tn  settlement                        End of Month Positions
#> 10          tb    issuance                            Transactional Data
#> 11        <NA>        <NA>                            Transactional Data
#> 12          tb syndication                            Transactional Data
#> 13          tb     buyback                            Transactional Data
#> 14         tib    issuance                            Transactional Data
#> 15         tib syndication                            Transactional Data
#> 16         tib     buyback                            Transactional Data
#> 17          tn    issuance                            Transactional Data
#> 18      retail        <NA>                            Transactional Data
#> 19         slf        <NA>                            Transactional Data
#> 20   ownership      public Ownership of Australian Government Securities
#> 21   ownership nonresident Ownership of Australian Government Securities
#> 22          tb    turnover                 AGS Secondary Market Turnover
#> 23         tib    turnover                 AGS Secondary Market Turnover
#> 24 termpremium        <NA>                        Term Premium Estimates
#> 25        <NA>        <NA>                    Other Historical Data Sets
#> 26        <NA>        <NA>                    Other Historical Data Sets
#> 27        <NA>        <NA>                    Other Historical Data Sets
#> 28        <NA>        <NA>                    Other Historical Data Sets
#> 29        <NA>        <NA>                    Other Historical Data Sets
#> 30        <NA>        <NA>                    Other Historical Data Sets
#>                                             AOFM Title
#> 1                                    Executive Summary
#> 2                                  Portfolio Aggregate
#> 3                                  Portfolio Aggregate
#> 4                                       Treasury Bonds
#> 5                                       Treasury Bonds
#> 6                               Treasury Indexed Bonds
#> 7                               Treasury Indexed Bonds
#> 8                                       Treasury Notes
#> 9                                       Treasury Notes
#> 10                              Treasury Bond Issuance
#> 11                              Treasury Bond Issuance
#> 12                              Treasury Bond Issuance
#> 13                              Treasury Bond Buybacks
#> 14                      Treasury Indexed Bond Issuance
#> 15                      Treasury Indexed Bond Issuance
#> 16                      Treasury Indexed Bond Buybacks
#> 17                             Treasury Notes Issuance
#> 18                             Retail Buyback Facility
#> 19                         Securities Lending Facility
#> 20            Public Register of Government Borrowings
#> 21                        Non-resident Holdings of AGS
#> 22         Secondary Market Turnover of Treasury Bonds
#> 23 Secondary Market Turnover of Treasury Indexed Bonds
#> 24                              Term Premium Estimates
#> 25                                  Indexation Factors
#> 26                                   RMBS Transactions
#> 27                                       RMBS Auctions
#> 28                                 Interest Rate Swaps
#> 29                                Cross Currency Swaps
#> 30                                  Portfolio Overview
#>                                                                                                                                                                                                                                                    AOFM Description
#> 1                                                                                                                                                                                                                 Overview of AGS outstanding and investments held.
#> 2                                                                                                                                     Dealt Basis. End of month AGS outstanding and investments held. Includes Face Value, Market Value, Delta, Duration and Tenor.
#> 3                                                                                                                                Settlement Basis. End of month AGS outstanding and investments held. Includes Face Value, Market Value, Delta, Duration and Tenor.
#> 4                                                                                                                   Dealt Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.
#> 5                                                                                                              Settlement Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.
#> 6                                                                                                                   Dealt Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.
#> 7                                                                                                              Settlement Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.
#> 8                                                                                                                   Dealt Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.
#> 9                                                                                                              Settlement Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.
#> 10                                                                                                                                                                                                                              Issuance via tender or syndication.
#> 11                                                                                                                                                                                                                               Issuance via conversion or switch.
#> 12                                                                                                                                                                                                          Data from syndicated issues including investor details.
#> 13                                                                                                                                                                                                      Wholesale buybacks via tender, syndication or with the RBA.
#> 14                                                                                                                                                                                                      Issuance via tender, syndication, tap, panel or conversion.
#> 15                                                                                                                                                                                                          Data from syndicated issues including investor details.
#> 16                                                                                                                                                                                                        Wholesale buybacks via syndication or fixed price tender.
#> 17                                                                                                                                                                                                                                             Issuance via tender.
#> 18                                                                                                                                                                                                                    Retail buybacks through the Buyback Facility.
#> 19                                                                                                                                                                                            Bonds lent on an open term basis via the Securities Lending Facility.
#> 20                                                      Beneficial ownership, by country, of all securities issued by the Australian Commonwealth Government and any securities guaranteed by the Commonwealth that are issued by Australian States or Territories.
#> 21                                                                                                                                                                         Non-resident holdings of AGS including adjustments made for activity in the repo market.
#> 22 Survey results from bond market intermediaries detailing their turnover in AGS. This data will be updated quarterly on the last business day of the month with a two month lag (i.e. on the last business day of May, August, November, and February each year).
#> 23 Survey results from bond market intermediaries detailing their turnover in AGS. This data will be updated quarterly on the last business day of the month with a two month lag (i.e. on the last business day of May, August, November, and February each year).
#> 24                                                                                                                                                                 Daily yield decomposition of Australian Treasury Bond term structure and term premium estimates.
#> 25                                                                                                                                                                                                  A time series of indexation factors for Treasury Indexed Bonds.
#> 26                                                                                                                                                       A summary of AOFM participation in Residential Mortgage Backed Security (RMBS) transactions prior to 2020.
#> 27                                                                                                                                                                                                            A summary of AOFM RMBS auction results prior to 2020.
#> 28                                                                                                                                                                                                      AOFM transactions in Australian Dollar Interest Rate Swaps.
#> 29                                                                                                                                                                                                         AOFM transactions in Cross Currency Interest Rate Swaps.
#> 30                                                                                                                                                                         An overview of end of financial year outstanding amounts for AGS on issue prior to 2003.
```

download.R contains two functions:

- download_aofm_xlsx() enables you down a single file (or all data
  files) from the AOFM’s website to a /data subfolder
  - if no argument is passed; it will download all files from the AOFM’s
    webite
  - if an argument with multiple matches is passed it will download all
    matching tables
  - if two arguments are passed (security, type) it will download the
    specific table
- find_file() takes arguemnts for (security, type) and returns a table
  id

## Disclaimer

The AOFM website may, at any time, change in such a way that the package
stops working (esp if they change the structure of the files).

This package is not affiliated with or endorsed by AOFM, all data is
provided under any terms set out on the AOFM website.
