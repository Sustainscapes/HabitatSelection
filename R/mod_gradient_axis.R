#' gradient_axis UI Function
#'
#' @description A shiny Module for selecting an environmental gradient.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param label The label to display for the radio buttons.
#' @param choices The set of choices for the radio buttons.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList radioButtons
mod_gradient_axis_ui <- function(id, label, choices) {
  ns <- NS(id)
  tagList(
    radioButtons(ns("gradient_selection"), label,
                 choices = choices)
  )
}

#' gradient_axis Server Function
#'
#' @noRd
#' @importFrom shiny moduleServer reactive
mod_gradient_axis_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    # Return the selected value as a reactive output
    reactive({
      input$gradient_selection
    })
  })
}
