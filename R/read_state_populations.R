
#' Reads state population estimates from the United States Census Bureau
#'
#' * Reads a United States Census Bureau [dataset](https://www.census.gov/newsroom/press-kits/2019/national-state-estimates.html) of estimated state populations for 2019.
#'
#' @return `tbl` with 3 columns:
#' * `state_name`
#' * `year`
#' * `population_estimate`
#'
#' @import readr
#' @import dplyr
#' @export
read_state_populations <- function() {
  df <-
    readr::read_csv(
      file = system.file(
        "extdata",
        "nst-est2019-alldata",
        "nst-est2019-alldata.csv",
        package = "covid19"
      ),
      col_types = get_state_populations_col_types()
    ) %>%
    dplyr::filter(SUMLEV == 40) %>%
    dplyr::mutate(YEAR = 2019) %>%
    dplyr::select(state_name = NAME, year = YEAR, population_estimate = POPESTIMATE2019)
  return(df)
}

#' Returns a `col_spec` for U.S. Census Bureau estimated state population data.
#'
#' Returns a `col_spec` for U.S. Census Bureau estimated state population data
#'     to override the defaults detected by `readr::read_csv`.
#'
#' @return `col_spec` to be passed to `readr::read_csv` for the U.S. Census Bureau
#'     estimated state population dataset.
#'
#' @import readr
#' @export
get_state_populations_col_types <- function() {
  return(
    readr::cols(
      .default = readr::col_number(),
      SUMLEV = readr::col_integer(),
      REGION = readr::col_character(),
      DIVISION = readr::col_character(),
      STATE = readr::col_integer(),
      NAME = readr::col_character(),
      CENSUS2010POP = readr::col_integer(),
      POPESTIMATE2019 = readr::col_integer()
    )
  )
}
