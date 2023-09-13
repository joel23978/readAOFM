## read_excel_all_sheets
library(data.table)
library(janitor)
library(tidyverse)
library(here)
library(zoo)
library(stringr)

here::here()



read_excel_allsheets <- function(filename, tibble = FALSE) {
  # I prefer straight data.frames
  # but if you like tidyverse tibbles (the default with read_excel)
  # then just pass tibble = TRUE
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}







####### 1 EOFY data ####

read_eofy <- function(aofm_table
                      , csv = NULL
                      , data.index = index
) {
  
  
  file.url <- index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <- tempfile(fileext = ".xlsx")))
  
  
  tmp1 <- read_excel(aofm_table
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
  
  write_csv(eofy_executive_summary, here("output", "eofy_executive_summary.csv"))
  eofy_executive_summary <<- eofy_executive_summary
  
}








####### 2 EOM data ####

read_eom <- function(aofm_table
                                , csv = NULL
                                , data.index = index
) {
  
  file.url <- index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <<- tempfile(fileext = ".xlsx")))
  tmp1 <- read_excel_allsheets(tmp0)
  
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
      transpose()
    
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
      transpose() 
    
    tmp4 <- tmp3 %>% 
      rbind(tmp1[[i]][(m+1):(nrow(tmp1[[i]])), ] %>%
              `colnames<-`(names(tmp3))
      ) %>%
      mutate(V1 = ifelse(is.na(V1), V2, V1)) %>%
      transpose() %>%
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
    
    assign(output.name,tmp4, envir = parent.frame())
    write_csv(tmp4, here("output", output.name.csv))
  }
}

# for (k in 4:9){
# read_eom_data(index$id[k]
# )
# }

# rm(tmp0, tmp1, tmp2, tmp3, tmp4
#    , output.name, output.name.csv
#    , fiel.url, aofm_table)
# 





####### 3 transactional ####

read_transactional <- function(aofm_table
                     , csv = NULL
                     , data.index = index
) {
  
  file.url <- index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <<- tempfile(fileext = ".xlsx")))

  tmp1 <- read_excel(tmp0
                     , skip = 3
                     , sheet = 1
                     , col_names = as.character(read_excel(tmp0)[1,])
                     , guess_max = 10000
                     ) %>%
    clean_names() 
  
  if (str_detect(aofm_table, "retail_buybacks") == T) {
    tmp2 <- tmp1 %>%
      mutate(settle_date = as.Date(settle_date)
             , security_maturity_date = as.Date(security_maturity_date)
      )

  } else if (str_detect(aofm_table, "securities_lending") == T) {
    tmp2 <- tmp1 %>%
      mutate(start_date = as.Date(start_date)
             , end_date = as.Date(end_date)
             , security_maturity_date = as.Date(security_maturity_date)
      )
    
  } else if (str_detect(aofm_table, "tn_issuance") == T) {
    tmp2 <- tmp1 %>%
      mutate(date_held = as.Date(date_held)
             , date_settled = as.Date(date_settled)
             , maturity = as.Date(maturity)
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
    pivot_longer(!colnames(tmp2 %>% select_if(~!is.numeric(.)))) %>%
    na.omit(value)
  
  output.name <-  aofm_table
  output.name.csv <- paste0(output.name, ".csv")
  
  assign(output.name,tmp3, envir = parent.frame())
  write_csv(tmp3, here("output", output.name.csv))
}

# for (k in c(10, 13:14, 16:19)){
#   print(index$id[k])
#   read_transactional(index$id[k])
# }







####### 4 syndication details ####
# 12 and 15

read_syndication <- function(aofm_table
                               , csv = NULL
                               , data.index = index
) {
  
  file.url <- index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <<- tempfile(fileext = ".xlsx")))
  
  for (i in 1:2){
    output.df <- paste0("tmp", i+2)
    
    tmp1 <- read_excel(tmp0
                       , sheet = i
                       , col_names = F)
    
    tmp2 <- tmp1 %>%
      na.omit() %>%
      transpose() %>%
      row_to_names(row_number = 1)  %>%
      clean_names() %>%
      mutate(pricing_date = as.Date(as.numeric(pricing_date), origin = "1899-12-30")
             , settlement_date = as.Date(as.numeric(settlement_date), origin = "1899-12-30")
             , type = ifelse(i==1, "new_bond", "tap")
      ) 
    assign(output.df, tmp2, envir = parent.frame())
  }
  
  tmp5 <- tmp3 %>%
    rbind(tmp4)
  
  output.name <-  aofm_table
  output.name.csv <- paste0(output.name, ".csv")
  
  assign(output.name,tmp5, envir = parent.frame())
  write_csv(tmp5, here("output", output.name.csv))
}

# for (k in c(12,15)){
#   read_syndication(index$id[k])
# }








####### 5 Secondary market turnover ####

read_secondary <- function(aofm_table
                           , csv = NULL
                           , data.index = index
) {
  
  file.url <- index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <<- tempfile(fileext = ".xlsx")))
  
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
    assign(output.name,tmp2, envir = parent.frame())

  }
  tmp5 <- tmp3 %>%
    rbind(tmp4) 
  
  output.name <-  aofm_table
  output.name.csv <- paste0(output.name, ".csv")
  
  assign(output.name,tmp5, envir = parent.frame())
  write_csv(tmp5, here("output", output.name.csv))
  
}

# for (k in c(22:23)){
#   read_secondary(index$id[k])
# }









####### 6 Term Premium ####
read_premium <- function(aofm_table
                           , csv = NULL
                           , data.index = index
) {
  
  file.url <- index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <<- tempfile(fileext = ".xlsx")))
  
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
    assign(output.name,tmp2, envir = parent.frame())
    
  }
  
  tmp5 <- tmp3 %>%
    rbind(tmp4) %>%
    arrange(date)
  
  output.name <-  aofm_table
  output.name.csv <- paste0(output.name, ".csv")
  
  assign(output.name,tmp5, envir = parent.frame())
  write_csv(tmp5, here("output", output.name.csv))
  
}

#read_premium(index$id[24])



####### 7 Ownership ####
read_ownership <- function(aofm_table
                     , csv = NULL
                     , data.index = index
) {
  
  file.url <- index %>%
    filter(id == aofm_table) %>%
    pull(file.path)
  
  GET(file.url, write_disk(tmp0 <<- tempfile(fileext = ".xlsx")))
  tmp1 <- read_excel_allsheets(tmp0)
  
  if (str_detect(aofm_table, "public_register") == T) {
    sheets <- 1:2
    top_rows <- 1:4
    n <-max(top_rows)
  } else {
    sheets <- 2:4
    top_rows <- 1:4
    n <-max(top_rows) +1
  }
  m <-max(top_rows)
    
  for (i in sheets) {
  output.name <-  paste0(aofm_table
                         , "_"
                         , names(tmp1)[i])
  output.name.csv <- paste0(output.name, ".csv")
  
  
    tmp2 <- tmp1[[i]][top_rows, ] %>%
      transpose()
    
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
      transpose() 

    tmp4 <- tmp3 %>% 
      rbind(tmp1[[i]][(m+1):(nrow(tmp1[[i]])), ] %>%
              `colnames<-`(names(tmp3))
      ) %>%
      mutate(V1 = ifelse(is.na(V1), V2, V1)) %>%
      transpose() %>%
      `colnames<-`(.[1,]) %>%
      row_to_names(row_number = 1) %>%
      pivot_longer(!c(1:(n-1)), names_to = "date") 
    
    if (str_detect(aofm_table, "public_register") == T) {
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
    
    assign(output.name,tmp5, envir = parent.frame())
    write_csv(tmp4, here("output", output.name.csv))
  }
}

for (k in 20:21){
read_ownership(index$id[k])
}


####### 8 Other ####
## 













