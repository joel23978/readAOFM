## download data
library(readxl)
library(tidyverse)
library(httr)
library(here)
library(zoo)

source(here::here("script", "index.R"))




####### 1 Find files #####

find_file <- function(security = NULL ## options include; tb, tib, tn, slf, summary, aggregate, ownership, retail, term.premium
                      , type =  NULL ## options include; dealt, settlement, issuance, syndication, buyback, turnover
                      , data.index = index
){
  
  if (is.null(security) != T){
    tmp <- index %>%
      filter(p.security == security)
  } else {
    tmp <- index
  }
  
  if (is.null(type) != T){
    tmp <- tmp %>%
      filter(p.type == type)
  }
  
  
  if (nrow(tmp) == 0) {
    print("The input parameters do not map to a valid table. If unsure, please check valid tables using 'index'")
    return(NULL)
  } else if (nrow(tmp) == 1){
    return(tmp$id)
  } else if (nrow(tmp) > 1) {
    print("The input parameters do not map to a unique table, please add additional parameters. The below print-out shows all tables selected and their parameters.")
    print(tmp %>%
            select(c("p.security", "p.type", "id")))
    return(tmp$id)
  }
  
}







####### 2 Download xlsx files #####

## this downloads a specified table from the aofm as an xlsx and saves in /data
# if no params are passed it will download all data files from aofm datahub
# if non-unique params are passed it will doewnload all matching files
# if invalid params are specified it wil not download any files

download_aofm_xlsx <- function(security = NULL ## options include; tb, tib, tn, slf, summary, aggregate, ownership, retail, term.premium
                               , type =  NULL ## options include; dealt, settlement, issuance, syndication, buyback, turnover
                               , data.index = index
) {
  
  # run find_file function to determine which file to download
  aofm_table <- find_file(security, type, basis, data.index)
  
  # check if /data sub folder exists and create if not
  if (dir.exists("data") == F) {
    dir.create("data")
  }
  
  if (is.null(aofm_table)==T){
    print(aofm_table)
    
  } else {
    for (i in 1:length(aofm_table)){
      file.url <- index %>%
        filter(id == index$id[i]) %>%
        pull(file.path)
      
      file.name <- index$file.save[i]
      download.file(file.url, destfile = here("data", file.name))
    }
    print(paste("The following files have been downloaded to:", here("data")))
    print(aofm_table)
  } 
}
  

