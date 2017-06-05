# ---- Set Working Directory ----
# The working directory is the location (folder)
# that R is going to communicate with when
# importing files, exporting figures, etc.

# Prints your current working directory; no arguments needed

# You will need to change this to be your own working directory:
 # Define your working directory
  # Hint: Use the tab key to easily navigate folders

# ---- Load Packages ----


# ---- Import Data ----

  # creates an object (container) called mydata which contains your 
  # flat file (spreadsheet) sampledata.txt as a data frame with
  # rows and columns

# ---- Data Frames: Basics ----
 # Spreadsheet of data frame in new tab
 # Dimensions (rows, columns)
 # Output te first six rows
 # Structure of each variable
 # Summary of each variable
 # Variable (column) names

# ---- Data Frames: Each Column is a Vector ----
# Each column (variable) is denoted by $
 # Outputs the contents of the column called length
              # in the object mydata (which is a data frame) as a vector

# Indexing works the same way as any other vector
 # Outputs the 5th element of the vector

# ---- Exercise 1: Conditional Indexing (Columns) ----
# Create an object called adultlengths that contains all values
# of the length column that are greater than 10

# What about NA values?
# To omit NAs, add a secondary argument

# ---- Data Frames: Data Frames are Two Dimensional ----
# We need to provide two values (rows and columns) when indexing
# R uses [row, column] assignment
 # Outputs the value of row 1, column 2

 # Outputs the values of rows 1 to 5
                      # and columns 1, 2, 3, and 6

# You can leave a dimension blank to select all
 # Outputs all rows and column 3
 # Outputs rows 1 to 5 and all columns

# ---- Exercise 2: Conditional Indexing (Data Frames) ----
# Create an object called adultdata that contains records
# (i.e. all columns) of individuals with a length greater
# than 10

# ---- Data Frames: Modifying Variables ----
# Add a new variable (column) called ratio


# Make the variable eggs represent presence/absence
# Where eggs is greater than 0, change to 1


# Males should all have NA values for eggs


# ---- Formatting Dates ----
# Step 1: Create a character vector where each element
# is formatted as "dd-mm-yyyy" from the year, month, and day columns
# of mydata using the paste() function and place it in an object called myvec

  # sep argument defines what character we want to use to separate each component
# Step 2: Use this object as the argument for dmy() and place the resulting
# vector in an object called mydates

# Step 3: Create a new column called date which contains the vector
# of formatted dates


# ALTERNATIVELY, nest all of these steps into a single line of code!


# ---- Exercise 3: Formatting Date Time ----
# Use dmy_hms() to create a column in mydata called datetime
# that contains both date and time information

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