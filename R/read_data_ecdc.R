# Reads data from the European Centre for Disease Prevention and Control
# See https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide for documentation of the data.
#download the dataset from the ECDC website to a local temporary file

#' Reads COVID-19 cases and deaths from the ECDC
#'
#' Reads a [dataset](https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide) with COVID-19 cases and deaths, which is maintained by the European Centre for Disease Prevention and Control (ECDC).
#'
#' @details
#' * Reads an [ECDC](https://www.ecdc.europa.eu/) [dataset](https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide) of  [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) cases and deaths.
#' * Adds a `date` column of class `Date`, derived from the `dateRep` column, which is a string.
#'
#' @return `tbl` with 11 columns:
#' * `date`
#' * `dateRep`
#' * `day`
#' * `month`
#' * `year`
#' * `cases`
#' * `deaths`
#' * `countriesAndTerritories`
#' * `geoId`
#' * `countryterritoryCode`
#' * `popData2018`
#'
#' @import httr
#' @import readr
#' @importFrom lubridate dmy
#' @importFrom dplyr mutate
#' @export
read_cases_ecdc <- function() {
  ecdc_download_name <- tempfile(fileext = ".csv")
  httr::GET(
    url = "https://opendata.ecdc.europa.eu/covid19/casedistribution/csv",
    httr::authenticate(":", ":", type="ntlm"),
    httr::write_disk(ecdc_download_name)
  )
  df <- readr::read_csv(
      file = ecdc_download_name,
      col_types = get_ecdc_col_types()
    ) %>%
    dplyr::mutate(
      date = lubridate::dmy(dateRep),
    )
  file.remove(ecdc_download_name)
  return(df)
}

#' Returns a `col_spec` for ECDC COVID-19 data.
#'
#' Returns a `col_spec` for ECDC COVID-19 data to override the defaults detected
#'     by `readr::read_csv`.
#'
#' @return `col_spec` to be passed to `readr::read_csv` for the ECDC COVID-19 case dataset.
#'
#' @import readr
#' @export
get_ecdc_col_types <- function() {
  return(
    readr::cols(
      dateRep = readr::col_character(),
      day = readr::col_integer(),
      month = readr::col_integer(),
      year = readr::col_integer(),
      cases = readr::col_integer(),
      deaths = readr::col_integer(),
      countriesAndTerritories = readr::col_character(),
      geoId = readr::col_character(),
      countryterritoryCode = readr::col_character(),
      popData2018 = readr::col_integer()
    )
  )
}
