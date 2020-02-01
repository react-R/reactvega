#' <Add Title>
#'
#' <Add Description>
#'
#' @importFrom shiny restoreInput
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
reactvegaInput <- function(inputId, default = "") {
  reactR::createReactShinyInput(
    inputId,
    "reactvega",
    htmltools::htmlDependency(
      name = "reactvega-input",
      version = "1.0.0",
      src = "www/reactvega/reactvega",
      package = "reactvega",
      script = "reactvega.js"
    ),
    default,
    list(),
    htmltools::tags$span
  )
}

#' <Add Title>
#'
#' <Add Description>
#'
#' @export
updateReactvegaInput <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}