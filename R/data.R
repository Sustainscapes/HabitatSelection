#' Species Dataset
#'
#' A dataset containing the scientific and common names of 998 plant species,
#' including their family, genus, and species names, along with their Danish common names.
#'
#' @format A data frame with 998 rows and 4 variables:
#' \describe{
#'   \item{family}{Character. The family name of the plant species.}
#'   \item{genus}{Character. The genus name of the plant species.}
#'   \item{species}{Character. The scientific name of the plant species.}
#'   \item{accepteret_dansk_navn}{Character. The accepted Danish common name of the plant species.}
#' }
#'
#' @source Internal dataset for the HabitatSelection package.
#'
#' @examples
#' data(species)
#' head(species, 10)
"species"
