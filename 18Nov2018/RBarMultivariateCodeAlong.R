#Hello all, and thank you for attending Rbar! 
#This session will focus on multivariat statistics and using it with intention
#and confidence. Multivariate statistics (MS) is usually used in exploratory analysis.
#MS can also be explanatory, but the very nature of MS makes the explanations a little
#hard for us to grasp. That is part of why MS has got a little bit of a reputation. 

#Throughout this session we will use the Vegan package and two of the datasets 
#included in the package: varespec and varechem. Varespec contains the relative cover
#of 44 species in 24 sites. Varechem contains information of 14 environmental variables
#of the *same* 24 sites. 

# --- Here we are going to load Vegan and the datasets --- 

#First I will show why multivariat statistics is useful and interesting
#We are used to plotting variables with the dependent variable on the y-axis
#And the independent on the x-axis. However, we can plot variables on their own too

# --- Here we will go over some stats that you all know and plot a single variable ---

#By adding a second axis we get the normal scatter plot

# --- 
#Here we will go over some more basics: linear model, corelation and plotting
#of one dependent and one independent variable. 
# --- 


#In principle we could do this for each pair of environmental variable and species. 
#This would require 616 plots and interpreting them as a whole would be almost
#impossible. In an other scenario we might not even be interested in how abundance and
#environment varies, but rather how similar sites are. In that case do we use species
#data, environmental data, both? How can we summarize the distances between sites?

#---
#Here we will look at stripcharts of the relative abundances and environmental variables.
#---

#Say we want to know the distance between the sites with respec to environmental
#variables:

#--- use vegdist to find the distances between sites based on env variables ---

#We are visual beings and this is very hard for us to interpret.
#We cannot make a 44 dimensional plot either. So we want to make a 2d plot that is
#as faithful to the complex distances as possible.

#--- 
#Here we will use metaMDS to visualize distances between sites with respect to
#environmental variables
#--- 

#MDS is a great tool to visualize data in many dimensions collapsed down to 2d.
#There is one draw back: metaMDS uses PCA to produce more meaningful axes and here 
#comes an important point: PCA  and abundances do not produce good results. MDS is a 
#great tool that should mainly be used on concrete variables and things like
#counts of individuals 

#So now we want to move to a simple multivariat hypothesis test. #Let's say that we
#are interested in whether P makes a difference for the relative cover of the 3 
#most common species. This is one of the simplest multivariat statistical analyses:
#MANOVA


#---
#Here we will perform MANOVA of the 3 most common species, Cladstel, Cladrang
#and Pleuschr and summarize the results. MANOVA is similar to a normal ANOVA except that we have multiple independent variables.
#---

#MANOVA does not test for differences of means between treatment groups, but rather 
#differences of means within a treatment groups for different respons variables.


#Okay, let's combine exploratory and explanatory analysis for a bit. We are going
#Correspondance analysis (CA). CA is a tool mainly used for finding gradients between
#sites or other things like use of certain letters for different authors. Here the
#The axes are relevant and represent a loading of variables: In our case species
#cover and environmetal variables respectively

#---
#Here we will perform a CA of species and one of environmental variables and plot
#them side by side
#---

#We can also use the environmental data to find out how species abundances
#respond to environmental gradients.

#---
#Here we will extract the CA axis 1&2 and build linear models of environmetal 
#variables to fit the axes.
#---

#Based on this we can make a direct ordination, that shows enviromental gradients,
#species and site ordinations all in one using Canonical Correspondance Analysis
#(CCA)


#--- Here we build, plot and interpret a CCA ---


#This is a little bit of a round-about method of doing a analysis of multivariat
#Linear analysis. Instead we can Canonical Correlation Analysis (CanCor).


#---
#Here we will perform and interpret a CanCor analysis, perform a statistical test
#of the canonical dimensions, compute canonical correlations and plot a CanCor
#For N, P, K of the first 3 species in varespec.
#---

#Finally if we have time I would like to go over a maximum entropy method of 
#predicting multiple respons variables.


#---
#Here we will use maximum entropy to predict the relative abundance of Carex based 
#on 2 traits.
#---
