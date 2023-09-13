library(here)
library(ggplot2)

source(here::here("script", "tidy_data.R"))

view(browse_tables())

read_transactional("transactional_tb_issuance_tender_syn")


## Treasury Bond Coverage Ratio's
p <- transactional_tb_issuance_tender_syn %>%
  filter(name == "coverage_ratio") %>%
  ggplot(aes(x = date_held
             , y = value
             , colour = as.numeric(difftime(maturity, date_held))/365
  )) +
  geom_point() +
  theme_minimal() +
  xlab("Issuance date") +
  ylab("Coverage ratio") + 
  guides(colour=guide_legend(title="Tenor (yrs)")) +
  ggtitle("AOFM Treasury Bond Issuance - Coverage Ratio")
p


## Treasury Bond Annual Issuance Volume
q <- transactional_tb_issuance_tender_syn %>%
  filter(name == "amount_allotted") %>%
  mutate(year = year(date_held)) %>%
  group_by(year) %>%
  summarise(value = sum(value)) %>%
  ggplot(aes(x = year
             , y = value
  )) +
  geom_col() +
  theme_minimal() +
  xlab("Issuance date") +
  ylab("Issunace Volume") + 
  ggtitle("AOFM Treasury Bond Issuance - Annual Volume")
q

