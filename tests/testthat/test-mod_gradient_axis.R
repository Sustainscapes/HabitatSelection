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

    # Test that the namespace function works correctly
    expect_true(
      inherits(ns, "function")
    )
    expect_true(
      grepl("test", ns(""))
    )
    expect_true(
      grepl("test", ns("test"))
    )

    # Simulate user interactions and test the inputs
    session$setInputs(gradient_selection = "Open")
    expect_equal(input$gradient_selection, "Open") # Test input value directly

    session$setInputs(gradient_selection = "Wet")
    expect_equal(input$gradient_selection, "Wet") # Test input value directly

    session$setInputs(gradient_selection = "Don't know")
    expect_equal(input$gradient_selection, "Don't know") # Test input value directly

    # Test the reactive output returned by the module
    reactive_output <- mod_gradient_axis_server("test") # Call the module directly
    expect_equal(reactive_output(), "Don't know") # Verify the output matches the last input value
  }
)

# Test UI Module
test_that("mod_gradient_axis_ui works", {
  # Create the UI
  ui <- mod_gradient_axis_ui(id = "test", label = "Test Label", choices = c("Open", "Wet", "Don't know"))

  # Ensure the UI returns a valid Shiny tag list
  golem::expect_shinytaglist(ui)

  # Check that the formal arguments are present
  fmls <- formals(mod_gradient_axis_ui)
  for (i in c("id", "label", "choices")) {
    expect_true(i %in% names(fmls))
  }

  # Check that the UI contains the expected components
  expect_true(any(sapply(ui, function(x) {
    inherits(x, "shiny.tag") && x$name == "div" &&
      grepl("shiny-input-radiogroup", x$attribs$class)
  })))


  # Check that the label is rendered correctly
  expect_true(any(grepl("Test Label", as.character(ui))))

  # Check that all choices are rendered
  expect_true(any(grepl("Open", as.character(ui))))
  expect_true(any(grepl("Wet", as.character(ui))))
  expect_true(any(grepl("Don't know", as.character(ui))))
})
