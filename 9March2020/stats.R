# ---- Load packages ----
library(Ecdat) # contains built in data set
library(gapminder) # contains built in data set
library(dplyr) # data manipulation
library(caTools) # split data into train and test
library(corrplot) # correlation
library(ggplot2) # visualization

# ---- Access data ----
# Real estate data from {Ecdat} (called "Housing)
houses <- Ecdat::Housing
head(houses)

# Demographics data from {gapminder} (called "gapminder")
demo <- gapminder::gapminder
head(demo)

# ---- Basic Statistics ----
# Goal: Calculate summary statistics for every column
summary(houses)


# Mean
mean(houses$price)


# Standard Deviation
sd(houses$price)


# Minimum and Maximum
min(houses$price)
max(houses$price)




# ---- {dplyr} Summary Tables ----
# Question: What is the average, standard deviation, minimum,
# and maximum prices of houses with and without a driveway?
houses %>%
  group_by(driveway) %>%
  summarise(average = mean(price),
            standard_deviation = sd(price),
            minimum = min(price),
            maximum = max(price))

# Question: What is the average, standard deviation, minimum,
# and maximum life expectancy, by continent?


# ---- Confidence Limits ----
# Question: What are the 95% confidence limits
# around the average?
u <- mean(houses$price)
n <- nrow(houses)
sigma <- sd(houses$price)

# 1.96 is the Z score for 95% confidence
error <- qnorm(0.95) * sigma / sqrt(n)

upper_cl <- u + error
lower_cl <- u - error

# Question: What are the 95 % confidence limits
# around the average life expectancy?



# ---- Resampling and Splitting Data ----
## Simple Random Sampling
# Goal: Randomly sample 100 records from houses
set.seed(123)
simple_sample <- houses %>%
  sample_n(100)

# How does this compare to the entire sample?
mean(houses$price)
mean(simple_sample$price)

## Stratified Random Sampling
# Goal: Randomly sample 50 records from houses with a 
# driveway and 50 records from houses without a driveway.
set.seed(123)
strat_sample <- houses %>%
  group_by(driveway) %>%
  sample_n(50)

# How does this compare to the entire sample?
mean(houses$price)
mean(strat_sample$price)

## Test / Training Split
# Goal: Split the gapminder data into a training data set that 
# contains 70% of the records, and a test data set that contains
# 30% of the records
set.seed(123)
demo <- demo %>%
  mutate(include = NA,
         include = sample.split(include, SplitRatio = 0.7))

table(demo$include)

train <- demo %>%
  filter(include == TRUE) # 70% of records

test <- demo %>%
  filter(include == FALSE) # 30% of records

nrow(demo)
nrow(train)
nrow(test)

# ---- Correlation ----
# Question: Which variables in houses are correlated?
# Subset houses to only include numerical variables
numeric_houses <- houses %>%
  select_if(is.numeric)

my_cors <- cor(numeric_houses)
corrplot(my_cors,
         method = "number",
         type = "upper")

# Question: Which variables in demo are correlated?
# Subset demo to only include numerical variables



# ---- Comparing Values: Parametric, Two Groups ----
# Question: Is the price of houses with a driveway significantly
# different than houses without a driveway?

# Visualize Data
ggplot(houses) +
  geom_boxplot(aes(x = driveway, y = price)) +
  theme_bw()

# Two groups of values to compare
# Response variable (price) is approximately normally distributed

with_driveway <- houses %>%
  filter(driveway == "yes") %>%
  pull(price)
with_driveway

without_driveway <- houses %>%
  filter(driveway == "no") %>%
  pull(price)
without_driveway

mean(with_driveway)
mean(without_driveway)

# Is there a significant difference?
## t test (unpaired)
t.test(with_driveway, without_driveway)


# ---- Comparing Values: Non Parametric, Two Groups ----
# Question: Do houses with a driveway have significantly more (or fewer)
# bedrooms than houses without a driveway?
head(houses$bedrooms)

with_driveway <- houses %>%
  filter(driveway == "yes") %>%
  pull(bedrooms)

without_driveway <- houses %>%
  filter(driveway == "no") %>%
  pull(bedrooms)

mean(with_driveway)
mean(without_driveway)

# Mann-Whitney U test (unpaired)
wilcox.test(with_driveway, without_driveway, paired = FALSE)

# ---- Comparing Values: Parametric, More Than Two Groups ----
# Question: Do houses with a different number of stories have
# significantly different prices?

# Visualize Data
ggplot(houses) + 
  geom_boxplot(aes(x = as.factor(stories), y = price)) +
  theme_bw()

# More than two groups of values to compare
# ANOVA
houses %>%
  group_by(stories) %>%
  summarise(mean = mean(price))

# Is there a significant difference?
## analysis of variance
fit1 <- aov(price ~ as.factor(stories), data = houses)
summary(fit1)

# shows the same results as ...
fit2 <- anova(lm(price ~ as.factor(stories), data = houses))
fit2

# ---- Comparing Values: Non Parametric, More Than Two Groups ----
# Question: Do houses with a different number of stories have
# significantly different numbers of bedrooms?

# Visualize Data
ggplot(houses) + 
  geom_boxplot(aes(x = as.factor(stories), y = bedrooms)) +
  theme_bw()

# More than two groups of values to compare
# Response variable (bedrooms) is a count
houses %>%
  group_by(stories) %>%
  summarise(mean = mean(bedrooms))

# Is there a significant difference?
## Kruskall-Wallace test
fit1 <- kruskal.test(houses$bedrooms, as.factor(houses$stories))
fit1

# There *is* a difference but we don't know *where*
# Return to Wilcoxon test and do pairwise comparisons
stories1 <- houses %>%
  filter(stories == 1) %>%
  pull(bedrooms)

stories2 <- houses %>%
  filter(stories == 2) %>%
  pull(bedrooms)

stories3 <- houses %>%
  filter(stories == 3) %>%
  pull(bedrooms)

stories4 <- houses %>%
  filter(stories == 4) %>%
  pull(bedrooms)

wilcox.test(stories1, stories2)$p.value
wilcox.test(stories1, stories3)$p.value
wilcox.test(stories1, stories4)$p.value
wilcox.test(stories2, stories3)$p.value
wilcox.test(stories2, stories4)$p.value
wilcox.test(stories3, stories4)$p.value
