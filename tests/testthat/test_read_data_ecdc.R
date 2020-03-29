library(testthat)
library(dplyr)
library(lubridate)

context("Reading COVID-19 case data from ECDC")

test_that("Expected columns are present for confirmed cases", {
  expected_columns <- c(
    "date",
    "dateRep",
    "day",
    "month",
    "year",
    "cases",
    "deaths",
    "countriesAndTerritories",
    "geoId",
    "countryterritoryCode",
    "popData2018"
  )
  actual_columns <- colnames(read_cases_ecdc())
  expect_gte(length(actual_columns), length(expected_columns))
  expect_true(all(expected_columns %in% actual_columns))
})

test_that("US has expected 5374 total cases on 2020-03-21", {
  expected_total <- 5374
  actual_total <- read_cases_ecdc() %>%
    dplyr::filter(geoId == "US", date == lubridate::ymd("2020-03-21")) %>%
    dplyr::select(cases) %>%
    getElement("cases")
  expect_equal(actual_total, expected_total)
})
