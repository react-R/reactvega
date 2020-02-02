#' <Add Title>
#'
#' <Add Description>
#'
#' @importFrom shiny restoreInput
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
reactvegaInput <- function(inputId, spec = NULL, data = NULL, default = "", configuration = list()) {
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
    configuration = configuration,
    htmltools::tags$div
  )
}

#' <Add Title>
#'
#' <Add Description>
#'
#' @export
updateReactvegaInput <- function(session, inputId, value = NULL, configuration = NULL) {
  message <- list()
  if (!is.null(value)) message$value <- value
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
