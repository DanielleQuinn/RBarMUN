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

# Alternatively, use glimpse()

# ---- Review of {dplyr} ----
# select() : selects columns from a data frame


# filter() : filters rows from a data frame


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


# group_by() : splits your data into groups based on the 
# variables you specify

# The output doesn't look much different, but behind the scenes,
# dplyr has divided the data into groups according to year

# summarise() : summarises each group down to one value; you specify
# what you want this value to represent

# Goal: find the average population of each continent


# ---- Exploring Variables ----
names(gm_cells) # Returns all column names

# Use `select()` to choose what columns you want to look at
# From `gm_cells`, return all columns that start with `X197`


# From `gm_cells`, return all columns that end with `5`


# From `gapminder`, return all columns that contain the character `a`


# From `gm_cells`, return all columns that, when a given prefix is removed
# and the names converted to a numeric value, is found between 1995 and 1999

# Use `filter()` to choose what records you want to look at
# From `gapminder`, return any record where `country` is `Canada`


# From `gapminder`, find all records where `country` contains the characters `ad`
# and return the unique values of `country`


# ---- Tidy Data ----
# Arrange gapminder by decreasing year


head(gm_cells, 1) # Data is in wide format, with years as column names
# The first column is called `cell_phones` but contains countries...!

# Rename the `cell_phones` column to `country`


# Convert from wide to long
# `gather()` converts data from wide format to long format
# you provide the names of the new columns; value describes the numeric values,
# key describes an additional factor
# `gather()` will by default gather all of the columns; in this case we don't want `country`
# to be included, so we add `-country` as a third argument



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


# Why does this give us an error?

# `year` is not stored as an integer in both datasets
# Use `mutate(gsub())`` to remove "X" from the years,
# then use `mutate()`` convert `year` to an integer

# (This could also be done in one step by nesting functions)
# Remember that we want this change to be permanent, so we
# overwrote the existing `gm_cells_tidy` data frame

# Try merging again

# When you can confirm it has worked, overwrite `gapminder` with this new version


##
# Goal: Merge `gapminder` and `gm_car_deaths`

# Solution: 

##

# If you glimpse at `gapminder`, you should see those changes
glimpse(gapminder)

# ---- Manipulating Data ----
# Use mutate to create variable of subscriptions as a percent of the population


# You can also use mutate to generate a lag or lead effect
# Consider how life expectancy in Canada has changed over time


# Mutate can be used to rank and scale values
# In 2007, rank the countries in Europe by population, from highest to lowest

# Scaling values between 0 and 1

# ---- Completing and Filling in Data ----
# Create data frame for demonstration
myData <- data.frame(lab_name = c("Beetles_R_Us", rep(NA, 4), "Spiders_R_Us", rep(NA, 3)),
                     site = c("X", "X", "X", "Y", "Y", "Z", "Z", "Z", "Z"),
                     sample = c("a", "b", "d", "a", "c", "a", "b", "c", "d"),
                     type = c(rep("sand", 3), rep("clay", 2), rep("soil", 4)),
                     total = c(1, 3, 2, 2, 4, 3, 4, 1, 5))

myData

# You want to fill in the lab name according to whatever is in the cell above

# You've missed measurements but want to make sure that every site has a record 
# for each sampling period, and fill them in with NA


# Fill in the missing totalts with zero


# Fill in  the missing types and lab nameswith whatever is appropriate

# What if you wanted a separate row for every individual
# counted in myData at site X?

# Just look at site X

# Use `uncount()` to expand your data


# ---- Summarize Data ----
# Case One: One function on one variable
# Find the maximum population, by continent


# Case Two: Multiple functions on one variable
# Find the maximum and mean population, by continent

# OR, using `summarize_at()`
# `summarize_at()` requires you specify the variables to be used in `vars()`
# and the functions to be applied in `funs()`

# Case Three: One function, multiple variables
# Find the maximum of population & life expectancy, by continent

# OR, using `summarise_at()`

# Case Four: multiple functions on multiple variables
# Find the maximum and mean of population, life expectancy, and 
# GDP per capita, by continent

# OR, using `summarize_at()`

