# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(descstat)
library(gapminder)

test_check("descstat")

# First to see if grouping works
test_function <- gapminder %>%
  group_by(continent) %>%
  summarise(min = min(lifeExp,na.rm = TRUE),
            max = max(lifeExp, na.rm = TRUE),
            mean = mean(lifeExp, na.rm = TRUE),
            median = median(lifeExp, na.rm = TRUE),
            sd = sd(lifeExp, na.rm = TRUE))

test_that("function needs to work", {
  expect_equal(desc_stat(gapminder, continent, lifeExp), test_function)
  expect_equal(desc_stat(gapminder, year, gdpPercap),
               gapminder %>%
                 group_by(year) %>%
                 summarise(min = min(gdpPercap,na.rm = TRUE),
                           max = max(gdpPercap, na.rm = TRUE),
                           mean = mean(gdpPercap, na.rm = TRUE),
                           median = median(gdpPercap, na.rm = TRUE),
                           sd = sd(gdpPercap, na.rm = TRUE)))
})


# Now, I want to try if the tibble it generates is rational. I know that
# there will be 6 columns: variable, min, max, mean, median, and sd.
# Therefore, the length of my tibble output should be 6

test_that("checking if the tibble contains 6 columns",{
  expect_length(desc_stat(gapminder, continent, lifeExp), 6)
})


#Lastly, I want make sure that the columns names are what I was expecting.
test_that("checking if tibble has the correct stat names",{
  expect_true(all(c("min","max","mean","median","sd") %in% names(desc_stat(gapminder, continent, lifeExp))))
})


#Ok, now I make a pseudo data to check for some non-redundant inputs.
pseudo_data <- tibble(
  x = c("A","A","B","A","C","C","B","C"),
  y = c(1, 2, 3, 4, 5, NA, 7, 8))

desc_stat(pseudo_data, x, y, na.rm = TRUE)

test_that("function gives error for wrong numeric type", {
  expect_error(desc_stat(pseudo_data, y, x))
})


test_that("function gives error for wrong inputs", {
  expect_error(desc_stat(pseudo_data, 1, 1))
})

test_that("function should remove NA values", {
  desc_stat(pseudo_data, x, y)
  expect_false(any(is.na(desc_stat(pseudo_data, x,y))))
})
