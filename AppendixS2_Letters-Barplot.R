## DESCRIPTION: This file was used to generate ANOVA letters detailing the degrees of difference between L88 57 High Light, L88 57 Low Light, and Zenith Low Light segments in Figure 8E of Onyenedum et al. 2025.

library(devtools)
library(multcompView)
library(dplyr)

#Read in the data, this file included all segment measurements for plastochron 9
datum <- read.csv("~/Downloads/Internode_lengths_Stage5.csv", stringsAsFactors=TRUE)

#RemoveNAs from dataset
datum <- na.omit(datum)

#NOTE: The file listed contains multiple internodes/segments (Hyp:IN9) 
##Adjust the line of script below to get the ANOVA letter corresponding to the segment of your choice. 
subset<- subset(datum, Segment == "IN9") 

#ANOVA test across light treatment groups
anova <- aov(Length ~ Treatment, data = subset)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# Generate the compact letters to display
cld <- multcompLetters4(anova, tukey)
print(cld)
