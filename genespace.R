library(ggplot2)
library(GENESPACE)

#Run init_genespace to make sure that the input data is OK. It also produces the correct directory structure and corresponding paths for the GENESPACE run
    gpar <- init_genespace(wd = "/data/users/ldekker/assembly_annotation_course/results/genespace", path2mcscanx = "/data/users/ldekker/assembly_annotation_course/results/MCScanX-master")
#Run genespace
    out <- run_genespace(gsParam = gpar, overwrite = T)
