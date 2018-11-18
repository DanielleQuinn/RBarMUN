# Analysis of biodiversity in R with vegan
# MUN RBar - November 5th, 2018

# see the full tutorial at
# https://gitlab.com/JoMarino/rtutorials/blob/master/vegan_diversity.ipynb  

# preliminaries ----

# install vegan
install.packages("vegan")

# load vegan
library("vegan")

# we will use one of vegan's native data sets 
# load data
data(dune)

# explore interal structure of data
str(dune)

# look at data
View(dune)

# the input data frame for vegan must be structured with the species as column headers and the localities as rows

# diversity indices ----

# calculate number of species
richness <- specnumber(dune)

# calculate Shannon-Wienner diversity index
shannon <- diversity(dune, index = "shannon")
shannon

# calculate inverse Simpson diversity index
inv_simpson <- diversity(dune, 
                         index = "invsimpson")

# look at the help for the diversity function
? diversity

# exercise
# plot Shannon-Wienner index across sites
barplot(shannon)

# similarity indices ----

# calculate Bray-Curtis dissimilarity
bray <- vegdist(dune, 
                method = "bray")
bray

# calculate another version of Jaccard's coefficient
jaccard <- designdist(dune,
                      method = "a/a+b+c",
                      terms = "binary",
                      abcd = TRUE)
jaccard

# calculate percent similarity matrix
percent_similarity <- decostand(dune, 
                                method = "total")

# confirm that the result are relative abundances
# sum percent_similarity across dimension 1 (sites)
apply(percent_similarity, 1, sum)

# species accumulation ----

# get species accumulation data
curve1 <- specaccum(dune)
# plot data
plot(curve1)

# use another method to accumulate species
curve2 <- specaccum(dune,
                    method = "random")
# make a nicer plot
plot(curve2, 
     ci.type = "poly",
     col = "blue",
     lwd = 2,
     ci.lty = 0,
     ci.col = "lightblue")

# rarefaction ----

# first, get the minimum sample size
min <- min(apply(dune,1,sum)) 
min

# get rarefied species data
# the input is the data frame with species abundances
# and the sample size we just calculated
dune_rarefied <- rarefy(dune,
                        min)

# make a plot
richness <- specnumber(dune)
plot(richness, dune_rarefied,
     xlab = "Observed # of species",
     ylab = "Rarefied # of species")


# hierarchical clustering ----

# cluster communities
# input = similarity matrix
dune_bray_clust <- hclust(bray)

plot(dune_bray_clust,
     ylab = "Bray-Curtis dissimilarity")


# non-metric multidimensional scaling -----

# calculate ordination
dune_mds <- metaMDS(dune, dist = "bray")

# calculate fit of model (stress)
dune_mds$stress

# make a plot of stress
stressplot(dune_mds)

# see the result of the ordination for the sites
ordiplot(dune_mds, 
         display = "sites",
         type = "text") 

# plot species and sites
ordipointlabel(dune_mds)

# the result can be improved by adding more data
# load environmental data
data(dune.env)

# look at the structure of the data
str(dune.env)

# make an empty plot
dune_mds_plot <- ordiplot(dune_mds, 
                         type = "none")
# add points according to environmental data
# in this case type of management
points(dune_mds_plot, 
       "sites",
       col = "green",
       pch = 19, # fill circles
       select = dune.env$Management == "BF")
points(dune_mds_plot, 
       "sites",
       col = "blue",
       pch = 19, # fill circles
       select = dune.env$Management == "HF")
points(dune_mds_plot, 
       "sites",
       col = "purple",
       pch = 19, # fill circles
       select = dune.env$Management == "NM")
# add ellipses around sites
ordiellipse(dune_mds, 
            dune.env$Management,
            conf = 0.95)
# add Bray-Curtis cluster dissimilarity to sites
ordicluster(dune_mds, 
            dune_bray_clust,
            col = "black")


# canonical correspondance analysis ----

# calculate ordination according to environmental data
mod <- cca(dune ~ Management, dune.env)

# plot the result       
plot(mod, type = "none",
     scaling = "symmetric")
# add ellipses according to management type
pl <- with(dune.env, ordiellipse(mod, Management, 
                                 scaling = "symmetric", 
                                 kind = "ehull", col = 1:4),
           label = TRUE)
