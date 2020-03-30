# covid19

This `covid19` package provides an [R](https://www.r-project.org/) API for accessing:

* COVID-19 time series of [cases and deaths by state](https://github.com/nytimes/covid-19-data/blob/master/us-states.csv), published by the [NY Times](https://www.nytimes.com/interactive/2020/us/coronavirus-us-cases.html).
* COVID-19 time series of [cases and deaths by country](https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide), published by the European Centre for Disease Prevention and Control ([ECDC](https://www.ecdc.europa.eu/)).
* COVID-19 time series of [cases and deaths by country](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series), published by [Johns Hopkins University](https://www.jhu.edu/) Center for Systems Science and Engineering (JHU [CSSE](https://systems.jhu.edu/)). They have separate files for confirmed cases and deaths.

[Vignettes](./vignettes) demonstrate how to use this API by providing simple visualizations of the data.

---

## Contents

* [Installation](#installation)
* [Example for NY Times data](#example-for-ny-times-data)
* [Example for ECDC data](#example-for-ecdc-data)
* [Examples for JHU CSSE data](#examples-for-jhu-csse-data)
* [License](#license)
* [Resources](#resources)

---

## Installation

There are no plans to created a release version. Install the _development_ version of `covid19` from [GitHub](https://github.com/) with:

``` r
remotes::install_github("jimtyhurst/covid19")
```

## Example for NY Times data

`read_state_cases_nytimes()`:

* Reads a [NY Times](https://www.nytimes.com/interactive/2020/us/coronavirus-us-cases.html) dataset of COVID-19 [cases and deaths](https://github.com/nytimes/covid-19-data/blob/master/us-states.csv) by state.

``` r
library(covid19)
df <- covid19::read_state_cases_nytimes()

# Number of rows depends on the day that the data is downloaded,
# because the dataset is updated daily.
dim(df)
# [1] 1437    5
[1] "date"   "state"  "fips"   "cases"  "deaths"
```

## Example for ECDC data

`read_cases_ecdc()`:

* Reads a European Centre for Disease Prevention and Control ([ECDC](https://www.ecdc.europa.eu/)) [dataset](https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide) of [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) cases and deaths.
* Adds a `date` column of class `Date`, derived from the original `dateRep` column, which is a string.

``` r
library(covid19)
df <- covid19::read_cases_ecdc()

# Number of rows depends on the day that the data is downloaded,
# because the dataset is updated daily.
dim(df)
# [1] 7515   11
colnames(df)
 [1] "dateRep"                 "day"                     "month"                  
 [4] "year"                    "cases"                   "deaths"                 
 [7] "countriesAndTerritories" "geoId"                   "countryterritoryCode"   
[10] "popData2018"             "date"
```

## Examples for JHU CSSE data

`read_confirmed_cases_jhu_csse()`:

* Reads a [JHU CSSE data file](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv) of confirmed [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) cases by country.
* Reformats the data as a [tidy dataset](https://r4ds.had.co.nz/tidy-data.html).
* Reformats the column names to [snake case](https://en.wikipedia.org/wiki/Snake_case).

``` r
library(covid19)
confirmed_cases <- covid19::read_confirmed_cases_jhu_csse()

# Number of rows depends on the day that the data is downloaded,
# because the dataset is updated daily.
dim(confirmed_cases)
# [1] 17204     6
colnames(confirmed_cases)
# [1] "country_region"   "province_state"   "lat"             
# [4] "long"             "date"             "cumulative_total"
```

---

`read_deaths_jhu_csse()`:

* Reads a [JHU CSSE data file](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv) of COVID-19 deaths by country.
* Reformats data as a [tidy dataset](https://r4ds.had.co.nz/tidy-data.html).
* Reformats the column names to [snake case](https://en.wikipedia.org/wiki/Snake_case).

``` r
library(covid19)
deaths <- covid19::read_deaths_jhu_csse()

# Number of rows depends on the day that the data is downloaded,
# because the dataset is updated daily.
dim(deaths)
# [1] 17204     6
colnames(deaths)
# [1] "country_region"   "province_state"   "lat"             
# [4] "long"             "date"             "cumulative_total"
```

## License
Copyright &copy; 2020 Jim Tyhurst

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

       [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Resources
* World Health Organization (WHO): [Coronavirus disease 2019](https://www.who.int/emergencies/diseases/novel-coronavirus-2019)
* United States Centers for Disease Control and Prevention (CDC): [Coronavirus (COVID-19)](https://www.cdc.gov/coronavirus/2019-nCoV/index.html)
* European Centre for Disease Prevention and Control (ECDC): [COVID-19](https://www.ecdc.europa.eu/en/novel-coronavirus-china)
* Johns Hopkins University Center for Systems Science and Engineering:
    * [Mapping 2019-nCoV](https://systems.jhu.edu/research/public-health/ncov/)
    * [Coronavirus COVID-19 Global Cases](https://www.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6)
