# ---- Running Code ----
# On windows, Ctrl - Enter to run a line of code
# On Mac Cmd-Enter

# ---- R is a calculator ----
5 + 6
5 - 9 # I'm subtracting 9 from 5
6 * 7
7/13
(4+5)/6

# Square root?
# ---- functions ----
sqrt(81) # find the square root of 81
# here "sqrt" is the name of the function
# 81 is the "argument"

# nesting functions
# the "inside" function is evaluated first
sqrt(sqrt(81))

# this gives an error because of course
# you can't find the sqrt of the letter a
sqrt("a")

# ---- packages ----
# Packages are collections of functions
# built by other users!
install.packages("ggplot2") # only ever do once! (except when updating)
library(ggplot2) # this loads the functions
# every time you start RStudio

# ---- help! ----
# Option 1: Google
# Option 2: Cheat Sheet!
# Option 3: Ask R
?mean  # asking about a specific function
??average # searching for a keyword

# ---- objects ----
# R can store values
x <- 15 # puts the value 15 inside an object called x
y <- 4 + x
# scalars: object that is 1 dimensional
# and has a length of 1
y

# vectors: object that is 1 dimensional
# and has a length > 1
a <- 1:10 # put all integers between 1 and 10
# into the object called a
# each value is called an "element"
a
a + 30 # you can apply mathematical functions
# to all elements in a vector

# how many elements are in the vector called a?
length(a)

# create a vector
# seq() 
# contains all odd numbers between 1 and 30

?seq

# Hint:
b <- seq(from = 1, to = 30, by = 2)
b

b <- c(1, 3, 5, 7, 9) # "c" means "concatenate" or "stick together" as a vector
b

fruit <- c("apple", "orange", "kiwi")
fruit

# vectors are "atomic": they can only contain
# one class of data
b + 15
fruit + 15

class(b) # numeric
class(fruit) # characters (also called "strings")

# You can't mix characters and numbers
# Here eggs will be treated as characters
eggs <- c(3, 6, 10, "missing value", 12)
eggs <- c(3, 6, 10, "8 ", 12)
class(eggs)

mean(eggs) # this means you can't find the
# average number of eggs!

# When dealing with spreadsheets, be careful that
# each column only contains one type of data
# When spreadsheets are imported in R, each colun
# is treated as a vector
