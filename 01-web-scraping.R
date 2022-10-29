# web-scraping with R
#
# loading packages

library(rvest)
library(yfR)
library(tidyverse)

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

names(df_ibov_fund) <- c("ticker", "Cotacao", "P_L", "P_VP", "PSR", "Div.Yield",
                         "P_Ativo", "P_Cap.Giro", "P_EBIT", "P_Ativ Circ.Liq", "EV_EBIT", 
                         "EV_EBITDA" , "Mrg Ebit", "Mrg. Liq.", "Liq. Corr.",  "ROIC", "ROE",
                         "Liq.2meses", "Patrim. Liq", "Div.Brut_Patrim.","Cresc. Rec.5a")

n <- dim(df_ibov_fund)[2]

df_ibov_fund_original <- df_ibov_fund
df_ibov_fund_original -> df_ibov_fund


df_ibov_fund$Cotacao <- sapply(X = df_ibov_fund$Cotacao, 
                               FUN = str_replace_all, pattern = '.',
                               replacement = '')

df_ibov_fund <- as.numeric(sub(x = df_ibov_fund$Cotacao,pattern = ',', 
                            replacement = '.'))
