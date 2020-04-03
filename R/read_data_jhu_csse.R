# Loads time series covid-19 data.

#' Reads cumulative total of COVID-19 cases.
#'
#' Reads cumulative total of COVID-19 confirmed cases by day from a public dataset published by Johns Hopkins University (JHU).
#'
#' @details
#' * Reads a [JHU CSSE](https://github.com/CSSEGISandData/COVID-19) data file, [time_series_covid19_confirmed_global.csv](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv) of confirmed [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) cases.
#' * Reformats data as a [tidy dataset](https://r4ds.had.co.nz/tidy-data.html).
#' * Reformats the column names to [snake case](https://en.wikipedia.org/wiki/Snake_case).
#'
#' @return `tbl` with 6 columns:
#' * `country_region` : (character)
#' * `province_state` : (character)
#' * `lat` : (numeric) latitude
#' * `long` : (numeric) longitude
#' * `date` : (Date)
#' * `cumulative_total` : (integer) total number of confirmed cases that occurred
#'     up to and including the given date.
#'
#' Note: The country data for the United States and most other countries
#'     is _not_ sub-divided by `province_state`, so that column has many `NA` values.
#'
#' @import readr
#' @import tidyr
#' @import tidyselect
#' @importFrom lubridate mdy
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @export
read_confirmed_cases_jhu_csse <- function() {
  # The source file is "wide" with one column per day.
  # Those date column labels look like:
  #   2/1/20  i.e. mm/dd/yy = Feb 1, 2020
  date_as_column_name_format = "\\d\\d?/\\d\\d?/2\\d"

  # We pivot the table to make it "long" with one
  # observation per row.
  confirmed_cases <- readr::read_csv(
    "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
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
#' * Reads a [JHU CSSE](https://github.com/CSSEGISandData/COVID-19) data file, [time_series_19-covid-Deaths.csv](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv), of deaths from the [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) disease.
#' * Reformats data as a [tidy dataset](https://r4ds.had.co.nz/tidy-data.html).
#' * Reformats the column names to [snake case](https://en.wikipedia.org/wiki/Snake_case).
#'
#' @return `tbl` with 6 columns:
#' * `country_region` : (character)
#' * `province_state` : (character)
#' * `lat` : (numeric) latitude
#' * `long` : (numeric) longitude
#' * `date` : (Date)
#' * `cumulative_total` : (integer) total number of deaths that occurred
#'     up to and including the given date.
#'
#' Note: The country data for the United States and most other countries
#'     is _not_ sub-divided by `province_state`, so that column has many `NA` values.
#'
#' @import readr
#' @import tidyr
#' @import tidyselect
#' @importFrom lubridate mdy
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @export
read_deaths_jhu_csse <- function() {
  # The source file is "wide" with one column per day.
  # Those date column labels look like:
  #   2/1/20  i.e. mm/dd/yy = Feb 1, 2020
  date_as_column_name_format = "\\d\\d?/\\d\\d?/2\\d"

  # We pivot the table to make it "long" with one
  # observation per row.
  deaths <- readr::read_csv(
    "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
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
