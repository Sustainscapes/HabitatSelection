
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `HabitatSelection`

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/Sustainscapes/HabitatSelection/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Sustainscapes/HabitatSelection/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Installation

You can install the development version of `HabitatSelection` like so:

``` r
library(remotes)
remotes::install_github("Sustainscapes/HabitatSelection")
```

## Run

You can launch the application by running:

``` r
HabitatSelection::run_app()
```

## About

You are reading the doc about version : 0.0.0.9000

This README has been compiled on the

``` r
Sys.time()
#> [1] "2024-11-29 06:59:36 CET"
```

Here are the tests results and package coverage:

``` r
devtools::check(quiet = TRUE)
#> ℹ Loading HabitatSelection
#> ── R CMD check results ──────────────────────── HabitatSelection 0.0.0.9000 ────
#> Duration: 46.1s
#> 
#> ❯ checking for future file timestamps ... NOTE
#>   unable to verify current time
#> 
#> ❯ checking package subdirectories ...Warning: program compiled against libxml 210 using older 209
#>    NOTE
#>   Problems with news in ‘NEWS.md’:
#>   No news entries found.
#> 
#> 0 errors ✔ | 0 warnings ✔ | 2 notes ✖
```

``` r
covr::package_coverage()
#> HabitatSelection Coverage: 85.57%
#> R/run_app.R: 0.00%
#> R/app_server.R: 66.67%
#> R/app_config.R: 100.00%
#> R/app_ui.R: 100.00%
#> R/golem_utils_server.R: 100.00%
#> R/golem_utils_ui.R: 100.00%
#> R/mod_gradient_axis.R: 100.00%
```
