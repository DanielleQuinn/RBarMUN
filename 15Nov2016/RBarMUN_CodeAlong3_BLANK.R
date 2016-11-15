# ---- Import Data ----

# ---- Dates in {lubridate} ----
# "dd-mm-year"
# Use the paste() function to create a vector of class character
# Wrap this vector in dmy() and use it to create a new column

# Take a look!
 # You can see the new column, of class POSIX (date)
 # The date column, as a vector of class POSIX

# ---- Exercise 2.1 ----
# (A) Use dmy_hms() to create a column in exdata called
# datetime that contains both date and time information.

# ---- Summary Stats ----
# There are many simple ways to summarize data
# Counts
 # How many records per year?
 # How many records per year, by sex?

# Statistics
library(doBy) # You'll need to load this library
# ^ How should we deal with this new package?
# Create a Load Packages Section at the beginning of your script!

# summaryBy find the mean value by default

# You can specify other functions using the FUN argument

# ---- Summary Stats Using {dplyr} ----
# filter() simplified conditional indexing
# select() simplified conditional indexing
# group_by() stratify by a variable
# summarise() apply flexible summary stats
# %>% "pipe"; pass results on left to function on right

# NOTE: summarise() is NOT the same as summarize(); use 's' not 'z'!

# Subset mydata to only look at males
# Option 1 (indexing)
# Option 2 (dplyr)

# Subset mydata to only look at year and length columns
# Option 1 (indexing)
# Option 2 (dplyr)

# Find the mean length by year
# Option 1 (indexing and looping)

# Option 2 (summaryBy)

# Option 3 (dplyr)

# Indexing, looping, table(), summaryBy(), and {dplyr} all
# have pros and cons; you'll likely use all of them
# at some point, depending on the circumstances

# ---- Exercise 2.2 ----
# Use {dplyr} to generate a summary table of
# the mean weights of individuals with a length
# greater than 10, by both sex and year, along
# with the standard deviation around those means


# Note: Here's the indexing / looping solution
year<-unique(mydata$year)
sex<-c()
mweight<-c()
sdweight<-c()
for(i in year)
{
  for(ii in unique(mydata$sex))
  {
    sex.in<-as.character(ii)
    sex<-c(sex, sex.in)
    x<-mydata$weight[mydata$length>10 &
                       !is.na(mydata$length) &
                       mydata$year==i &
                       mydata$sex==ii]
    mweight.in<-mean(x, na.rm=TRUE)
    mweight<-c(mweight, mweight.in)
    sdweight.in<-sd(x, na.rm=TRUE)
    sdweight<-c(sdweight, sdweight.in)
  }
}
table2<-data.frame(year, sex, mweight, sdweight)
table2

# And here's the summaryBy solution
table2<-summaryBy(weight~year+sex,
          data=mydata[mydata$length>10 & !is.na(mydata$length),],
          FUN=c(mean, sd),
          na.rm=TRUE)
names(table2)<-c("year","sex","mweight","sdweight")
table2

# ---- Exercise Solutions ----
# Exercise 2.1
# (A)
dtvec<-paste(exdata$day, exdata$month, exdata$year, exdata$hour, exdata$minute, 0, sep="-")
exdata$datetime<-dmy_hms(dtvec)
# or, in a single line of code
exdata$datetime<-dmy_hms(paste(exdata$day, exdata$month, exdata$year, exdata$hour, exdata$minute, 0, sep="-"))

# Exercise 2.2
# (A)
table2<-mydata%>%
  filter(length>10)%>%
  group_by(year, sex)%>%
  summarise(mweight=mean(weight, na.rm=TRUE),
            sdweight=sd(weight, na.rm=TRUE))%>%
  data.frame()
table2
