
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pseudo-ku <img src="man/figures/pseudoku.png" align="right" width="120" height="139"/>

<!-- badges: start -->

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![](https://img.shields.io/badge/devel%20version-0.1.0-blue.svg)](https://github.com/rtjohnson12/pseudoku)
<!-- badges: end -->

The goal of pseudoku is to …

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rtjohnson12/pseudoku")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(pseudoku)

board <- create_board(.seed = 42)
print_board(board)
```

<img src="man/figures/README-example-1.png" width="100%" />
