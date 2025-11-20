#' @title Speedrun Descriptive Statistics
#'
#' @description
#' This function produces a table that contains descriptive statistics (min, max, mean, median, and sd) of a numeric variable grouped by any column with repeated values. This analysis will remove any missing values from the data.
#'
#' @param data the dataset you would like to examine
#' @param group the column to group by
#' @param numeric_variable the numeric column to summarize
#' @returns descriptive statistics in a tibble with one row per group and summary statistics in columns
#'
#' @examples
#' descstat(gapminder, year, lifeExp)
#' descstat(gapminder, country, gdpPercap)
#'
#' @export
#'

library(magrittr)
descstat <- function(data, group, numeric_variable, na.rm = TRUE) {

  needs_to_be_numeric <- data %>%
    dplyr::select ({{numeric_variable}}) %>%
    dplyr::pull () #this is to extract the numeric column

  if (!is.numeric(needs_to_be_numeric)) {
    stop("numeric_variable must contain numeric values, duh")
  } #this will stop the function if they input incorrectly

  descriptive_data <- data %>%
    dplyr::group_by({{group}}) %>%
    dplyr::summarise(min = min({{numeric_variable}},na.rm = na.rm),
              max = max({{numeric_variable}}, na.rm = na.rm),
              mean = mean({{numeric_variable}}, na.rm = na.rm),
              median = median({{numeric_variable}}, na.rm = na.rm),
              sd = sd({{numeric_variable}}, na.rm = na.rm))
  return(descriptive_data)
}
