#Generated with Dr. Joyce Onyenedum (Onyenedum Lab)
##DESCRIPTION: This script is generated to produce linegraphs with standard error bars tracking internode development in Appendix S2 of Onyenedum et al. 2025. American Journal of Botany. 

library(devtools)
library(multcompView)
library(ggplot2)
library(ggpubr)
library(plyr)

#Import composite dataset
datum <- read.csv("~/Downloads/InternodeLengths_allStages.csv", stringsAsFactors=TRUE)

#Use the function below to filter the composite dataset and generate a line graph of the segment of your choice. 
#'Total' variable used to generate total height graph 
datum1 <- datum[datum$Segment == "IN1", ]

#Functions below are used to organize dataset into 
datum1$Plastochron <- factor(datum1$Plastochron,levels = c("P0", "P1", "P2","P3", "P4","P5", "P6","P7","P8","P9"))
datum1$Treatment <- factor(datum1$Treatment,levels = c("L88 57 Low Light", "L88 57 High Light", "Zenith Low Light"))
datum1 <- na.omit (datum1)


#Calculate summary statistics
data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=T),
      sd = sd(x[[col]], na.rm=T),
      se = sqrt(var(x[[col]])/length(x[[col]])))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}

datum1<- na.omit (datum1)
head(datum1$Length)
df3 <- data_summary(datum1, varname="Length", groupnames=c("Treatment", "Plastochron"))

pd <- position_dodge(0.3) 

#Generate line plot with SE bars at each plastochron 
p<- ggplot(df3, aes(x=Plastochron, y= Length, colour=Treatment, group=Treatment)) + 
  geom_errorbar(aes(ymin= Length-se, ymax= Length+se), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=3) + 
  xlab("Plastochron") +
  ylab("Segment Length (cm)") +
  ggtitle("Internode 1 Elongation")  + theme(plot.title = element_text(size = 20), 
                             axis.text.x = element_text(size= 12), 
                             axis.text.y = element_text(size = 12), 
                             axis.title.x = element_text(size = 15),  
                             axis.title.y= element_text(size = 15), legend.position = "top") + theme_bw(base_size = 20) +
ylim(0,10)
#ylim (0,40) ##IMPORTANT: Use this ylim for the total height graph

#Set color scheme for three treatment groups 
p<- change_palette(p, c("#648FFF", "#EC632B", "#73C956"))
p
