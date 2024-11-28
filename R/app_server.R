#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd

app_server <- function(input, output, session) {

  # Path to the CSV file
  csv_file <- "user_selections.csv"

  # Load existing data if the CSV file exists
  existing_data <- if (file.exists(csv_file)) {
    read.csv(csv_file, stringsAsFactors = FALSE)
  } else {
    data.frame(User_Name = character(),
               Family = character(),
               Genus = character(),
               Species = character(),
               Open_Closed = character(),
               Wet_Dry = character(),
               Rich_Poor = character(),
               stringsAsFactors = FALSE)
  }

  # Reactive value for user data
  species_data <- reactiveVal(existing_data)

  # Filter species that have not been evaluated
  filtered_species <- reactive({
    species[!species$species %in% species_data()$Species, ]
  })

  # Update username input with suggestions from existing data
  observe({
    user_names <- unique(species_data()$User_Name)
    updateSelectizeInput(
      session,
      "user_name",
      choices = if (length(user_names) > 0) user_names else NULL,
      options = list(create = TRUE)
    )
  })

  # Reactive value to store the current species
  current_species <- reactiveVal(NULL)

  # Observe when "Generate Random Species" button is clicked
  observeEvent(input$generate_species, {
    available_species <- filtered_species()
    if (nrow(available_species) > 0) {
      selected_species <- available_species[sample(1:nrow(available_species), 1), ]
      current_species(selected_species)
    } else {
      showNotification("All species have been evaluated.", type = "message")
    }
  })

  # Display the selected species name
  output$species_name <- renderText({
    selected_species <- current_species()
    if (is.null(selected_species)) {
      "No species selected yet. Click 'Generate Random Species' to start."
    } else {
      paste(
        "Current Species: ", selected_species$accepteret_dansk_navn,
        paste0("(", selected_species$species, ")"),
        "(Genus: ", selected_species$genus, ", Family: ", selected_species$family, ")"
      )
    }
  })

  # Instantiate each module server for each of the three axes
  open_closed <- mod_gradient_axis_server("axis_open_closed")
  wet_dry <- mod_gradient_axis_server("axis_wet_dry")
  rich_poor <- mod_gradient_axis_server("axis_rich_poor")

  # Observe save button click to add a new row to the reactive data frame
  observeEvent(input$save_button, {
    selected_species <- current_species()

    # Debugging: Print lengths of each input to check for issues
    cat("Debugging lengths:\n")
    cat("User Name Length: ", length(input$user_name), "\n")
    cat("Selected Species Length: ", if (!is.null(selected_species)) 1 else 0, "\n")
    cat("Open_Closed Length: ", length(open_closed()), "\n")
    cat("Wet_Dry Length: ", length(wet_dry()), "\n")
    cat("Rich_Poor Length: ", length(rich_poor()), "\n")

    if (!is.null(selected_species) && nchar(input$user_name) > 0) {
      new_entry <- data.frame(
        User_Name = input$user_name,
        Family = selected_species$family,
        Genus = selected_species$genus,
        Species = selected_species$species,
        Open_Closed = open_closed(),   # Use the reactive value
        Wet_Dry = wet_dry(),           # Use the reactive value
        Rich_Poor = rich_poor(),       # Use the reactive value
        stringsAsFactors = FALSE
      )

      # Update the reactive data frame
      current_data <- species_data()
      species_data(rbind(current_data, new_entry))

      # Automatically save to the CSV file
      write.csv(species_data(), csv_file, row.names = FALSE)

      # Notify the user that progress is saved
      showNotification("Selection saved successfully.", type = "message")
    } else {
      showNotification("Please select a species and enter a valid username.", type = "error")
    }
  })

  # Render the summary table
  output$summary_table <- renderTable({
    species_data()
  })
}
