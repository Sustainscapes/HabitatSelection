#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd

app_ui <- function(request) {
  tagList(
    fluidPage(
      titlePanel("Habitat Selection for Plant Species in Denmark"),

      sidebarLayout(
        sidebarPanel(
          h3("Environmental Gradients"),

          selectizeInput("user_name", "Enter Your Name:", choices = NULL, options = list(create = TRUE)),

          actionButton("generate_species", "Generate Random Species"),

          textOutput("species_name"),

          # Gradient selection using the reusable module with custom choices
          mod_gradient_axis_ui("axis_open_closed", "Open vs Forest", choices = c("Open", "Forest", "Both", "Don't know")),
          mod_gradient_axis_ui("axis_wet_dry", "Wet vs Dry", choices = c("Wet", "Dry", "Both", "Don't know")),
          mod_gradient_axis_ui("axis_rich_poor", "Rich vs Poor", choices = c("Rich Soil", "Poor Soil", "Both", "Don't know")),

          actionButton("save_button", "Save Selection")
        ),

        mainPanel(
          h3("Summary of User Selections"),
          tableOutput("summary_table") # Output table to display user selections
        )
      )
    )
  )
}
