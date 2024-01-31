## make homology chart of uniprot proteins

#set wd
setwd("C://Users//laura//OneDrive//Documenten//Bern//Universiteit//HS2023//SBL.30004_Organization & Annotation of Eukaryote Genomes//Exercises//Uniprot")

#Load library
library(dplyr)

#load blast output
blast_data <- read.delim("blastp.out", header=F)

#Count unique lines:

#total proteins
nrow(blast_data %>% distinct(V1)) #19426

#homologous proteins
sum(blast_data$V3 >= 98) #13873

percentage <- 13873 / 19426 #71.4% homologous, 28.6 non-homologous

#chart
pie(c(19426, 5553), labels=c('Homologous = 71.4%', 'Non-Homologous = 28.6%'), col=c('#FF7F00', '#FF1493'))
