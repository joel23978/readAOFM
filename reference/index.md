# Package index

## Main Interface

- [`read_aofm()`](https://joel23978.github.io/readAOFM/reference/read_aofm.md)
  : Reads in and cleans any data from the AOFM, returns cleaned in a
  long format
- [`search_aofm()`](https://joel23978.github.io/readAOFM/reference/search_aofm.md)
  : Search the supported AOFM table catalog
- [`download_aofm_xlsx()`](https://joel23978.github.io/readAOFM/reference/download_aofm_xlsx.md)
  : Download xlsx.xls files from AOFM DataHub

## Table Readers

- [`read_eofy()`](https://joel23978.github.io/readAOFM/reference/read_eofy.md)
  : Reads in and cleans the EOFY Positions - Executive Summary data from
  the AOFM, returns cleaned in a long format
- [`read_eom()`](https://joel23978.github.io/readAOFM/reference/read_eom.md)
  : Reads in and cleans the "End of Month Positions" data from the AOFM,
  returns a list
- [`read_transactional()`](https://joel23978.github.io/readAOFM/reference/read_transactional.md)
  : Reads in and cleans data under "Transaction Details" from the AOFM,
  returns cleaned in a long format (excl. issunace via conversion and
  syndication details)
- [`read_syndication()`](https://joel23978.github.io/readAOFM/reference/read_syndication.md)
  : Reads in and cleans Syndication details data under "Transaction
  Details" from the AOFM, returns cleaned in a long format
- [`read_ownership()`](https://joel23978.github.io/readAOFM/reference/read_ownership.md)
  : Reads in and cleans data under "Ownership of Australia Government
  Securities" from the AOFM, returns cleaned in a long format
- [`read_secondary()`](https://joel23978.github.io/readAOFM/reference/read_secondary.md)
  : Reads in and cleans data under "AGS Secondary Market Turnover" from
  the AOFM, returns cleaned in a long format
- [`read_premium()`](https://joel23978.github.io/readAOFM/reference/read_premium.md)
  : Reads in and cleans data under "Term Premium Estimates" from the
  AOFM, returns cleaned in a long format

## Helpers

- [`find_file()`](https://joel23978.github.io/readAOFM/reference/find_file.md)
  : Find name of file to download from AOFM
- [`browse_tables()`](https://joel23978.github.io/readAOFM/reference/browse_tables.md)
  : Show index of tables from the AOFM website
- [`read_excel_allsheets()`](https://joel23978.github.io/readAOFM/reference/read_excel_allsheets.md)
  : Read multiple excel sheet to a list object, cc Ralf Stubner on
  StackOverflow
- [`not_all_na()`](https://joel23978.github.io/readAOFM/reference/not_all_na.md)
  : Select columns which dont have all NA values, cc zack on
  StackOverflow
