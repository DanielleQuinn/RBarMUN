# ---- Set Working Directory ----
setwd("C:/Users/danie/OneDrive/DQ_Documents/R/MUN/OSC Seminar/Data Cleaning")

# ---- Read in Data ----
data<-read.delim("taxonomy_data.txt")
tax<-read.delim("taxonomy_reference.txt")

# ---- FUNCTION: clean_taxonomy() ----
clean_taxonomy<-function(myinput)
{
  myinput$fixednames<-NA
  myinput$type<-NA
  myinput$original<-tolower(gsub(" ","",gsub("[[:punct:]]", "", gsub(" spp", "", gsub("unknown ", "", myinput$fish_id)))))
  
  tax$fixednames<-paste(tax$genus, tax$species)
  tax$gensp<-tolower(gsub("[[:punct:]]", "", gsub(" ","",paste(tax$genus, tax$species))))
  tax$reforder<-tolower(gsub("[[:punct:]]", "", tax$order))
  tax$reffamily<-tolower(gsub("[[:punct:]]", "", tax$family))
  tax$refgenus<-paste0(tolower(gsub("[[:punct:]]", "", tax$genus)))
  
  myinput$type[which(myinput$original %in% tax$gensp)]<-"gensp"
  myinput$type[which(myinput$original %in% tax$reforder)]<-"order"
  myinput$type[which(myinput$original %in% tax$reffamily)]<-"family"
  myinput$type[which(myinput$original %in% tax$refgenus)]<-"genus"
  myinput$type[myinput$original=="unidentifiedfish"]<-"error"
  
  for(i in which(myinput$original %in% tax$gensp)) {myinput$fixednames[i]<-as.character(tax$fixednames[tax$gensp==myinput$original[i]])}
  for(i in which(myinput$original %in% tax$reforder)) {myinput$fixednames[i]<-as.character(unique(tax$order[tax$reforder==myinput$original[i]]))}
  for(i in which(myinput$original %in% tax$reffamily)) {myinput$fixednames[i]<-as.character(unique(tax$family[tax$reffamily==myinput$original[i]]))}
  for(i in which(myinput$original %in% tax$refgenus)) {myinput$fixednames[i]<-as.character(unique(tax$genus[tax$refgenus==myinput$original[i]]))}
  
  return(myinput[, -which(names(myinput)=="original")])
}

# ---- FUNCTION: expand_taxonomy() ----
expand_taxonomy<-function(myinput)
{
  myinput$order<-NA
  myinput$family<-NA
  myinput$genus<-NA
  myinput$species<-NA
  myinput$common_name<-NA
  
  myinput$order[myinput$type=="order"]<-myinput$fixednames[myinput$type=="order"]

  myinput$family[myinput$type=="family"]<-myinput$fixednames[myinput$type=="family"]
  for(i in which(myinput$type=="family")) {myinput$order[i]<-as.character(unique(tax$order[tax$family==myinput$fixednames[i]]))}

  myinput$genus[myinput$type=="genus"]<-myinput$fixednames[myinput$type=="genus"]
  for(i in which(myinput$type=="genus"))
  {
    myinput$order[i]<-as.character(unique(tax$order[tax$genus==myinput$fixednames[i]]))
    myinput$family[i]<-as.character(unique(tax$family[tax$genus==myinput$fixednames[i]]))
  }
  
  for(i in which(myinput$type=="gensp"))
  {
    myinput$order[i]<-as.character(unique(tax$order[paste(tax$genus, tax$species)==myinput$fixednames[i]]))
    myinput$family[i]<-as.character(unique(tax$family[paste(tax$genus, tax$species)==myinput$fixednames[i]]))
    myinput$genus[i]<-as.character(unique(tax$genus[paste(tax$genus, tax$species)==myinput$fixednames[i]]))
    myinput$species[i]<-as.character(unique(tax$species[paste(tax$genus, tax$species)==myinput$fixednames[i]]))
    myinput$common_name[i]<-as.character(unique(tax$common[paste(tax$genus, tax$species)==myinput$fixednames[i]]))
  }
  
  return(myinput)
}

# ---- Step 1: Clean Taxonomy ----
newdata<-clean_taxonomy(data)
newdata<-newdata[!newdata$type=="error",]

# ---- Step 2: Expand Taxonomy ----
newdata<-expand_taxonomy(newdata)

# ---- Step 3: Check Lengths ----
for(i in which(newdata$type=="gensp"))
{
  reflen<-tax$max_tl_mm[paste(tax$genus, tax$species)==newdata$fixednames[i]]
  if(newdata$length_mm[i]>reflen) print(paste("ERROR: Check row", i, ";", newdata$fixednames[i], "length", data$length_mm[i], "max length", reflen))
}

View(data)
newdata
