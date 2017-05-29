# ---- Description ----
# This code can be used to follow along with
# the May 31 2017 R-Bar Workshop
# "Introduction to R and RStudio Part I"
# at Memorial University

# ---- R Basics: Calculator ----
# R follows order of operations
8+7*7/(2+1)-19

# ---- R Basics: Functions ----
# Functions are used to "do things" in R
sqrt(81) # This finds the square root of 81

# Functions usually only accept specific types of arguments
sqrt("a")

# Functions can be nested
sqrt(sqrt(81))

# ---- R Basics: Packages ----
# Packages are stored in your local library
# You only need to install a package once
install.packages("ggplot2")

# You need to load installed packages each time you use R
library(ggplot2)

# ---- R Basics: Help Pages ----
?sum() # Search loaded packages for sum()
??sum() # Search installed packages for sum() and "sum"

# ---- Exercise 1.2 ----
# (A) Use R as a calculator

# (B) Practice some simple functions
# log()
# abs()

# (C) Install and load these packages
# ggplot2
# lubridate
# dplyr
# reshape2

# (D) Bring up the help page for mean()

# ---- R Basics: Objects ----
# An object is a stored value or set of values

# Scalar Objects
# One dimensional, length of one
pi # Built in scalar

myval<-5+10 # Create our own scalar object
myval # Return the value of the object myval

# Vector Objects
# One dimensional, length > one
letters # Built in vector

mycols<-c("red","blue","yellow","green") # Create our own vector object
mycols # Return the value of the object mycols

# ---- R Basics: Data Classes ----
# Variables can have various classes
# Vectors can only contain one class ("atomic")
mycols
class(mycols) # What class is mycols?
as.factor(mycols) # View it as a factor

mycounts<-c(1,6,13,2,"about 5",2)
mean(mycounts) # Average mycounts
class(mycounts) # What class is mycounts?
as.numeric(mycounts)

# ---- R Basics: NAs ----
ncounts<-as.numeric(mycounts) # Convert mycounts to numeric and name it ncounts
mean(ncounts) # Average ncounts

# Most functions have an argument specifically used to ignore NAs
mean(ncounts, na.rm=TRUE) # Default na.rm=FALSE

# ---- Exercise 1.3 ----
# (A) Create a scalar called myname that contains your first name

# (B) Create a vector called mybirthday that contains three numeric elements;
# your day, month, and year of birth

# (C) Create a vector called test that contains both numeric and character
# elements. What does class() tell you about test?

# (D) Convert test to a factor and call it ftest. Now convert ftest
# to a numeric object called ntest. What do you notice about ntest?

# ---- R Basics: Indexing ----
# Positional attributes designated by []
# Used to query objects

# View long vector
1:100

# View shorter vector (mycols)
mycols

# View element in position 3
mycols[3]

# View elements in positions 2 to 4
mycols[c(2:4)]

# View elements in positions 1, 3, and 4
mycols[c(1,3,4)]
mycols[-2]

# ---- R Basics: Conditional Indexing ----
# Are elements are equal to "blue"?
mycols=="blue"

# == asks "does it equal?"
# = sets the value

# Which elements are equal to "blue"?
which(mycols=="blue")

# "Hard coding"
which(mycols=="blue")
mycols[2]

# "Soft Coding"
mycols[which(mycols=="blue")]
# R understands that you want TRUE values only
mycols[mycols=="blue"]

# View elements equal to either "blue" or "green"
mycols[mycols %in% c("blue","green")]

# View elements in mycols that are equal to either
# "blue" or "green"
mycols[mycols %in% c("blue","green")]

# View elements in mycols that are
# not equal to "red"
mycols[!mycols=="red"]

# Create a vector called one_ten containing all
# integers from 1 to 10
one_ten<-1:10
one_ten

# View elements greater than or equal to 8
one_ten[one_ten>=8]

# View elements less than 5 and greater than 2
one_ten[one_ten<5 & one_ten>2]

# View elements less than 3 or greater than 9
one_ten[one_ten<3 | one_ten>9]

# ---- Exercise 1.4 ----
# (A) Create an object called numvals consisting
# of a vector of numeric elements generated
# from a function
# seq()
# rnorm()

# (B) Take a good look at your object
# length()
# max()
# sort()
# unique()
# min()
# quantile()

# (C) Find all values of numvals greater than the average.

# (D) Find all values of numvals that are in the top 10%.
# Store these values in an object called topvals
# Hint: ?quantile()

# ---- Exercise Solutions ----
# Exercise 1.2
# (B)
log10(5)
abs(-4)

# (C)
install.packages(dplyr) # Install dplyr
install.packages(ggplot2) # Install ggplot2
install.packages(lubridate) # Install lubridate
install.packages(reshape2) # Install reshape2

library(dplyr) # Load dplyr
library(ggplot2) # Load ggplot2
library(lubridate) # Load lubridate
library(reshape2) # Load reshape2

# (D)
?mean()

# Exercise 1.3
# (A)
myname<-"Danielle"

# (B)
mybirthday<-c(17,1,1988)

# (C)
test<-c(1,2,"hello",3,"world")
class(test)

# (D)
ftest<-as.factor(test)
ntest<-as.numeric(ftest)
# ntest is a vector of numbers corresponding to factor levels, not actual values

# Exercise 1.4
# (A)
numvals<-seq(from=1, to=200, by=5)
# or
numvals<-rnorm(100, mean=5, sd=3)

# (B)
length(numvals) # How many elements in the vector?
min(numvals) # Minimum value
sort(numvals) # Sort values
unique(numvals) # Show only unique values
max(numvals) # Maximum value
quantile(numvals) # Sample quantiles of various probabilities

# (C)
numvals[numvals>mean(numvals)] # "Give me numvals where numvals is greater than the average of numvals"

# (D)
topvals<-numvals[numvals>quantile(numvals, 0.9)]
# "Give me numvals where numvals is greater than the 0.9 quantile of numvals"