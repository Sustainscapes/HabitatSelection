## code to prepare `Species` dataset goes here


species <- read.csv("data-raw/Species.csv")
species <- species[,1:3]

usethis::use_data(species, overwrite = TRUE)
