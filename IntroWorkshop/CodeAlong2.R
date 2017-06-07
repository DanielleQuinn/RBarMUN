# ---- Set Working Directory ----
# The working directory is the location (folder)
# that R is going to communicate with when
# importing files, exporting figures, etc.

# Prints your current working directory; no arguments needed
getwd()

# You will need to change this to be your own working directory:
setwd("C:/Users/danie/Desktop/RBarMUN") # Define your working directory
  # Hint: Use the tab key to easily navigate folders

# ---- Load Packages ----
library(dplyr)
library(lubridate)

# ---- Import Data ----
mydata<-read.delim("sampledata.txt")
  # creates an object (container) called mydata which contains your 
  # flat file (spreadsheet) sampledata.txt as a data frame with
  # rows and columns

# ---- Data Frames: Basics ----
View(mydata) # Spreadsheet of data frame in new tab
dim(mydata) # Dimensions (rows, columns)
head(mydata) # Output te first six rows
str(mydata) # Structure of each variable
summary(mydata) # Summary of each variable
names(mydata) # Variable (column) names

# ---- Data Frames: Each Column is a Vector ----
# Each column (variable) is denoted by $
mydata$length # Outputs the contents of the column called length
              # in the object mydata (which is a data frame) as a vector

# Indexing works the same way as any other vector
mydata$length[5] # Outputs the 5th element of the vector

# ---- Exercise 1: Conditional Indexing (Columns) ----
# Create an object called adultlengths that contains all values
# of the length column that are greater than 10

# What about NA values?
# To omit NAs, add a secondary argument

# ---- Data Frames: Data Frames are Two Dimensional ----
# We need to provide two values (rows and columns) when indexing
# R uses [row, column] assignment
mydata[1,2] # Outputs the value of row 1, column 2

mydata[1:5, c(1:3,6)] # Outputs the values of rows 1 to 5
                      # and columns 1, 2, 3, and 6

# You can leave a dimension blank to select all
mydata[,3] # Outputs all rows and column 3
mydata[1:5,] # Outputs rows 1 to 5 and all columns

# ---- Exercise 2: Conditional Indexing (Data Frames) ----
# Create an object called adultdata that contains records
# (i.e. all columns) of individuals with a length greater
# than 10

# ---- Data Frames: Modifying Variables ----
# Add a new variable (column) called ratio
mydata$ratio<-mydata$length/mydata$weight

# Make the variable eggs represent presence/absence
# Where eggs is greater than 0, change to 1
mydata$eggs[mydata$eggs>0]<-1

# Males should all have NA values for eggs
mydata$eggs[mydata$sex=="m"]<-NA

# ---- Formatting Dates ----
# Step 1: Create a character vector where each element
# is formatted as "dd-mm-yyyy" from the year, month, and day columns
# of mydata using the paste() function and place it in an object called myvec
myvec<-paste(mydata$day, mydata$month, mydata$year, sep="-")
  # sep argument defines what character we want to use to separate each component
# Step 2: Use this object as the argument for dmy() and place the resulting
# vector in an object called mydates
mydates<-dmy(myvec)
# Step 3: Create a new column called date which contains the vector
# of formatted dates
mydata$date<-mydates

# ALTERNATIVELY, nest all of these steps into a single line of code!
mydata$dates<-dmy(paste(mydata$day, mydata$month, mydata$year, sep="-"))

# ---- Exercise 3: Formatting Date Time ----
# Use dmy_hms() to create a column in mydata called datetime
# that contains both date and time information

# ---- Summarizing Data ----
# There are many simple ways to summarize your data
# Each method has pros and cons; your use will change depending
# on the situation

# For simple frequencies, use table()
table(mydata$year) # How many records do we have per year?
table(mydata$year, mydata$sex) # How many records do we have for each sex, per year?

# {dplyr} is a package that can be used for summarizing data in a flexible,
# customizable, and intuitive way without worrying about indexing
# or looping

# Filter mydaya to only include data from June
# Option 1: Indexing
mydata[mydata$month==6,]
# Option 2: dplyr
mydata%>%filter(month==6)

# Generate a table of mean length per month
table1<-mydata%>%
  group_by(month)%>%
  summarise(mlength=mean(length, na.rm=TRUE))%>%
  ungroup()%>%
  data.frame()
table1

# ---- Exercise 4: Generating Tables with dplyr ----
# Use dplyr to generate a table containing the mean weights of individuals
# with a length greater than 10, by both sex and year, along with the standard
# deviation around those means.

# ---- Exercise Solutions ----
# Exercise 1
# Create an object called adultlength that contains all values
# of the length column that are greater than 10
adultlengths<-mydata$length[mydata$length>10]

# What about NA values?
# To omit NAs, add a secondary argument
adultlengths<-mydata$length[mydata$length>10 & !is.na(mydata$length)]

# Exercise 2
# Create an object called adultdata that contains records
# (i.e. all columns) of individuals with a length greater
# than 10
adultdata<-mydata[mydata$length>10,] # Includes records with length is NA
adultdata<-mydata[mydata$length>10 & !is.na(mydata$length),] # Omits records with length is NA

# Exercise 3: Formatting Date Time
# Use dmy_hms() to create a column in mydata called datetime
# that contains both date and time information
mydata$datetime<-dmy_hms(paste(mydata$day, mydata$month, mydata$year, mydata$hour, mydata$minute, mydata$second, sep="-"))

# Exercise 4: Generating Tables with dplyr
# Use dplyr to generate a table containing the mean weights of individuals
# with a length greater than 10, by both sex and year, along with the standard
# deviation around those means.
table2<-mydata%>%
  filter(length>10)%>%
  group_by(year, sex)%>%
  summarise(mweight=mean(weight, na.rm=TRUE),
            sd=sd(weight, na.rm=TRUE))%>%
  ungroup()%>%
  data.frame()
table2
