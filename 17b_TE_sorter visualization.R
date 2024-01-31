#Visualize the results of the TE sorter

#Set working directory to where the EDTA.TEanno.gff3 file is
setwd("C:/Users/laura/OneDrive/Documenten/Bern/Universiteit/HS2023/SBL.30004_Organization & Annotation of Eukaryote Genomes/Exercises/TE sorter visuals")

#Load packages
library(rtracklayer)
library(RColorBrewer)

#Function to round to millions
round_millions <- function(num){
  return(ceiling(num/1e+06)*1e+06)
}

#import gff
gff <- rtracklayer::import('pilon_flye.fasta.mod.EDTA.TEanno.gff3')
gff_df <- as.data.frame(gff)

#Count entries/features for each scaffold
scaffold_counts <- table(gff_df$seqnames)
largest_scaff <- names(which.max(scaffold_counts))
print(paste("The scaffold with the most entries is:", largest_scaff, "with", scaffold_counts[largest_scaff], "entries."))
largest_scaff_gff <- subset(gff_df, gff_df$seqnames == largest_scaff)

#Get the bins
max_bp <- max(largest_scaff_gff$start)
max_bp_round <- round_millions(max_bp)
max_bin <- max_bp_round/1e+06
bin_ends <- seq(1, max_bin)
bin_strings <- string_sequence <- paste0(bin_ends - 1, "-", bin_ends, "Mbp")

#Get clades (superfamilies)
clades <- unique(largest_scaff_gff$Classification)
num_clades <- length(clades)
clades_bins <- matrix(data = NA, nrow = num_clades, ncol = max_bin, dimnames = list('clades'= clades, 'bins' = bin_strings))

#Fill in bins
for(clade in clades){
   for(bin_num in 1:max_bin){
     bin_start <- (bin_num-1) * 1e+06
     bin_end <- (bin_num) * 1e+06
     clades_bins[clade, bin_num] <- sum(largest_scaff_gff$Classification == clade & largest_scaff_gff$start >= bin_start & largest_scaff_gff$start < bin_end)
   }
}

#Initialize pdf for plots
pdf(paste0('TEs_by_Clades_and_Range', largest_scaff, '.pdf'), width = max_bin + 2, height = 6)
par(mar = c(7, 4.5, 5, 2.5))

#create color palate
colors_clades <- brewer.pal(min(8, num_clades), "Set3")
if(num_clades > 8) {
  colors_clades <- colorRampPalette(colors_clades)(num_clades)
}

#Plot 1
barplot(clades_bins,
       beside = F, col = colors_clades, border = "white",
       xlab = "Range (start position)",
       ylab = "Frequency",
       main = paste0("TEs by Clades and Range for ", largest_scaff),
       cex.names = 0.8, las = 1)
legend('topright', legend = clades, fill = colors_clades,
      cex = 0.8, bty = "n", inset = c(0.1, 0.05))

#New color palate
colors_bins <- brewer.pal(min(8, max_bin), "Paired")
if(max_bin > 8) {
  colors_bins <- colorRampPalette(colors_bins)(max_bin)
}

#Plot 2
barplot(t(clades_bins),
       beside = T, col = colors_bins, border = "white",
       ylab = "Frequency",
       main = paste0("TEs by Clades and Range for ", largest_scaff),
       cex.names = 0.8, las = 2)
mtext("Clade", side = 1, line = 5)
legend('topright', legend = bin_strings, fill = colors_bins,
      cex = 0.8, bty = "n", inset = c(0.1, 0.05))
dev.off()