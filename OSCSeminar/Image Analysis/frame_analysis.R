# ---- Set Working Directory ----
setwd("C:/Users/danie/OneDrive/DQ_Documents/R/MUN/OSC Seminar/Image Analysis/Video Frames")

# ---- Load Packages ----
library(EBImage)

# ---- FUNCTION: prepimage() ----
# Prepares image for analysis and extracts pixel values
prepimage<-function(imagefile, sigmaval)
{
  # Step 1: Read in image
  newimage<<-readImage(imagefile)
  # Step 2: Extract values
  imagedata<<-newimage@.Data
  return(imagedata)
}

# ---- Look for differences between frames ----
results<-c()
for(i in 2:length(list.files(pattern=".jpg")))
{
  setA<-prepimage(list.files(pattern=".jpg")[i])
  setB<-prepimage(list.files(pattern=".jpg")[i-1])

  rA<-rowMeans(setA)
  rB<-rowMeans(setB)
  cA<-colMeans(setA)
  cB<-colMeans(setB)
  
  rw<-wilcox.test(rA, rB)$p.value
  cw<-wilcox.test(cA, cB)$p.value
  
  if(rw|cw<0.05) {results.in<-"Y"}
  if(rw & cw>=0.05) {results.in<-"N"}
  results<-c(results, results.in)
}

x<-data.frame(frameA=2:length(list.files(pattern=".jpg")),
           frameB=1:(length(list.files(pattern=".jpg"))-1),
           results)

View(x)
