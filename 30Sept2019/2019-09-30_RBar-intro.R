# Intro to R

# R as a calculator ----
16 * 689
45 + 32 + 67

# Running scripts ----
# 1. Run button
# 2. Ctrl+Enter or Command+Enter
# 3. Source button - to run whole script

# Precedence ----
# The order of operations matters
1 + (2 * 3 * 4)
(1 + 2) * 3 * 4

# Functions ----
# R has many built-in functions
# basic syntax: functionname(argument)
sqrt(679)

# Assignment and variables ----
# The assignment operator is '<-'
# Variable names can be letters, numbers, underscores, periods, or a combination
# but they cannot contain spaces
# and capitalization matters
x <- 7
x

y <- 789

# variables can be used in operations
z <- x * y
z

# Data classes ----
# Numeric
w <- 80
class(w)

# Character
word <- "hello"
class(word)

# Logical
test <- FALSE
class(test)

# Data structures: Vectors ----
# c means to combine or concatenate
myvector <- c(1,5,8,19)
myvector

# Functions can be applied to vectors
myvector*15

# Vectors can contain words
colors <- c("red", "green", "purple")
colors
# Vectors can be reassigned
colors <- c("red", "green", "blue")
colors

# Vectors can be used as arguments
# e.g. check the number of elements in a vector
length(colors)

# Vectors can only contain one class of data
# they are "atomic"
primes <- c(2, 3, "five")
class(primes)
primes
primes*2
# results in an error because you cannot do operations on characters

# Getting help ----
# 1. Google and twitter
# 2. Ask R
# ?function name or ??keyword
?length
# or help(functionname)
help("length")
# Cheatsheets
# in Help -> Cheatsheets
# or in RBar website
# https://github.com/DanielleQuinn/RBarMUN/tree/master/30Sept2019/cheat-sheets

# Packages ----
# To install
# install.packages("packagename")
install.packages("ggplot2")

# To load
# library(packagename)
library("ggplot2")

# Excercise
# Install package dplyr
# Don't forget the quotations marks
# when installing!
install.packages("dplyr") 
