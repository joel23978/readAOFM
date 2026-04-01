pkgname <- "readAOFM"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('readAOFM')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("browse_tables")
### * browse_tables

flush(stderr()); flush(stdout())

### Name: browse_tables
### Title: Show index of tables from the AOFM website
### Aliases: browse_tables

### ** Examples

## Not run: download_aofm_xlsx()
# return dataframe with list of files/arguments



cleanEx()
nameEx("download_aofm_xlsx")
### * download_aofm_xlsx

flush(stderr()); flush(stdout())

### Name: download_aofm_xlsx
### Title: Download xlsx.xls files from AOFM DataHub
### Aliases: download_aofm_xlsx

### ** Examples

## Not run: download_aofm_xlsx("tb", "issuance")
# downloads AOFM Treasury Bond Issuance data to data/tb_issuance.xlsx
## Not run: download_aofm_xlsx("tb")
# downloads all Treasury Bond data from the AOFM Datahub incl
# issunace, syndication details, position data etc to data/
## Not run: download_aofm_xlsx()
# downloads all data from the AOFM Datahub to data/




cleanEx()
nameEx("find_file")
### * find_file

flush(stderr()); flush(stdout())

### Name: find_file
### Title: Find name of file to download from AOFM
### Aliases: find_file

### ** Examples

## Not run: find_file("tb", "issuance")
# returns "tb_issuance"
## Not run: find_file("tb")
## Not run: returns c("tb_issuance", "tb_syndication", "tb_turnover" .....)
## Not run: find_file()
# returns vector of all filenames



cleanEx()
nameEx("read_aofm")
### * read_aofm

flush(stderr()); flush(stdout())

### Name: read_aofm
### Title: Reads in and cleans any data from the AOFM, returns cleaned in a
###   long format
### Aliases: read_aofm

### ** Examples

## Not run: read_aofm("tb", "issuance")
# downloads Treasury Bond Issunace data from the AOFM
# returns cleaned in a long format




cleanEx()
nameEx("read_eofy")
### * read_eofy

flush(stderr()); flush(stdout())

### Name: read_eofy
### Title: Reads in and cleans the EOFY Positions - Executive Summary data
###   from the AOFM, returns cleaned in a long format
### Aliases: read_eofy

### ** Examples

## Not run: read_eofy("summary")
# downloads EOFY Positions - Executive Summary	data from the AOFM, returns cleaned in a long format




cleanEx()
nameEx("read_eom")
### * read_eom

flush(stderr()); flush(stdout())

### Name: read_eom
### Title: Reads in and cleans the "End of Month Positions" data from the
###   AOFM, returns a list
### Aliases: read_eom

### ** Examples

## Not run:  read_eom("tb_position_dealt")
# downloads Treasury Bond EOM data on a dealt basis from the AOFM
# returns cleaned in a long format
# data is returned as a list with data frame elements for
# FaceValue, MarketValue, Delta, Duration and Tenor
## Not run: read_eom("tb_position_settlement")
# downloads Treasury Bond EOM data on a settlement basis from the
# AOFM, returns cleaned in a long format as a list with elements for each of
# FaceValue, MarketValue, Delta, Duration and Tenor




cleanEx()
nameEx("read_ownership")
### * read_ownership

flush(stderr()); flush(stdout())

### Name: read_ownership
### Title: Reads in and cleans data under "Ownership of Australia
###   Government Securities" from the AOFM, returns cleaned in a long
###   format
### Aliases: read_ownership

### ** Examples

## Not run: read_ownership("ownership_nonresident")




cleanEx()
nameEx("read_premium")
### * read_premium

flush(stderr()); flush(stdout())

### Name: read_premium
### Title: Reads in and cleans data under "Term Premium Estimates" from the
###   AOFM, returns cleaned in a long format
### Aliases: read_premium

### ** Examples

## Not run: read_premium("termpremium")
# downloads Term Premium data from the AOFM, returns cleaned in a long format




cleanEx()
nameEx("read_secondary")
### * read_secondary

flush(stderr()); flush(stdout())

### Name: read_secondary
### Title: Reads in and cleans data under "AGS Secondary Market Turnover"
###   from the AOFM, returns cleaned in a long format
### Aliases: read_secondary

### ** Examples

## Not run: read_secondary("tb_turnover")
# downloads Treasury Bond Turnover data from the AOFM, returns cleaned in a long format




cleanEx()
nameEx("read_syndication")
### * read_syndication

flush(stderr()); flush(stdout())

### Name: read_syndication
### Title: Reads in and cleans Syndication details data under "Transaction
###   Details" from the AOFM, returns cleaned in a long format
### Aliases: read_syndication

### ** Examples

## Not run: read_transactional("tb_syndication")
# downloads Treasury Bond Syndication details data from the AOFM, returns cleaned in a long format




cleanEx()
nameEx("read_transactional")
### * read_transactional

flush(stderr()); flush(stdout())

### Name: read_transactional
### Title: Reads in and cleans data under "Transaction Details" from the
###   AOFM, returns cleaned in a long format (excl. issunace via conversion
###   and syndication details)
### Aliases: read_transactional

### ** Examples

## Not run: read_transactional("tb_issunace")
# downloads Treasury Bond Issunace data from the AOFM, returns cleaned in a long format
## Not run: read_transactional("slf")
# downloads Securities Lending Facility data from the AOFM, returns cleaned in a long format




cleanEx()
nameEx("search_aofm")
### * search_aofm

flush(stderr()); flush(stdout())

### Name: search_aofm
### Title: Search the supported AOFM table catalog
### Aliases: search_aofm

### ** Examples

search_aofm("tb issuance")
search_aofm("issuance")
search_aofm("treasury bond")
search_aofm("inflation")
## Not run: search_aofm("tb issuance", read = TRUE)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
