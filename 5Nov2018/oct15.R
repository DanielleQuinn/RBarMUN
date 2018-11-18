# ---- set working directory ---


# ---- load data ----
# tab delimted (.txt)
mydata<-read.delim("data/gapminder-2018-10-1.txt") # for .txt files only
# comma separtaed (.csv)
mydata<-read.csv("data/gapminder.csv") # for .csv files only

# if you have not used these packages before (aka never loaded them into your computer)
#install.packages("ggplot2")
#install.packages("dplyr")

# ---- load packages ----
# we are going to use two packages today called dplyr and ggplot2
# packages are codes and functions that are not included in base R functions
# they can be really useful if you want to make your workflow more smooth or
# work on specific analyses
library(dplyr)
library(ggplot2)
# check out ggplot2 and dplyr from your library!!


# --- check our data ---
dim(mydata) # rows x columns
str(mydata) # structure of the data

# ---- dplyr -----
# time for our first dplyr function
# glimpse makes me 
glimpse(mydata) # this is another way to view your data quickly. 
# however it doesn't give you the number of factors

# More dplyr verbs
# last week we learned select and filter
# filter() will 'filter' specific rows
# select() will 'select' specific columns

# ---- Task 1 ----
# filter rows, year to be equal to 1997
# filter(mydata, ) hint: ==
filter(mydata,year==1997)


# ---- Task 2 ----
# select year, pop, lifeExp
# select(mydata, )
select(mydata,year,pop,lifeExp)
names(mydata)

# ---- Task 3 ----
# combine the two functions!
df1<-mydata%>%
  select(year,pop,lifeExp)%>%
  filter(year==1997)
View(df1) # view df1 in a new tab

# ---- summary table ----
# group_by() 
# this function is very important when creating summary tables
# group_by will group your data by a specific variable

# use group_by() to group data by year
mydata%>%
  group_by(year)
# you'll notice nothing seemed to change with our dataframe
# the reason for this is that all we've asked is for data to be 
# grouped by year, but haven't applied a function to change anything

# next we will use summarise()
# summarise will help you create a summary table of your data


# ---- Task 4 ----
# use group_by() and summarise() to look at the mean population by year
mydata%>%
  group_by(year)%>%
  summarise(mean(pop)) # calculate the mean population
# mean() calculates the mean. What would happen if you didn't group your data by year?

# Now we are going to produce the samae table but also have number of observations
# added to the table using 
mydata%>%
  group_by(year)%>%
  summarise(mean(pop),n()) # n() tells you how many observations. You don't need an input!

# mutate() # allows you to make new columsn
df2<-mydata%>%
  mutate(new_lifeExp=lifeExp/1000)
View(df2)

# ---- ggplot2 -----
#plot(x=mydata$continent,y=mydata$lifeExp)

# ggplot works in layers
ggplot(mydata)+
  geom_point(aes(x=gdpPercap,y=lifeExp),col='blue')
names(mydata)
# create colour based on continent 
# the above plot
ggplot(mydata)+
  geom_point(aes(x=gdpPercap,y=lifeExp,colour=continent))
# take the above plot, put all asthetics in the 
# first line ggplot(code here)
# then we are going to add a layer geom_line
# want the line to be grouped by country
ggplot(mydata,aes(x=gdpPercap,y=lifeExp,
                  colour=continent))+
  geom_point()+
  geom_line(aes(group=country))

fig1<-ggplot(mydata,aes(x=gdpPercap,y=lifeExp,
                  colour=continent))+
  geom_point()
fig1+ggtitle("Gapminder Data")+
  theme_classic()

# use dplyr and ggplot together
# we will be using pipes!
# plot year 2007, boxplot [geom_boxplot] 
# of continent and lifeExp
# to add geom_jitter() colour by gdpPercap
mydata%>%
  filter(year==2007)%>%
  ggplot()+
  geom_boxplot(aes(x=continent,y=lifeExp))+
  geom_jitter(aes(x=continent,y=lifeExp,col=gdpPercap))+
  scale_colour_gradient(low="red",
                        high="green",
                        name="GDP per Capita")+
  xlab("Continent")+
  ylab("Life Expectancy")
  