
library(testthat)
context("Reading COVID-19 case data")

test_that("Expected columns are present for confirmed cases", {
  expected_columns <- c(
    "country_region",
    "province_state",
    "lat",
    "long",
    "date",
    "cumulative_total"
  )
  actual_columns <- colnames(read_confirmed_cases())
  expect_gte(length(actual_columns), length(expected_columns))
  expect_true(all(expected_columns %in% actual_columns))
})

test_that("confirmed cases is not empty", {
  expect_gt(dim(read_confirmed_cases())[1], 0)
})

test_that("Oregon has expected 15 total cases on 2020-03-10", {
  expected_state <- "Oregon"
  expected_date <- lubridate::ymd("2020-03-10")
  expected_total <- 15
  actual_total <- read_confirmed_cases() %>%
    dplyr::filter(province_state == expected_state, date == expected_date) %>%
    dplyr::select(cumulative_total) %>%
    getElement("cumulative_total")
  expect_equal(actual_total, expected_total)
})
