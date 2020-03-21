# Loads time series covid-19 data.

library(readr)
library(tidyr)
library(dplyr)
library(lubridate)
library(tidyselect)

#' Reads cumulative total of COVID-19 cases.
#'
#' Reads cumulative total of COVID-19 confirmed cases by day from a public dataset published by Johns Hopkins University (JHU).
#'
#' @details
#' * Reads a [JHU CSSE](https://github.com/CSSEGISandData/COVID-19) data file, [time_series_19-covid-Confirmed.csv](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv) of confirmed [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) cases.
#' * Reformats data as a [tidy dataset](https://r4ds.had.co.nz/tidy-data.html).
#' * Reformats the column names to [snake case](https://en.wikipedia.org/wiki/Snake_case).
#'
#' @return `tbl` with 6 columns: `country_region`, `province_state`, `lat`, `long`, `date`, `cumulative_total`. Most of the country data, except for China and United States, is not sub-divided by `province_state`, so that column has many `NA` values.
#'
#' @export
read_confirmed_cases <- function() {
  # The source file is "wide" with one column per day.
  # Those date column labels look like:
  #   2/1/20  i.e. mm/dd/yy = Feb 1, 2020
  date_as_column_name_format = "\\d\\d?/\\d\\d?/2\\d"

  # We pivot the table to make it "long" with one
  # observation per row.
  confirmed_cases <- readr::read_csv(
    "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
    ) %>%
    tidyr::pivot_longer(
      cols = tidyselect::matches(date_as_column_name_format),
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


#' Reads cumulative total of COVID-19 deaths.
#'
#' Reads cumulative total of COVID-19 deaths by day from a public dataset published by Johns Hopkins University (JHU).
#'
#' @details
#' * Reads a [JHU CSSE](https://github.com/CSSEGISandData/COVID-19) data file, [time_series_19-covid-Deaths.csv](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv), of confirmed [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) cases.
#' * Reformats data as a [tidy dataset](https://r4ds.had.co.nz/tidy-data.html).
#' * Reformats the column names to [snake case](https://en.wikipedia.org/wiki/Snake_case).
#'
#' @return `tbl` with 6 columns: `country_region`, `province_state`, `lat`, `long`, `date`, `cumulative_total`. Most of the country data, except for China and United States, is not sub-divided by `province_state`, so that column has many `NA` values.
#'
#' @export
read_deaths <- function() {
  # The source file is "wide" with one column per day.
  # Those date column labels look like:
  #   2/1/20  i.e. mm/dd/yy = Feb 1, 2020
  date_as_column_name_format = "\\d\\d?/\\d\\d?/2\\d"

  # We pivot the table to make it "long" with one
  # observation per row.
  deaths <- readr::read_csv(
    "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv"
  ) %>%
    tidyr::pivot_longer(
      cols = tidyselect::matches(date_as_column_name_format),
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
  return(deaths)
}
