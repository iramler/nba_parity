library(rvest)
library(tidyverse)

standings_url <- "https://www.basketball-reference.com/friv/standings.fcgi?month=2&day=1&year=1980&lg_id=NBA&utm_source=direct&utm_medium=Share&utm_campaign=ShareTool"

standings <- read_html(standings_url) |> 
  html_nodes("table") |>
  html_table() 

standings_tidy <- 
  bind_rows(standings[[1]],standings[[2]]) |> 
  unite("Conference",
        c(`Western Conference`,`Eastern Conference`), 
        na.rm = TRUE) |> 
  mutate(W = as.numeric(W)) |> 
  drop_na(W) |> 
  type_convert(na = c("", "NA","—"))

# reminder: 
# put a pause in the scraper before going to the next season

 View(standings_tidy)
