
<!-- README.md is generated from README.Rmd. Please edit that file -->

# descstat

<!-- badges: start -->

<!-- badges: end -->

The goal of descstat is to produces a table that contains descriptive
statistics (min, max, mean, median, and sd) of a numeric variable
grouped by any column with repeated values. This analysis will remove
any missing values from the data.

## Installation

You can install the development version of descstat from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("stat545ubc-2025/descstat")
#> Using GitHub PAT from the git credential store.
#> Skipping install of 'descstat' from a github remote, the SHA1 (bb8096c5) has not changed since last install.
#>   Use `force = TRUE` to force installation
library(descstat)
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(gapminder) #dataset to demonstrate the function
## basic example code
descstat(gapminder, year, lifeExp)
#> # A tibble: 12 × 6
#>     year   min   max  mean median    sd
#>    <int> <dbl> <dbl> <dbl>  <dbl> <dbl>
#>  1  1952  28.8  72.7  49.1   45.1  12.2
#>  2  1957  30.3  73.5  51.5   48.4  12.2
#>  3  1962  32.0  73.7  53.6   50.9  12.1
#>  4  1967  34.0  74.2  55.7   53.8  11.7
#>  5  1972  35.4  74.7  57.6   56.5  11.4
#>  6  1977  31.2  76.1  59.6   59.7  11.2
#>  7  1982  38.4  77.1  61.5   62.4  10.8
#>  8  1987  39.9  78.7  63.2   65.8  10.6
#>  9  1992  23.6  79.4  64.2   67.7  11.2
#> 10  1997  36.1  80.7  65.0   69.4  11.6
#> 11  2002  39.2  82    65.7   70.8  12.3
#> 12  2007  39.6  82.6  67.0   71.9  12.1
descstat(gapminder, country, gdpPercap)
#> # A tibble: 142 × 6
#>    country        min    max   mean median    sd
#>    <fct>        <dbl>  <dbl>  <dbl>  <dbl> <dbl>
#>  1 Afghanistan   635.   978.   803.   803.  108.
#>  2 Albania      1601.  5937.  3255.  3253. 1192.
#>  3 Algeria      2449.  6223.  4426.  4854. 1310.
#>  4 Angola       2277.  5523.  3607.  3265. 1166.
#>  5 Argentina    5911. 12779.  8956.  9069. 1863.
#>  6 Australia   10040. 34435. 19981. 18906. 7815.
#>  7 Austria      6137. 36126. 20412. 20673. 9655.
#>  8 Bahrain      9867. 29796. 18078. 18780. 5415.
#>  9 Bangladesh    630.  1391.   818.   704.  235.
#> 10 Belgium      8343. 33693. 19901. 20049. 8391.
#> # ℹ 132 more rows
```
