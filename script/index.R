## an index dataframe

index <- data.frame(
  p.security = c(
    "summary"
    , "aggregate"
    , "aggregate"
    , "tb"
    , "tb"
    , "tib"
    , "tib"
    , "tn"
    , "tn"
    , "tb"
    , NA
    , "tb"
    , "tb"
    , "tib"
    , "tib"
    , "tib"
    , "tn"
    , "retail"
    , "slf"
    , "ownership"
    , "ownership"
    , "tb"
    , "tib"
    , "termpremium"
    , NA
    , NA
    , NA
    , NA
    , NA
    , NA
  ),
  p.type = c(
    NA    
    , "dealt"
    , "settlement"
    , "dealt"
    , "settlement"
    , "dealt"
    , "settlement"
    , "dealt"
    , "settlement"
    , "issuance"
    , NA
    , "syndication"
    , "buyback"
    , "issuance"
    , "syndication"
    , "buyback"
    , "issuance"
    , NA  
    , NA
    , "public"
    , "nonresident"
    , "turnover"
    , "turnover"
    , NA  
    , NA
    , NA
    , NA  
    , NA
    , NA
    , NA  
  ),
  id = c(
    "summary",
    "aggregate_position_dealt",
    "aggregate_position_settlement",
    "tb_position_dealt",
    "tb_position_settlement",
    "tib_position_dealt",
    "tib_position_settlement",
    "tn_position_dealt",
    "tn_position_settlement",
    "tb_issuance",
    "tb_issuance_conversion",
    "tb_syndication",
    "tb_buyback",
    "tib_issuance",
    "tib_syndication",
    "tib_buyback",
    "tn_issuance",
    "retail",
    "slf",
    "ownership_public",
    "ownership_nonresident",
    "tb_turnover",
    "tib_turnover",
    "termpremium",
    "indexation_factors",
    "rmbs_transactions",
    "rmbs_auctions",
    "interest_rate_swaps",
    "cross_currency_swaps",
    "portfolio_overview"
  ),
  fn = c(
    "read_eofy",
    "read_eom",
    "read_eom",
    "read_eom",
    "read_eom",
    "read_eom",
    "read_eom",
    "read_eom",
    "read_eom",
    "read_transactional",
    "no function exists",
    "read_syndication",
    "read_transactional",
    "read_transactional",
    "read_syndication",
    "read_transactional",
    "read_transactional",
    "read_transactional",
    "read_transactional",
    "read_ownership",
    "read_ownership",
    "read_secondary",
    "read_secondary",
    "read_premium",
    "no function exists",
    "no function exists",
    "no function exists",
    "no function exists",
    "no function exists",
    "no function exists"
  ),
  category =  c(
    "End of Financial Year Positions",
    "End of Month Positions",
    "End of Month Positions",
    "End of Month Positions",
    "End of Month Positions",
    "End of Month Positions",
    "End of Month Positions",
    "End of Month Positions",
    "End of Month Positions",
    "Transactional Data",
    "Transactional Data",
    "Transactional Data",
    "Transactional Data",
    "Transactional Data",
    "Transactional Data",
    "Transactional Data",
    "Transactional Data",
    "Transactional Data",
    "Transactional Data",
    "Ownership of Australian Government Securities",
    "Ownership of Australian Government Securities",
    "AGS Secondary Market Turnover",
    "AGS Secondary Market Turnover",
    "Term Premium Estimates",
    "Other Historical Data Sets",
    "Other Historical Data Sets",
    "Other Historical Data Sets",
    "Other Historical Data Sets",
    "Other Historical Data Sets",
    "Other Historical Data Sets"
  ),
  title = c(
    "Executive Summary",
    "Portfolio Aggregate",
    "Portfolio Aggregate",
    "Treasury Bonds",
    "Treasury Bonds",
    "Treasury Indexed Bonds",
    "Treasury Indexed Bonds",
    "Treasury Notes",
    "Treasury Notes",
    "Treasury Bond Issuance",
    "Treasury Bond Issuance",
    "Treasury Bond Issuance",
    "Treasury Bond Buybacks",
    "Treasury Indexed Bond Issuance",
    "Treasury Indexed Bond Issuance",
    "Treasury Indexed Bond Buybacks",
    "Treasury Notes Issuance",
    "Retail Buyback Facility",
    "Securities Lending Facility",
    "Public Register of Government Borrowings",
    "Non-resident Holdings of AGS",
    "Secondary Market Turnover of Treasury Bonds",
    "Secondary Market Turnover of Treasury Indexed Bonds",
    "Term Premium Estimates",
    "Indexation Factors",
    "RMBS Transactions",
    "RMBS Auctions",
    "Interest Rate Swaps",
    "Cross Currency Swaps",
    "Portfolio Overview"
  ),
  despription =  c(
    "Overview of AGS outstanding and investments held.",
    "Dealt Basis. End of month AGS outstanding and investments held. Includes Face Value, Market Value, Delta, Duration and Tenor.",
    "Settlement Basis. End of month AGS outstanding and investments held. Includes Face Value, Market Value, Delta, Duration and Tenor.",
    "Dealt Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.",
    "Settlement Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.",
    "Dealt Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.",
    "Settlement Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.",
    "Dealt Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.",
    "Settlement Basis. End of month outstanding volume for each security type and maturity. Includes Face Value, Market Value, Delta, Duration and Tenor.",
    "Issuance via tender or syndication.",
    "Issuance via conversion or switch.",
    "Data from syndicated issues including investor details.",
    "Wholesale buybacks via tender, syndication or with the RBA.",
    "Issuance via tender, syndication, tap, panel or conversion.",
    "Data from syndicated issues including investor details.",
    "Wholesale buybacks via syndication or fixed price tender.",
    "Issuance via tender.",
    "Retail buybacks through the Buyback Facility.",
    "Bonds lent on an open term basis via the Securities Lending Facility.",
    "Beneficial ownership, by country, of all securities issued by the Australian Commonwealth Government and any securities guaranteed by the Commonwealth that are issued by Australian States or Territories.",
    "Non-resident holdings of AGS including adjustments made for activity in the repo market.",
    "Survey results from bond market intermediaries detailing their turnover in AGS. This data will be updated quarterly on the last business day of the month with a two month lag (i.e. on the last business day of May, August, November, and February each year).",
    "Survey results from bond market intermediaries detailing their turnover in AGS. This data will be updated quarterly on the last business day of the month with a two month lag (i.e. on the last business day of May, August, November, and February each year).",
    "Daily yield decomposition of Australian Treasury Bond term structure and term premium estimates.",
    "A time series of indexation factors for Treasury Indexed Bonds.",
    "A summary of AOFM participation in Residential Mortgage Backed Security (RMBS) transactions prior to 2020.",
    "A summary of AOFM RMBS auction results prior to 2020.",
    "AOFM transactions in Australian Dollar Interest Rate Swaps.",
    "AOFM transactions in Cross Currency Interest Rate Swaps.",
    "An overview of end of financial year outstanding amounts for AGS on issue prior to 2003."
  ),
  file.path = c(
    "https://www.aofm.gov.au/media/530",
    "https://www.aofm.gov.au/media/577",
    "https://www.aofm.gov.au/media/579",
    "https://www.aofm.gov.au/media/578",
    "https://www.aofm.gov.au/media/580",
    "https://www.aofm.gov.au/media/581",
    "https://www.aofm.gov.au/media/582",
    "https://www.aofm.gov.au/media/563",
    "https://www.aofm.gov.au/media/564",
    "https://www.aofm.gov.au/media/591",
    "https://www.aofm.gov.au/media/523",
    "https://www.aofm.gov.au/media/632",
    "https://www.aofm.gov.au/media/424",
    "https://www.aofm.gov.au/media/429",
    "https://www.aofm.gov.au/media/631",
    "https://www.aofm.gov.au/media/433",
    "https://www.aofm.gov.au/media/430",
    "https://www.aofm.gov.au/media/566",
    "https://www.aofm.gov.au/media/568",
    "https://www.aofm.gov.au/media/590",
    "https://www.aofm.gov.au/media/589",
    "https://www.aofm.gov.au/media/587",
    "https://www.aofm.gov.au/media/588",
    "https://www.aofm.gov.au/media/575",
    "https://www.aofm.gov.au/media/651",
    "https://www.aofm.gov.au/media/538",
    "https://www.aofm.gov.au/media/527",
    "https://www.aofm.gov.au/media/524",
    "https://www.aofm.gov.au/media/526",
    "https://www.aofm.gov.au/media/522"
  )
  , file.save = c(
    "summary.xlsx",
    "aggregate_position_dealt.xlsx",
    "aggregate_position_settlement.xlsx",
    "tb_position_dealt.xlsx",
    "tb_position_settlement.xlsx",
    "tib_position_dealt.xlsx",
    "tib_position_settlement.xlsx",
    "tn_position_dealt.xlsx",
    "tn_position_settlement.xlsx",
    "tb_issuance.xlsx",
    "tb_issuance_conversion.xls",
    "tb_syndication.xlsx",
    "tb_buyback.xlsx",
    "tib_issuance.xlsx",
    "tib_syndication.xlsx",
    "tib_buyback.xlsx",
    "tn_issuance.xlsx",
    "retail.xlsx",
    "slf.xlsx",
    "ownership_public.xlsx",
    "ownership_nonresident.xlsx",
    "tb_turnover.xlsx",
    "tib_turnover.xlsx",
    "termpremium.xlsx",
    "indexation_factors.xlsx",
    "rmbs_transactions.xls",
    "rmbs_auctions.xlsx",
    "interest_rate_swaps.xls",
    "cross_currency_swaps.xls",
    "portfolio_overview.xlsx"
  )
 ) #%>%
#   mutate(output.name = paste(param.1, param.2, param.3, sep="_") %>%
#            str_replace_all(., "_NA", "") %>%
#            str_replace_all(., "NA", "")
#            )  


index_nav <- index %>%
  select(c(1:2, 5:7)) %>%
  `colnames<-`(c("Argument 1", "Argument 2", "AOFM Category", "AOFM Title", "AOFM Description"))



##### print index ######

browse_tables <- function(x = index_nav){
  print(x)
}





