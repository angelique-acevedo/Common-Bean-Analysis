##DESCRIPTION: This file was used to generate a barplot detailing the AVERAGE segment length (HYP:IN9) between L88 57 High Light, L88 57 Low Light, and Zenith Low Light segments in Figure 8E at plastochron 9 of Onyenedum et al. 2025.

#Packages Required
library(ggplot2)
library(RColorBrewer)

#Load dataset
datum<- read.csv("~/Downloads/Avg_Internode_lengths_Plastochron9.csv", stringsAsFactors=TRUE)

#Organize the order in which the internodes/segments (IN9:HYP) appear on the barplot using the factor function below
datum$Internode <- factor(datum$Internode,levels = c("IN9", "IN8","IN7", "IN6", "IN5", "IN4","IN3", "IN2", "IN1", "Epi", "Hyp"))
datum$Treatment <- factor(datum$Treatment,levels = c("L88 57 Low Light", "L88 57 High Light","Zenith Low Light"))


#Stacked barplot of interode measurements at plastochron 9 for three groups

ggplot(datum, aes(fill=Segment, y=Avg_Length, x=Treatment), group=Treatment) + 
    geom_bar(position="stack", stat="identity")+ #Position = stacked will ensure the bars are lying above one another
    scale_fill_brewer(palette="RdYlBu") +
    theme_bw(base_size = 20) +
    ggtitle("Internode Elongation: Twiner v. Shrub Morphology") +
    ylab("Segment Length (cm)") +
    scale_x_discrete(labels = c('L88 57\n Twiner','L88 57\n Shrub','Zenith\n Shrub'))+ #/n in script will cause text to split and generate on the next line
    scale_y_continuous(breaks = 0:40)
