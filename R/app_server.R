#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  # Load the species data frame from your package's dataset
  data("species", package = "HabitatSelection") # Replace 'yourpackage' with the actual package name

  # Reactive value to store the current species
  current_species <- reactiveVal(NULL)

  # Observe when "Generate Random Species" button is clicked
  observeEvent(input$generate_species, {
    # Select a random row from the species data frame
    selected_species <- species[sample(1:nrow(species), 1), ]
    current_species(selected_species)
  })

  # Display the selected species name, genus, and family in the UI
  output$species_name <- renderText({
    selected_species <- current_species()
    if (is.null(selected_species)) {
      return("No species selected yet. Click 'Generate Random Species' to start.")
    } else {
      paste("Current Species: ", selected_species$accepteret_dansk_navn, paste0("(",selected_species$species,")"),
            " (Genus: ", selected_species$genus,
            ", Family: ", selected_species$family, ")")
    }
  })

  # Instantiate each module server for each of the three axes
  open_closed <- mod_gradient_axis_server("axis_open_closed")
  wet_dry <- mod_gradient_axis_server("axis_wet_dry")
  rich_poor <- mod_gradient_axis_server("axis_rich_poor")

  # Create a reactive value to store user selections
  species_data <- reactiveVal(data.frame(
    User_Name = character(),
    Family = character(),
    Genus = character(),
    Species = character(),
    Open_Closed = character(),
    Wet_Dry = character(),
    Rich_Poor = character(),
    stringsAsFactors = FALSE
  ))

  # Observe save button click to add a new row to the reactive data frame
  observeEvent(input$save_button, {
    # Only save if there's a valid species and user name
    selected_species <- current_species()
    if (!is.null(selected_species) && nchar(input$user_name) > 0) {
      new_entry <- data.frame(
        User_Name = input$user_name,
        Family = selected_species$family,
        Genus = selected_species$genus,
        Species = selected_species$species,
        Open_Closed = open_closed(),   # Retrieve the value from the open_closed module
        Wet_Dry = wet_dry(),           # Retrieve the value from the wet_dry module
        Rich_Poor = rich_poor(),       # Retrieve the value from the rich_poor module
        stringsAsFactors = FALSE
      )

      # Update the reactive data frame with the new entry
      current_data <- species_data()
      species_data(rbind(current_data, new_entry))
    }
  })

  # Render the summary table in the main panel to show user selections
  output$summary_table <- renderTable({
    species_data()
  })
}
