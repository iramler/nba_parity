# midseason scraping for 1970 and older

library(rvest)
library(tidyverse)

standings_url <- "https://www.basketball-reference.com/friv/standings.fcgi?month=2&day=1&year=1965&lg_id=NBA&utm_source=direct&utm_medium=Share&utm_campaign=ShareTool"

standings <- read_html(standings_url) |> 
  html_elements(xpath = '//*[@id="all_standings"]/div')

standings[[1]] |> 
  html_table() |>
  rename(
    Team = X1, 
    W = X2,
    L = X3, 
    `W/L%` = X4,
    GB = X5,
    PW = X6,
    PL = X7,
    `PS/G` = X8,
    `PA/G` = X9
    ) |>
  mutate(W = as.numeric(W)) |> 
  drop_na(W) |> 
  type_convert(na = c("", "NA","—"))
