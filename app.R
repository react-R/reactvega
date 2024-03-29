library(shiny)
library(reactvega)
library(listviewer)
library(vlbuildr)

spec <- jsonlite::fromJSON(
  '{"$schema":"https://vega.github.io/schema/vega/v5.json","width":400,"height":200,"padding":{"left":5,"right":5,"top":5,"bottom":5},"data":[{"name":"table","values":[{"category":"A","amount":28},{"category":"B","amount":55},{"category":"C","amount":43},{"category":"D","amount":91},{"category":"E","amount":81},{"category":"F","amount":53},{"category":"G","amount":19},{"category":"H","amount":87}]}],"signals":[{"name":"tooltip","value":{},"on":[{"events":"rect:mouseover","update":"datum"},{"events":"rect:mouseout","update":"{}"}]}],"scales":[{"name":"xscale","type":"band","domain":{"data":"table","field":"category"},"range":"width"},{"name":"yscale","domain":{"data":"table","field":"amount"},"nice":true,"range":"height"}],"axes":[{"orient":"bottom","scale":"xscale"},{"orient":"left","scale":"yscale"}],"marks":[{"type":"rect","from":{"data":"table"},"encode":{"enter":{"x":{"scale":"xscale","field":"category","offset":1},"width":{"scale":"xscale","band":1,"offset":-1},"y":{"scale":"yscale","field":"amount"},"y2":{"scale":"yscale","value":0}},"update":{"fill":{"value":"steelblue"}},"hover":{"fill":{"value":"red"}}}},{"type":"text","encode":{"enter":{"align":{"value":"center"},"baseline":{"value":"bottom"},"fill":{"value":"#333"}},"update":{"x":{"scale":"xscale","signal":"tooltip.category","band":0.5},"y":{"scale":"yscale","signal":"tooltip.amount","offset":-2},"text":{"signal":"tooltip.amount"},"fillOpacity":[{"test":"datum === tooltip","value":0},{"value":1}]}}}]}',
  simplifyVector = FALSE
)

specvl <- vl_chart() %>%
   vl_add_data(values = mtcars) %>%
   vl_mark_point() %>%
   vl_encode_x("wt") %>%
   vl_encode_y("mpg") %>%
  format() %>%
  jsonlite::fromJSON(simplifyVector = FALSE)

dat <- data.frame(
  category = letters[1:15],
  amount = runif(15, 0, 40),
  stringsAsFactors = FALSE
)

ui <- fluidPage(
  titlePanel("react-vega Input Example"),
  fluidRow(
    style = "height: 90vh;",
    column(width = 6, style = "height:100%;", reactjsonOutput("specjson", height = "100%")),
    column(
      width = 6,
      style = "height:100%;",
      actionButton("updateBtn", label = "Update Data"),
      actionButton("updateBtnSpec", label = "Update Spec vlbuildr"),
      reactvegaInput("vegaInput", configuration = list(spec = spec, data = list())),
      textOutput("textOutput")
    )
  )
)

server <- function(input, output, session) {
  output$specjson <- renderReactjson({
    listviewer::reactjson(spec)
  })

  observeEvent(input$updateBtn, {
    dat$amount = runif(nrow(dat), 0, 100)
    updateReactvegaInput(
      session = session,
      inputId = "vegaInput",
      configuration = list(
        spec = spec,
        data = jsonlite::toJSON(list(table = dat), dataframe="rows", auto_unbox = TRUE)
      )
    )

    output$specjson <- renderReactjson({
      listviewer::reactjson(spec)
    })
  })

  observeEvent(input$specjson_edit, {
    updateReactvegaInput(
      session = session,
      inputId = "vegaInput",
      configuration = list(
        spec = jsonlite::toJSON(input$specjson_edit$value$updated_src, dataframe="rows", auto_unbox=TRUE),
        data = list()
      )
    )
  })

  observeEvent(input$updateBtnSpec, {
    updateReactvegaInput(
      session = session,
      inputId = "vegaInput",
      configuration = list(
        spec = specvl,
        data = list()
      )
    )

    output$specjson <- renderReactjson({
      listviewer::reactjson(specvl)
    })
  })

  output$textOutput <- renderText({
    jsonlite::toJSON(input$vegaInput_tooltip, auto_unbox=TRUE)
  })
}

shinyApp(ui, server)
