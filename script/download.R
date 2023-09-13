## download data
library(readxl)
library(tidyverse)
library(httr)
library(here)
library(zoo)

source(here::here("script", "index.R"))




##### download aofm data ######

## this downloads a specified table from the aofm as an xlsx and saves in /data
# if no file is specified it'll download all the files lol
download_aofm_xlsx <- function(aofm_table = NULL
                               , data.index = index
                               ) {
  if (dir.exists("data") == F) {
    dir.create("data")
  }
  
  if (is.null(aofm_table)==T){
    for (i in 1:nrow(index)){
      
      file.url <- index %>%
        filter(id == index$id[i]) %>%
        pull(file.path)
      
      file.name <- index$file.save[i]
      download.file(file.url, destfile = here("data", file.name))
    }
  } else {
    file.url <- index %>%
      filter(id == aofm_table) %>%
      pull(file.path)
    
    file.name <- index$file.save[i]
    download.file(file.url, destfile = here("data", file.name))
  }
}




