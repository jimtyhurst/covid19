# covid19

<!-- badges: start -->
<!-- badges: end -->

This `covid19` package provides an [R](https://www.r-project.org/) API for accessing [COVID-19 data](https://github.com/CSSEGISandData/COVID-19) published by [Johns Hopkins University](https://www.jhu.edu/) Center for Systems Science and Engineering (JHU [CSSE](https://systems.jhu.edu/)).

[Vignettes](./vignettes) demonstrate how to use this API by providing simple visualizations of the data.

## Installation

There are no plans to created a release version. Install the development version of `covid19` from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("jimtyhurst/covid19")
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

## Example for CSSE data

`read_confirmed_cases_jhu_csse()`:

* Reads a [JHU CSSE data file](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv) of confirmed [COVID-19](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) cases.
* Reformats data as a [tidy dataset](https://r4ds.had.co.nz/tidy-data.html).
* Reformats the column names to [snake case](https://en.wikipedia.org/wiki/Snake_case).

``` r
library(covid19)
confirmed_cases <- covid19::read_confirmed_cases_jhu_csse()

# Number of rows depends on the day that the data is downloaded,
# because the dataset is updated daily.
dim(confirmed_cases)
# [1] 16951     6
colnames(confirmed_cases)
# [1] "country_region"   "province_state"   "lat"              "long"            
# [5] "date"             "cumulative_total"
```

## License
Copyright &copy; 2020 Jim Tyhurst

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

       [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
