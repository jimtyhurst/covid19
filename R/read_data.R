# Loads time series covid-19 data.

library(readr)
library(tidyr)
library(dplyr)
library(lubridate)

read_confirmed_cases <- function() {
    confirmed_cases <- readr::read_csv(
      "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
      ) %>% 
      tidyr::pivot_longer(
        cols = ends_with("/20"),
        names_to = "date_chr",
        values_to = "cumulative_total"
      ) %>% 
      dplyr::mutate(
        date = lubridate::mdy(date_chr),
        cumulative_total = as.integer(cumulative_total)
      ) %>% 
      dplyr::select(
        country_region = `Country/Region`,
        province_state = `Province/State`,
        lat = `Lat`,
        long = `Long`,
        date,
        cumulative_total
      )
    return(confirmed_cases)
}
