#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # Instantiate each module server for each of the three axes
  open_closed <- mod_gradient_axis_server("axis_open_closed")
  wet_dry <- mod_gradient_axis_server("axis_wet_dry")
  rich_poor <- mod_gradient_axis_server("axis_rich_poor")

  # Create a reactive value to store user selections
  species_data <- reactiveVal(data.frame(
    Species = character(),
    Open_Closed = character(),
    Wet_Dry = character(),
    Rich_Poor = character(),
    stringsAsFactors = FALSE
  ))

  # Observe save button click to add a new row to the reactive data frame
  observeEvent(input$save_button, {
    new_entry <- data.frame(
      Species = "Random Species Name",  # Replace with actual species selection logic
      Open_Closed = open_closed(),      # Retrieve the value from the open_closed module
      Wet_Dry = wet_dry(),              # Retrieve the value from the wet_dry module
      Rich_Poor = rich_poor(),          # Retrieve the value from the rich_poor module
      stringsAsFactors = FALSE
    )

    # Update the reactive data frame with the new entry
    current_data <- species_data()
    species_data(rbind(current_data, new_entry))
  })

  # Render the summary table in the main panel to show user selections
  output$summary_table <- renderTable({
    species_data()
  })
}
