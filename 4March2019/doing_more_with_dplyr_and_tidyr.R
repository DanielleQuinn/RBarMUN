# RBar MUN - 4 Mar 2019
# Doing more with {dplyr} and {tidyr}

# ---- Load Packages ----
# If you don't have these packages, install them using
# install.packages("tidyverse") # for {dplyr} and {tidyr}
# install.packages("gapminder")

# Load Packages
library(tidyr)
library(dplyr)
library(gapminder)

# ---- Import Data  ----
# acessed from the {gapminder} package
data(gapminder)

# Download at https://github.com/DanielleQuinn/gapminder_data
gm_cells <- read.delim("data/gapminder-cell-phones.txt")
gm_car_deaths <- read.delim("data/gapminder-car-deaths.txt")

# ---- Explore Data ----
str(gapminder)
str(gm_cells)
str(gm_car_deaths)

# Alternatively, use glimpse()
glimpse(gapminder)
glimpse(gm_cells)
glimpse(gm_car_deaths)

# ---- Review of {dplyr} ----
# select() : selects columns from a data frame
select(gapminder, year, pop, lifeExp)

# filter() : filters rows from a data frame
filter(gapminder, year == 1997)

# %>% : a pipe, passes arguments from the left hand side to 
# the right hand side

##
# Goal: Print the country, and population columns
# but only include data from 1997
# Apply two steps: filter() and select()

# Solution:

##

# You can also write it like this, which will help you
# keep track of what each step is doing
gapminder %>%
  filter(year == 1997) %>%
  select(country, pop)

# group_by() : splits your data into groups based on the 
# variables you specify
gapminder %>%
  group_by(continent)
# The output doesn't look much different, but behind the scenes,
# dplyr has divided the data into groups according to year

# summarise() : summarises each group down to one value; you specify
# what you want this value to represent

# Goal: find the average population of each continent
gapminder %>%
  group_by(continent) %>%
  summarise(mean(pop))

# ---- Exploring Variables ----
names(gm_cells) # Returns all column names

# Use `select()` to choose what columns you want to look at
# From `gm_cells`, return all columns that start with `X197`
gm_cells %>%
  select(starts_with("X197"))

# From `gm_cells`, return all columns that end with `5`
gm_cells %>%
  select(ends_with("5"))

# From `gapminder`, return all columns that contain the character `a`
gapminder %>%
  select(contains("a"))

# From `gm_cells`, return all columns that, when a given prefix is removed
# and the names converted to a numeric value, is found between 1995 and 1999
gm_cells %>%
  select(num_range(prefix = "X", range = 1995:1999))

# Use `filter()` to choose what records you want to look at
# From `gapminder`, return any record where `country` is `Canada`
gapminder %>%
  filter(country == "Canada")

# From `gapminder`, find all records where `country` contains the characters `ad`
# and return the unique values of `country`
gapminder %>% 
  filter(grepl("ad", country)) %>% 
  distinct(country)

# ---- Tidy Data ----
# Arrange gapminder by decreasing year
gapminder <- gapminder %>%
  arrange(desc(year))

head(gm_cells, 1) # Data is in wide format, with years as column names
# The first column is called `cell_phones` but contains countries...!

# Rename the `cell_phones` column to `country`
gm_cells %>%
  rename(country = cell_phones)  

# Convert from wide to long
# `gather()` converts data from wide format to long format
# you provide the names of the new columns; value describes the numeric values,
# key describes an additional factor
# `gather()` will by default gather all of the columns; in this case we don't want `country`
# to be included, so we add `-country` as a third argument
gm_cells_tidy <- gm_cells %>%
  rename(country = cell_phones) %>%
  gather(key = "year", value = "cell_subscribers", -country)


# Remember: for a change to be permanent, you need to place the output into a
# new object or overwrite the existing object

##
# Goal: Use `rename()` and `gather()` to tidy the `gm_car_deaths` data
# call the new column containing the numeric values `car_deaths`
# place the output into a new object called `gm_car_deaths_tidy`

# Solution:

##

# ---- Merge Data ----
# Look at the first few rows of both `gapminder` and `gm_cells_tidy`
head(gapminder, 3)
head(gm_cells_tidy, 3)

# We can see that we would like to add the cell phone information
# to our `gapminder` data set, using `country` and `year` to match records
gapminder %>%
  left_join(gm_cells_tidy, by = c("country", "year"))

# Why does this give us an error?
glimpse(gapminder)
glimpse(gm_cells_tidy)
# `year` is not stored as an integer in both datasets
# Use `mutate(gsub())`` to remove "X" from the years,
# then use `mutate()`` convert `year` to an integer
gm_cells_tidy <- gm_cells_tidy %>%
  mutate(year = gsub("X", "", year)) %>%
  mutate(year = as.integer(year))
# (This could also be done in one step by nesting functions)
# Remember that we want this change to be permanent, so we
# overwrote the existing `gm_cells_tidy` data frame

# Try merging again
gapminder %>%
  left_join(gm_cells_tidy, by = c("country", "year"))
# When you can confirm it has worked, overwrite `gapminder` with this new version
gapminder <- gapminder %>%
  left_join(gm_cells_tidy, by = c("country", "year"))

##
# Goal: Merge `gapminder` and `gm_car_deaths`

# Solution: 

##

# If you glimpse at `gapminder`, you should see those changes
glimpse(gapminder)

# ---- Manipulating Data ----
# Use mutate to create variable of subscriptions as a percent of the population
gapminder <- gapminder %>%
  mutate(cell_subscribers_pct = cell_subscribers / pop * 100)

# You can also use mutate to generate a lag or lead effect
# Consider how life expectancy in Canada has changed over time
gapminder %>%
  filter(country == "Canada") %>%
  mutate(lifeExp_lead = lead(lifeExp, 1)) %>% # apply a timestep lead of 1 year
  mutate(change_lifeExp = lifeExp - lifeExp_lead) %>% # how much has it increased?
  select(year, lifeExp, lifeExp_lead, change_lifeExp) # To view results, only return the appropriate columns

# Mutate can be used to rank and scale values
# In 2007, rank the countries in Europe by population, from highest to lowest
gapminder %>%
  filter(continent == "Europe" & year == 2007) %>%
  mutate(pop_rank = dense_rank(-pop)) %>% # There are various rank functions, `dense_rank` used here
  select(country, starts_with("pop")) # View results

# Scaling values between 0 and 1
gapminder %>%
  filter(continent == "Europe" & year == 2007) %>%
  mutate(pop_rank = percent_rank(-pop)) %>%
  select(country, starts_with("pop"))

# ---- Completing and Filling in Data ----
# Create data frame for demonstration
myData <- data.frame(lab_name = c("Beetles_R_Us", rep(NA, 4), "Spiders_R_Us", rep(NA, 3)),
                     site = c("X", "X", "X", "Y", "Y", "Z", "Z", "Z", "Z"),
                     sample = c("a", "b", "d", "a", "c", "a", "b", "c", "d"),
                     type = c(rep("sand", 3), rep("clay", 2), rep("soil", 4)),
                     total = c(1, 3, 2, 2, 4, 3, 4, 1, 5))

myData

# You want to fill in the lab name according to whatever is in the cell above
myData <- myData %>%
  fill(lab_name)
myData

# You've missed measurements but want to make sure that every site has a record 
# for each sampling period, and fill them in with NA
myData %>%
  complete(site, sample)

# Fill in the missing totalts with zero
myData_new <- myData %>%
  complete(site, sample, fill = list(total = 0))
myData_new

# Fill in  the missing types and lab nameswith whatever is appropriate
myData_new %>%
  group_by(site) %>%
  mutate(type = unique(type[!is.na(type)]),
         lab_name = unique(lab_name[!is.na(lab_name)]))

# What if you wanted a separate row for every individual
# counted in myData at site X?

# Just look at site X
myData %>%
  filter(site == "X")

# Use `uncount()` to expand your data
myData %>%
  filter(site == "X") %>%
  uncount(total) %>%
  mutate(count = 1)

# ---- Summarize Data ----
# Case One: One function on one variable
# Find the maximum population, by continent
gapminder %>%
  group_by(continent) %>%
  summarize(max(pop))

# Case Two: Multiple functions on one variable
# Find the maximum and mean population, by continent
gapminder %>%
  group_by(continent) %>%
  summarize(max(pop),
            mean(pop))
# OR, using `summarize_at()`
# `summarize_at()` requires you specify the variables to be used in `vars()`
# and the functions to be applied in `funs()`
gapminder %>%
  group_by(continent) %>%
  summarize_at(vars("pop"), funs(max, mean))

# Case Three: One function, multiple variables
# Find the maximum of population & life expectancy, by continent
gapminder %>%
  group_by(continent) %>%
  summarize(max(pop),
            max(lifeExp))
# OR, using `summarise_at()`
gapminder %>%
  group_by(continent) %>%
  summarize_at(vars("pop", "lifeExp"), funs(max))

# Case Four: multiple functions on multiple variables
# Find the maximum and mean of population, life expectancy, and 
# GDP per capita, by continent
gapminder %>%
  group_by(continent) %>%
  summarize(max(pop),
            mean(pop),
            max(lifeExp),
            mean(lifeExp),
            max(gdpPercap),
            mean(gdpPercap))
# OR, using `summarize_at()`
gapminder %>%
  group_by(continent) %>%
  summarize_at(vars("pop", "lifeExp", "gdpPercap"), funs(max, mean))
