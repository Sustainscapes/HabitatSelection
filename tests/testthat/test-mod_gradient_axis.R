library(shiny)
library(testthat)
library(golem)

# Test Server Module
testServer(
  mod_gradient_axis_server,
  # Add here your module params
  args = list(id = "test"), # Assign an ID for testing purposes
  {
    ns <- session$ns

    # Test that the namespace function works
    expect_true(
      inherits(ns, "function")
    )
    expect_true(
      grepl("test", ns(""))
    )
    expect_true(
      grepl("test", ns("test"))
    )

    # Test input behavior by simulating user interactions
    session$setInputs(gradient_selection = "Open")
    expect_equal(input$gradient_selection, "Open")

    session$setInputs(gradient_selection = "Wet")
    expect_equal(input$gradient_selection, "Wet")

    session$setInputs(gradient_selection = "Don't know")
    expect_equal(input$gradient_selection, "Don't know")

    # Test that the reactive output is working correctly
    output_value <- .result()  # Note that this retrieves the returned reactive value from moduleServer
    expect_equal(output_value(), "Don't know")  # Expecting the reactive output to match the input
  }
)

# Test UI Module
test_that("module UI works", {
  ui <- mod_gradient_axis_ui(id = "test", label = "Test Label")
  golem::expect_shinytaglist(ui)

  # Check that formals have not been removed
  fmls <- formals(mod_gradient_axis_ui)
  for (i in c("id", "label")) {
    expect_true(i %in% names(fmls))
  }

  # Check that the UI contains the expected components
  expect_true(any(grepl("radioButtons", as.character(ui))))
  expect_true(any(grepl("Test Label", as.character(ui))))
})
