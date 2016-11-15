# ---- Description ----
# This is part II of the code along
# script for the September 14th R 
# Workshop at University of Maine,
# presented by Dr. Trevor Avery and
# Danielle Quinn
# Enjoy!

# ---- Set Working Directory ----
# The working directory is the location (folder)
# that R is going to communicate with when
# importing files, exporting figures, etc.

# Hint: To check your current working directory:
getwd()

# Hint: Use the tab key to easily navigate folders
setwd("C:/Users/danie/Desktop/Maine")

# ---- Load Packages ----
library(ggplot2)
library(lubridate)
library(dplyr)

# ---- Import Data ----
# Single flat file saved as a .txt
mydata<-read.delim("sampledata.txt")
View(mydata)

# ---- Data Frames: Basics ----
View(mydata) # Spreadsheet of data frame in new tab
str(mydata) # Structure of each variable
summary(mydata) # Summary of each variable
dim(mydata) # Dimensions (rows, columns)
head(mydata, n=1) # Output the first six rows
names(mydata) # Variable (column) names

# ---- Data Frames: Each Column is a Vector ----
mydata$length # Outputs the column length as a vector
mydata$length[5] # Outputs the 5th element of the vector

# Output a subset of the mydata$length vector
# where length > 10
mydata$length[mydata$length>10]

mean(mydata$length, na.rm=TRUE)

# Note: To omit NAs, add a secondary argument
mydata$length[mydata$length>10 & !is.na(mydata$length)]

# ---- Data Frames: Data Frames are Two Dimensional ----
mydata[1,2] # Outputs the value of row 1, column 2

mydata[1:5,c(1,2,3,6)] # Outputs the values of rows 1 to 5
  # and columns 1, 2, 3, and 6

# You can leave on value blank to select all
mydata[,3] # Outputs all rows and column 3
mydata[1:5,] # Outputs rows 1 to 5 and all columns

# Output a subset of the mydata data frame
# where length > 10
minlength10<-mydata[mydata$length>10 & !is.na(mydata$length),] # Why does this give you an error?
minlength10

# Correct:
 # Need to include the 2nd dimension (column)

# ---- Data Frames: Modifying Variables ----
# Add a new column (variable)
mydata$ratio<-mydata$length/mydata$weight
mydata$ratio
head(mydata,n=3)

mydata$eggs # Make the variable eggs represent presence/absence

mydata$eggs[mydata$eggs>0]<-1 # Where eggs is greater than 0, change to 1
mydata$eggs

mydata$eggs[mydata$sex=="m"]<-NA # Males should all have NA values for eggs
mydata$eggs

# ---- Exercise 1.6 ----
# (A) Create a subset that contains males
# captured in 2013

# (B) Find the average length of females

# ---- Exercise Solutions ----
# Exercise 1.6
# (A)
male_2013<-mydata[mydata$sex=="m" & mydata$year==2013,]

# (B)
female_meanlength<-mean(mydata$length[mydata$sex=="f" & !is.na(mydata$length)])
# or
female_meanlength<-mean(mydata$length[mydata$sex=="f"], na.rm=TRUE)
