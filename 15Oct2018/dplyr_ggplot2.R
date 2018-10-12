# ---- Load packages ----
library(dplyr)

# ---- Import Data ----


# ---- Reminder of what gapminder looks like ----
str(gapminder)
head(gapminder)

# ---- Manipulating Data with {dplyr} ----
# select() : selects columns from a data frame
select(gapminder, year, pop, lifeExp)

# filter() : filters rows from a data frame
filter(gapminder, year == 1997)
filter(gapminder, year == 1997 & country %in% c("Austria", "Australia"))
filter(gapminder, year == 1997 | country %in% c("Austria", "Australia"))

# The real power of {dplyr} is that you can link each step together
# to create a workflow using a pipe %>%
# A pipe takes everything on the left hand side,
# passes it through the pipe,
# and applys whatever instructions are on the right hand
# side of the pipe
# take this  %>%  do this

# Goal: Look at the year, country, and population columns
# but only include data from 1997
# We need to apply two steps: filter() and select()
gapminder %>% filter(year == 1997) %>% select(country, pop)

# you can also write it like this, which will help you
# keep track of what each step is doing
gapminder %>%
  filter(year == 1997) %>%
  select(country, pop)

# group_by()
# splits your data into groups based on the variables you specify
gapminder %>%
  group_by(year)
# the output doesn't look much different, but behind the scenes,
# dplyr has divided the data into groups according to year

# when we push groups through a pipe, we apply the
# instructions on the other side to each group

# summarise()
# returns a value based on the instructions you give it

# these two functions together are powerful!
# Goal: find the average population of each continent
gapminder %>%
  group_by(continent) %>%
  summarise(mean(pop))

# you can also ask for multiple pieces of summary information
# Goal: find the average and sd of population of each continent
gapminder %>%
  group_by(continent) %>%
  summarise(mean(pop), sd(pop))

# to clean up the column names of the output table:
gapminder %>%
  group_by(continent) %>%
  summarise(MyAverage = mean(pop), MySD = sd(pop))

# Exercise: 
# Find the average & minimum lifeExp for each continent before 1970
# Solution:
gapminder %>%
  filter(year < 1970) %>%
  group_by(continent) %>%
  summarise(mean(lifeExp), min(lifeExp))
# If you've had trouble with this, it's important to think
# about the order of the instructions:
# you can't find the average life expectancy and then
# ask to only consider certain years; you need to filter out
# the years first!

# If you've done this kind of thing before:
# Extra Challenge: Group by both continent and country and
# store your results as an object called table1
table1 <- gapminder %>% 
  filter(year < 1970) %>% 
  group_by(continent, country) %>%
  summarise(m_le = mean(lifeExp), 
            sd_le = sd(lifeExp))
table1

# mutate() : create a new column based on another column
gapminder %>%
  mutate(new_lifeExp = lifeExp / 1000)
head(gapminder) # it doesn't make changes to the actual data
# if we want to make this change permanent,
# overwrite the exsiting gapminder object with
# the new version of itself
gapminder <- gapminder %>%
  mutate(new_lifeExp = lifeExp / 1000)
head(gapminder)

# count() : counts occurences
# Goal: how many records of each continent?
gapminder %>%
  count(continent)

# n_distinct() can be used with group_by() and summarise()
# to count unique values by group
# Goal: how many unique countries in each continent?
gapminder %>%
  group_by(continent) %>%
  summarise(n_distinct(country))

# The best way to get better at {dplyr} is to practice!
# The best way to learn new things in {dplyr} is to try new things!

# ---- Visualizations in {ggplot2} ----

# I'll start by showing you the foundation of ggplot
# Then I'll give you a difficult challenge
# You'll need to use Google, R Cookbook, the cheat sheet
# or other resources to solve every aspect of the challenge!

# ggplot2 is based on the idea that any visualization has three components:
# 1. a data set: what are you trying to look at?
# 2. a coordinate system: the most common is an x and y axis
# 3. a geom: instructions about how you want to visualize the
## data set on the coordinate system

# ggplot2 uses layers to build plots
# every plot starts with the basic layer:
ggplot()
# note two things here: 1) the function is ggplot() not ggplot2()
# 2) running this doesn't give you an error; instea a grey square
# shows up in the lower right hand side of RStudio
# This is good! We're initializing a plot.

# We need our first component: a data set
ggplot(gapminder)
# Note: still doesn't give an error
# we have initialized a plot and supplied a data set

# Second component: a coordinate system
# Let's stick with the standard x, y axes
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp))
# Notes: 1) we are stating that we want gdpPercap on the x axis
# and lifeExp on the y axis
# 2) These arguments are INSIDE a new function called aes()
# Essentially: if something is inside aes(), it means that
# ggplot needs to refer to the data set you provded to get
# the information; gdpPercap and lifeExp are part of the data set
# No error, but now we have labels on our axes and appropriate ranges

# Third component: a geom
# We are going to add a geom as a new layer of our plot:
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()
# Notice when you start to type geom_ there are lots of options that come up

# You can also specifiy the coordinate system in the geom
# instead of in the ggplot()
ggplot(gapminder) +
  geom_point(aes(x = gdpPercap, y = lifeExp))

# Adding colour
# Goal: make points blue  
ggplot(gapminder) +
  geom_point(aes(x = gdpPercap, y = lifeExp), col = "blue")
# Why does col go outside of aes()
# Because "blue" has nothing to do with our data set

# Adding colour based on the data
# Goal: make points colour based on continent
ggplot(gapminder) +
  geom_point(aes(x = gdpPercap, y = lifeExp, col = continent))
# Notice that now col in inside aes()
# Because ggplot needs to refer back to the data set gapminder
# to find the information it needs to assign colours

# Exercise:
# Do as much of this as you can; if there are steps
# you can't figure out, work with your neighbour!
# (a) plot life expectancy (y) by year (x) as a scatterplot
# (b) colour points by continent
# (c) Add a new layer of geom that
## draws a line for each country, connecting the points
## This is tricky!!
# hint: geom_line
# hint: group = country
ggplot(gapminder) +
  geom_point(aes(x = year, y = lifeExp, col = continent)) +
  geom_line(aes(x = year, y = lifeExp, group = country, col = continent))

# Does the same thing
ggplot(gapminder, aes(x = year, y = lifeExp, col = continent)) +
  geom_point() +
  geom_line(aes(group = country))
# Because things in ggplot() become your "default" settings
# for all layers in the plot


# You can store ggplot plots as objects !
# Maybe you want two versions of a plot; the first
# is just the points, the second is the points and the lines
plot1 <- ggplot(gapminder, aes(x = year, y = lifeExp, col = continent))+
  geom_point()
plot1 # show plot1

# You can add layers to existing plots!
plot2 <- plot1 + geom_line(aes(group = country))
plot2 # show plot2

# It's kind of messy; what if we had a separate
# plot for each continent?
# Called "facetting"
plot3 <- plot2 + facet_wrap(~continent)
plot3

# More options
# There are lots of different themes out there
# I like theme_bw() which is simple black and white;
# the number relates to the relative size of the font
plot3 + 
  theme_bw(18) + 
  xlab("Year") + 
  ylab("Life Expectancy")

# Here's a difficult challenge!
# Reproduce the plot found here:
# 
# Here is a list of things you'll
# need to do; just see how many you can figure out!

# pre-plotting:
# (a) subset for data from 2007

# plotting:
# (a) boxplots with continent on x axis
## and life expectancy on y axis
# (b) x axis label is Continent
# (c) y axis label is Life Expectancy
# (d) theme is black and white
# (e) add points
# (f) hmm.. why do my points line up over continent?
## hint: try geom_jitter()
# (g) colour points based on gdpPercap
# (h) make points triangles (r cookbook for help..!)
# (i) specificy that low values are red and high values are green
## hint: try using the terms
## "ggplot" "colour" and "gradient"!
# (j) name the legend GDP per Capita
## hint: add "name =" argument to step i!
# (k) store your final plot in an object called myfigure
# As you solve each piece, add an "x" next to it on the 
# etherpad

# Solution:
# You can pipe directly into ggplot()!!
myfigure <- gapminder %>% 
  filter(year == 2007) %>%
  ggplot() +
  geom_boxplot(aes(x = continent, y = lifeExp)) +
  geom_jitter(aes(col = gdpPercap), shape = 17, width = 0.25) +
  scale_colour_gradient(low = "red", 
                        high = "green",
                        name = "GDP per Capita") +
  xlab("Continent") + ylab("Life Expectancy") +
  theme_bw(12)

# Saving plots to your current working directory
ggsave("myfigure.png", myfigure)
