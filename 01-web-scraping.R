# web-scraping with R
#
# loading packages

library(rvest)
library(yfR)
library(tidyverse)

# setting the url and xpath

my_url <- 'https://www.fundamentus.com.br/resultado.php'
my_path <- '//*[@id="resultado"]'

out_nodes <- html_nodes(read_html(my_url),
                        xpath = my_path)

df_fund <- html_table(out_nodes)

df_fund <- df_fund[[1]]

glimpse(df_fund)

names(df_fund) <- c("ticker", "Cotacao", "P_L", "P_VP", "PSR", "Div.Yield",
                    "P_Ativo", "P_Cap.Giro", "P_EBIT", "P_AtivCirc.Liq", "EV_EBIT", 
                    "EV_EBITDA" , "MrgEbit", "Mrg.Liq.", "Liq.Corr.", "ROIC", "ROE",
                    "Liq.2meses", "Patrim.Liq", "Div.Brut_Patrim.","Cresc.Rec.5a")

n <- 2:dim(df_fund)[2]

for(i in n){
  df_fund[i] <- lapply(X = df_fund[i], FUN = str_replace_all, pattern = fixed('.'), 
                       replacement = '') 
  df_fund[i] <- lapply(X = df_fund[i], FUN = str_replace_all, pattern = fixed(','), 
                       replacement = '.')
  df_fund[i] <- lapply(X = df_fund[i], FUN = str_replace_all, pattern = fixed('%'), 
                       replacement = '') 
  df_fund[i] <- lapply(X = df_fund[i], FUN = as.numeric)
  
  }

# get IBOVESPA tickers

index_composition <- yfR::yf_index_composition('IBOV')

ibov_tickers <- index_composition$ticker

df_ibov_fund <- df_fund %>% filter(ticker %in% ibov_tickers)
