# readAOFM
Download and tidy time series data from the Australian Office of Financial Management in R

The package uses a single function: read_aofm() which takes three arguments:
- security, ## options include; tb, tib, tn, slf, summary, aggregate, ownership, retail, term.premium
- type, ## options include; dealt, settlement, issuance, syndication, buyback, turnover
- csv = FALSE, ## defaults to FALSE, if TRUE it will output a csv to /ouput with the cleaned data
- data.index = index, ## an index of data on the AOFM website, pulled from index.R
               
index.R provides an index of the data on the AOFM website. 
- Use browse_tables() to view the index
- See https://www.aofm.gov.au/data-hub

download.R contains two functions:
- download_aofm_xlsx() enables you down a single file (or all data files) from the AOFM's website to a /data subfolder
  - if no argument is passed; it will download all files from the AOFM's webite
  - if an argument with multiple matches is passed it will download all matching tables
  - if two arguments are passed (security, type) it will download the specific table
- find_file() takes arguemnts for (security, type) and returns a table id

