# ---- set working directoy ----


# ----- load packages ----
library(dplyr)
library(ggplot2)

# ---- load data -----
crickets<-read.csv("crickets.csv")
fly<-read.csv("flywinglength.csv")
dietdata<-read.csv("stcp-Rdataset-Diet.csv")

# ---- check data -----
dim(crickets)
head(crickets)
summary(crickets)
str(crickets)

# ---- Visualize my data -----
# mini challenge: plot temperature on x axis, chirps on y axis

ggplot(crickets,aes(x=temp_F,y=chirps_sec))+geom_point(size=3)+
  theme_classic()

# ----- introduce linear models in R -----
# function we will use is lm()
# lm(y~x,data=mydata)

# Does temperature effect chirps/sec?
model1<-lm(chirps_sec~temp_F,data = crickets)
model1

# ---- Model Diagnostics -----
# Check our residuals
ggplot(model1,aes(x=fitted(model1),y=resid(model1)))+
  geom_point()+
  geom_hline(yintercept = 0,colour='red')
hist(resid(model1))
qqnorm(resid(model1))
ggplot(model1,aes(x=lag(resid(model1)),y=resid(model1)))+
  geom_point()

# ---- Evaluate model! -----
summary(model1)

anova(model1)

#----- plot model1 (crickets) with our linear regression line ----
ggplot(crickets,aes(x=temp_F,y=chirps_sec))+geom_point()+
  geom_smooth(method="lm")+theme_classic()

# ----- Linear Model with One-Way Anova ----
head(fly)

fly<-stack(fly)
fly
names(fly)<-c("wing_length","group")
head(fly)
summary(fly)

# Question: do wing lengths vary between groups?
# remember to always check structure!
str(fly)

# Research question:
# Does wing length vary between groups?
# set up your linear model using lm()
model2<-lm(wing_length~group,data=fly)
model2

# ---- model diagnostics ----
plot(model2)
hist(resid(model2))
plot(x=lag(resid(model2)),y=resid(model2))

# ---- Evaluate model -----
summary(model2)
anova(model2)

# --- plot flywing length -----
# plot on the x will be group
ggplot(fly,aes(x=group,y=wing_length))+geom_boxplot()

# with last few minutes, you can work on previous problems
# ask questions

# Challenge: load our third dataset (stcp-Rdataset-Diet.csv)
# 2 factor (thats the challenge part) effect of diet and gender on
# weight loss
names(dietdata)
dietdata<-mutate(dietdata,weight_lost=pre.weight-weight6weeks)
str(dietdata)
model3<-lm(weight_lost~factor(diet)*factor(gender),data=dietdata)
model3
plot(model3)

summary(model3)
anova(model3)
