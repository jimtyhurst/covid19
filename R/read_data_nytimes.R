
#' Reads COVID-19 cases and deaths by state from the NY Times
#'
#' * Reads a [NY Times](https://www.nytimes.com/interactive/2020/us/coronavirus-us-cases.html) [dataset](https://github.com/nytimes/covid-19-data/blob/master/us-states.csv) of  [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) cases and deaths by state.
#'
#' @return `tbl` with 5 columns:
#' * `date`
#' * `state`
#' * `fips`
#' * `cases`
#' * `deaths`
#'
#' @import readr
#' @export
read_state_cases_nytimes <- function() {
  df <- readr::read_csv(
    file = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv",
    col_types = get_nytimes_state_col_types()
  )
  return(df)
}

#' Returns a `col_spec` for NY Times COVID-19 data.
#'
#' Returns a `col_spec` for NY Times COVID-19 data to override the defaults detected
#'     by `readr::read_csv`.
#'
#' @return `col_spec` to be passed to `readr::read_csv` for the NY Times COVID-19 case dataset.
#'
#' @import readr
#' @export
get_nytimes_state_col_types <- function() {
  return(
    readr::cols(
      date = readr::col_date(format = "%Y-%m-%d"),
      state = readr::col_character(),
      fips = readr::col_integer(),
      cases = readr::col_integer(),
      deaths = readr::col_integer()
    )
  )
}
