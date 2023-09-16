## read_excel_all_sheets
library(data.table)
library(janitor)
library(tidyverse)
library(here)
library(zoo)
library(stringr)

source(here::here("script", "index.R"))
source(here::here("script", "download.R"))



####### .0 baseline functions ####

read_excel_allsheets <- function(filename, tibble = FALSE) {
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

not_all_na <- function(x) any(!is.na(x))








####### .1 EOFY data ####
read_eofy <- function(aofm_table
                      , csv = F
                      , data.index = index
) {
  
  
  file.url <- data.index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <- tempfile(fileext = ".xlsx")))
  
  
  tmp1 <- read_excel(tmp0
                     , skip = 1
                     , sheet = 1) 
  ##### this function is so fucked but it's functional
  for (i in c(3:1,4)){
    if (i >1){
      tmp1[i] <- ifelse(is.na(tmp1[[i-1]])==F & is.na(tmp1[[i]])==T
                        , tmp1[[i-1]]
                        , tmp1[[i]]
      )
    }
    tmp1[i] <- na.locf(tmp1[i], na.rm=F)
  }
  
  eofy_executive_summary <- tmp1 %>%
    pivot_longer(!c(1:4), names_to = "date") %>%
    mutate(date = as.Date(as.numeric(date), origin = "1899-12-30")) %>%
    distinct() %>%
    mutate_at(vars(value), ~replace_na(., 0)) %>%
    na.omit()
  
  if (is.null(csv)!=T){
    write_csv(eofy_executive_summary, here("output", "eofy_executive_summary.csv"))
  }
  return(eofy_executive_summary)
  
}








####### .2 EOM data ####
read_eom <- function(aofm_table
                                , csv = F
                                , data.index = index
) {
  
  file.url <- data.index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <- tempfile(fileext = ".xlsx")))
  tmp1 <- read_excel_allsheets(tmp0)
  
  return.data <- list()
  for (i in 2:5) {
    
    output.name <-  paste0(aofm_table
                           , "_"
                           , names(tmp1)[i])
    output.name.csv <- paste0(output.name, ".csv")
    
    if (str_detect(aofm_table, "tb|tib") == T) {
      m <- 5
    } else {
      m <- 4
    }
    
    tmp2 <- tmp1[[i]][1:m, ] %>%
      data.table::transpose()
    
    for (j in c(3:1,(4:m))){
      if (j >1){
        tmp2[j] <- ifelse(is.na(tmp2[[j-1]])==F & is.na(tmp2[[j]])==T
                          , tmp2[[j-1]]
                          , tmp2[[j]]
        )
      }
      tmp2[j] <- na.locf(tmp2[j], na.rm=F)
    }
    
    tmp3 <- tmp2 %>%
      data.table::transpose() 
    
    tmp4 <- tmp3 %>% 
      rbind(tmp1[[i]][(m+1):(nrow(tmp1[[i]])), ] %>%
              `colnames<-`(names(tmp3))
      ) %>%
      mutate(V1 = ifelse(is.na(V1), V2, V1)) %>%
      data.table::transpose() %>%
      `colnames<-`(.[1,]) %>%
      row_to_names(row_number = 1) %>%
      pivot_longer(!c(1:m), names_to = "date") %>%
      mutate(date = as.Date(as.numeric(date), origin = "1899-12-30")) %>%
      distinct() %>%
      mutate(value = as.numeric(value)) %>%
      na.omit()
    
    if (str_detect(aofm_table, "tb|tib|tn") == T) {
     tmp4$Maturity <- as.character(as.Date(as.numeric(tmp4$Maturity), origin = "1899-12-30"))
     tmp4$Maturity <- replace_na(tmp4$Maturity, "total")
    } 
    
    return.data[[i-1]] <- tmp4
    names(return.data)[i-1] <- output.name
    
    if (is.null(csv)!=T){
      write_csv(tmp4, here("output", output.name.csv))
    }
  }
  
  return(return.data)
  
}













####### .3 transactional ####
read_transactional <- function(aofm_table
                     , csv = F
                     , data.index = index
) {
  
  file.url <- data.index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <- tempfile(fileext = ".xlsx")))

  tmp1 <- read_excel(tmp0
                     , skip = 3
                     , sheet = 1
                     , col_names = as.character(read_excel(tmp0)[1,])
                     , guess_max = 10000
                     ) %>%
    clean_names() 
  
  if (str_detect(aofm_table, "retail") == T) {
    tmp2 <- tmp1 %>%
      mutate(settle_date = as.Date(settle_date)
             , security_maturity_date = as.Date(security_maturity_date)
      )

  } else if (str_detect(aofm_table, "slf") == T) {
    tmp2 <- tmp1 %>%
      mutate(start_date = as.Date(start_date)
             , end_date = as.Date(end_date)
             , security_maturity_date = as.Date(security_maturity_date)
      )
    
  } else if (str_detect(aofm_table, "tn_issuance") == T) {
    tmp2 <- tmp1 %>%
      mutate(date_held = as.Date(as.numeric(date_held), origin = "1899-12-31")
             , date_settled = as.Date(as.numeric(date_settled), origin = "1899-12-31")
             , maturity = as.Date(as.numeric(maturity), origin = "1899-12-31")
      ) %>%
      mutate_if(is.logical, as.numeric)
    
  } else {
    tmp2 <- tmp1 %>%
      mutate(maturity = as.Date(as.numeric(maturity), origin = "1899-12-31")
             , date_settled = as.Date(as.numeric(date_settled), origin = "1899-12-31")
             , date_held = as.Date(as.numeric(date_held), origin = "1899-12-31")
      )
  }
 
  tmp3 <- tmp2 %>%
    select(where(not_all_na)) %>%
    pivot_longer(!colnames((.) %>% select_if(~!is.numeric(.)))) %>%
    na.omit(value)
  
  if (is.null(csv)!=T){
    output.name.csv <- paste0(aofm_table, ".csv")
    write_csv(tmp3, here("output", output.name.csv))
  }
  
  return(tmp3)
}









####### .4 syndication details ####
read_syndication <- function(aofm_table
                               , csv = F
                               , data.index = index
) {
  
  file.url <- data.index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <- tempfile(fileext = ".xlsx")))
  
  for (i in 1:2){
    output.df <- paste0("tmp", i+2)
    
    tmp1 <- read_excel(tmp0
                       , sheet = i
                       , col_names = F)
    
    tmp2 <- tmp1 %>%
      na.omit() %>%
      data.table::transpose() %>%
      row_to_names(row_number = 1)  %>%
      clean_names() %>%
      mutate(pricing_date = as.Date(as.numeric(pricing_date), origin = "1899-12-30")
             , settlement_date = as.Date(as.numeric(settlement_date), origin = "1899-12-30")
             , type = ifelse(i==1, "new_bond", "tap")
      ) 
    assign(output.df, tmp2)
  }
  
  tmp5 <- tmp3 %>%
    rbind(tmp4)
  
  if (is.null(csv)!=T){
    output.name.csv <- paste0(aofm_table, ".csv")
    write_csv(tmp5, here("output", output.name.csv))
  }
  
  return(tmp5)
  
}









####### .5 Secondary market turnover ####
read_secondary <- function(aofm_table
                           , csv = F
                           , data.index = index
) {
  
  file.url <- data.index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <- tempfile(fileext = ".xlsx")))
  
  for (i in 2:3){
    tmp1 <- read_excel(tmp0
                       , sheet = i
                       , skip = ifelse(str_detect(aofm_table, "tib") ==T, 3, 1)
                       ) %>%
      `colnames<-`(c("period", colnames(.)[2:ncol(.)])) %>%
      mutate(period = as.Date(period)
             , group = ifelse(i==2, "tenor", "investor_type")
      )  
    
    tmp2 <- tmp1 %>%
      pivot_longer(!colnames(tmp1 %>% select_if(~!is.numeric(.)))) 
      
    output.name <-  paste0("tmp", i+1)
    assign(output.name,tmp2)

  }
  tmp5 <- tmp3 %>%
    rbind(tmp4) 
  
  if (is.null(csv)!=T){
    output.name.csv <- paste0(aofm_table, ".csv")
    write_csv(tmp5, here("output", output.name.csv))
  }
  
  return(tmp5)
  
}








####### .6 Term Premium ####
read_premium <- function(aofm_table
                           , csv = F
                           , data.index = index
) {
  
  file.url <- data.index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <- tempfile(fileext = ".xlsx")))
  
  for (i in 1:2){
    tmp1 <- read_excel(tmp0
                       , sheet = i
                       , skip = 1
    ) %>%
      clean_names() %>%
      mutate(date = as.Date(date)
             , type = colnames(read_excel(tmp0, sheet = i, range = cell_rows(1)))[1]) 
    
    tmp2 <- tmp1 %>%
      pivot_longer(!colnames(tmp1 %>% select_if(~!is.numeric(.)))) %>%
      na.omit(value) 

    output.name <-  paste0("tmp", i+2)
    assign(output.name,tmp2)
    
  }
  
  tmp5 <- tmp3 %>%
    rbind(tmp4) %>%
    arrange(date)
  
  if (is.null(csv)!=T){
    output.name.csv <- paste0(aofm_table, ".csv")
    write_csv(tmp5, here("output", output.name.csv))
  }
  
  return(tmp5)
  
}









####### .7 Ownership ####
read_ownership <- function(aofm_table
                     , csv = F
                     , data.index = index
) {
  
  file.url <- data.index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <- tempfile(fileext = ".xlsx")))
  tmp1 <- read_excel_allsheets(tmp0)
  
  if (str_detect(aofm_table, "public") == T) {
    sheets <- 1:2
    top_rows <- 1:4
    n <-max(top_rows)
  } else {
    sheets <- 2:4
    top_rows <- 1:4
    n <-max(top_rows) +1
  }
  m <-max(top_rows)
    
  return.data <- list()
  for (i in sheets) {
    output.name <-  paste0(aofm_table
                         , "_"
                         , names(tmp1)[i])
  output.name.csv <- paste0(output.name, ".csv")
  
  
    tmp2 <- tmp1[[i]][top_rows, ] %>%
      data.table::transpose()
    
    for (j in c(3:1,(4:m))){
      if (j >1){
        tmp2[j] <- ifelse(is.na(tmp2[[j-1]])==F & is.na(tmp2[[j]])==T
                          , tmp2[[j-1]]
                          , tmp2[[j]]
        )
      }
      tmp2[j] <- na.locf(tmp2[j], na.rm=F)
    }
    
    tmp3 <- tmp2 %>%
      data.table::transpose() 

    tmp4 <- tmp3 %>% 
      rbind(tmp1[[i]][(m+1):(nrow(tmp1[[i]])), ] %>%
              `colnames<-`(names(tmp3))
      ) %>%
      mutate(V1 = ifelse(is.na(V1), V2, V1)) %>%
      data.table::transpose() %>%
      `colnames<-`(.[1,]) %>%
      row_to_names(row_number = 1) %>%
      pivot_longer(!c(1:(n-1)), names_to = "date") 
    
    if (str_detect(aofm_table, "public") == T) {
      tmp5 <- tmp4 %>%
        mutate(date = as.Date(as.numeric(date), origin = "1899-12-30")) %>%
        distinct() %>%
        mutate(value = as.numeric(value)) %>%
        na.omit()
    } else {
      tmp5 <- tmp4 %>%
        mutate(date = as.Date(as.POSIXct(as.numeric(date), origin="1970-01-01"))) %>%
        distinct() %>%
        mutate(value = as.numeric(value)) %>%
        na.omit()
    }
    
    if(aofm_table == "ownership_nonresident"){
      return.data[[i-1]] <- tmp5
      names(return.data)[i-1] <- output.name
    } else {
      return.data[[i]] <- tmp5
      names(return.data)[i] <- output.name
    }
    
    if (is.null(csv)!=T){
      write_csv(tmp5, here("output", output.name.csv))
    }
  }

  return(return.data)

}







####### .10 daddy function #####
read_aofm <- function(security = NULL
                      , type = NULL
                      , csv = F
                      , data.index = index
) {
  
  # Use the find_file function to get the appropriate table(s) to download
  table_id <- find_file(security, type, data.index)
  
  # if no table returned then exit function
  if (is.null(table_id)) {
    # No valid table found, return NULL
    return(NULL)
    #if we return a table then run through using the appropriate function, use a for loop so user can download multiple files into R at once
  } else {
    
    if(length(table_id) == 1){
      
      child_fn <- data.index %>%
        filter(id == table_id) %>%
        pull(fn)
      
      if (child_fn == "read_eofy") {
        return(read_eofy(aofm_table = table_id))
        
      } else if (child_fn == "read_eom") {
        return(read_eom(aofm_table = table_id))
        
      } else if (child_fn == "read_transactional") {
        return(read_transactional(aofm_table = table_id))
        
      } else if (child_fn == "read_syndication") {
        return(read_syndication(aofm_table = table_id))
        
      } else if (child_fn == "read_ownership") {
        return(read_ownership(aofm_table = table_id))
        
      } else if (child_fn == "read_secondary") {
        return(read_secondary(aofm_table = table_id))
        
      } else if (child_fn == "read_premium") {
        return(read_premium(aofm_table = table_id))
        
      } else {
        print("Error: No function exists")
        return(NULL)
        
      }
    } 
  }
}










####### looped version (doesnt work) #####
# read_aofm <- function(security = NULL
#                       , type = NULL
#                       , basis = NULL
#                       , data.index = index
# ) {
#   
#   # Use the find_file function to get the appropriate table(s) to download
#   table_id <- find_file(security, type, basis, data.index)
#   
#   # if no table returned then exit function
#   if (is.null(table_id)) {
#     # No valid table found, return NULL
#     return(NULL)
#     #if we return a table then run through using the appropriate function, use a for loop so user can download multiple files into R at once
#   } else {
#     
#     for (k in 1:length(table_id)){
#       
#       child_fn <- data.index %>%
#         filter(id == table_id[k]) %>%
#         pull(fn)
#       
#       print(table_id[k]) 
#       print(child_fn)
#       
#       if (child_fn == "read_eofy") {
#         table_return <- read_eofy(aofm_table = table_id[k])
#         
#       } else if (child_fn == "read_eom") {
#         table_return <- read_eom(aofm_table = table_id[k])
#         
#       } else if (child_fn == "read_transactional") {
#         table_return <- read_transactional(aofm_table = table_id[k])
#         
#       } else if (child_fn == "read_syndication") {
#         table_return <- read_syndication(aofm_table = table_id[k])
#         
#       } else if (child_fn == "read_ownership") {
#         table_return <- read_ownership(aofm_table = table_id[k])
#         
#       } else if (child_fn == "read_secondary") {
#         table_return <- read_secondary(aofm_table = table_id[k])
#         
#       } else if (child_fn == "read_premium") {
#         table_return <- read_premium(aofm_table = table_id[k])
#         
#       } else {
#         print("Error: No function exists")
#         return(NULL)
#         
#       }
#     } 
#   }
# 
#   print("The following table(s) has been added to your global envrionment")
#   print(table_id)
#   assign(table_id, table_return)
#   rm(tmp0)
# 
# 
#   if (length(table_id) == 1){
#     return(table_return)
#   }
# 
# }