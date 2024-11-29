## code to prepare `Species` dataset goes here
library(dplyr)

species <- read.csv("data-raw/Species.csv")
species <- species[,1:3]
taxonomy <- read.csv("data-raw/TaxonomyPlus.csv") |> dplyr::select(species, accepteret_dansk_navn)

species <- species |>
  dplyr::left_join(taxonomy)

species <- species %>%
  mutate(accepteret_dansk_navn = iconv(accepteret_dansk_navn, from = "", to = "UTF-8"))


usethis::use_data(species, overwrite = TRUE)
