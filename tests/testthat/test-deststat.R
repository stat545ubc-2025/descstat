library(gapminder)
library(dplyr)
library(tibble)

# First to see if grouping works
test_function <- gapminder %>%
  dplyr::group_by(continent) %>%
  dplyr::summarise(
    min    = min(lifeExp, na.rm = TRUE),
    max    = max(lifeExp, na.rm = TRUE),
    mean   = mean(lifeExp, na.rm = TRUE),
    median = stats::median(lifeExp, na.rm = TRUE),
    sd     = stats::sd(lifeExp, na.rm = TRUE)
  )

test_that("function needs to work", {
  expect_equal(
    descstat(gapminder, continent, lifeExp),
    test_function
  )

  expect_equal(
    descstat(gapminder, year, gdpPercap),
    gapminder %>%
      dplyr::group_by(year) %>%
      dplyr::summarise(
        min    = min(gdpPercap, na.rm = TRUE),
        max    = max(gdpPercap, na.rm = TRUE),
        mean   = mean(gdpPercap, na.rm = TRUE),
        median = stats::median(gdpPercap, na.rm = TRUE),
        sd     = stats::sd(gdpPercap, na.rm = TRUE)
      )
  )
})

# Now, I want to try if the tibble it generates is rational.
# there will be 6 columns: group + 5 stats
test_that("checking if the tibble contains 6 columns", {
  res <- descstat(gapminder, continent, lifeExp)
  expect_equal(ncol(res), 6)
})

# Lastly, I want make sure that the column names are what I was expecting.
test_that("checking if tibble has the correct stat names", {
  res <- descstat(gapminder, continent, lifeExp)
  expect_true(all(c("min","max","mean","median","sd") %in% names(res)))
})

# Ok, now I make a pseudo data to check for some non-redundant inputs.
pseudo_data <- tibble(
  x = c("A","A","B","A","C","C","B","C"),
  y = c(1, 2, 3, 4, 5, NA, 7, 8)
)

test_that("function gives error for wrong numeric type", {
  expect_error(descstat(pseudo_data, y, x))
})

test_that("function gives error for wrong inputs", {
  expect_error(descstat(pseudo_data, 1, 1))
})

test_that("function should remove NA values when na.rm = TRUE", {
  res <- descstat(pseudo_data, x, y, na.rm = TRUE)
  expect_false(any(is.na(res)))
})
