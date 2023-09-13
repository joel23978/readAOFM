# readAOFM
Download and tidy time series data from the Australian Office of Financial Management in R

An Overview:

index.R provides an index of the data on the AOFM website. 
- Use browse_tables() to view the index
- See https://www.aofm.gov.au/data-hub

download.R contains a function which enables you down a single file (or all data files) from the AOFM's website.
- download_aofm_xlsx()
- specify a specific table (from browse_tables()) to down to /data
- if no argument is passed the function it will download all table to /data

tidy_data.R has 7 function which enable one to read in almost any data you might want from the AOFM:
End of Financial Year Positions:
- read_eofy()
End of Month Positions:
- read_eom()
Transactional Data:
- read_transactional()
Transactional Data - Syndication Details:
- read_syndication()
Ownership of Australian Government Securities;
- read_ownership()
AGS Secondary Market Turnover;
- read_secondary()
Term Premium Estimates:
- read_premium()
Other:
- no function exists to download this data.

the Argument for each of the above files is specified in the "Argument" column from browse_tables() and the relevant function is also listed in browse_tables().

