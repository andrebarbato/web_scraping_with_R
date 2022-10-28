# web-scraping with R
#
# loading packages

library(rvest)
library(yfR)
library(dplyr)

# get IBOVESPA tickers

index_composition <- yfR::yf_index_composition('IBOV')

ibov_tickers <- index_composition$ticker

# setting the url and xpath

my_url <- 'https://www.fundamentus.com.br/resultado.php'
my_path <- '//*[@id="resultado"]'

out_nodes <- html_nodes(read_html(my_url),
                        xpath = my_path)

df_ibov_fund <- html_table(out_nodes)

df_ibov_fund <- df_ibov_fund[[1]]

glimpse(df_ibov_fund)


