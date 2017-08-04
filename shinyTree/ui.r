


library(shiny)

htmlTemplate("template.html",
downloadTree = downloadButton("downloadTree", label = "Download Trees",class = "w3-button w3-light-grey w3-padding-large w3-section w3-hide-small"),
downloadR = downloadButton("downloadR", label = "Download R-code",class = "w3-button w3-light-grey w3-padding-large w3-section w3-hide-small")
)


# histTbl = plotOutput("histTbl")
# load("idTable.rda")


# families = as.list(as.character(unique(idTable$family)))
# families = setNames(families,families)

# fluidPage(
# fluidRow(
# column(4, wellPanel(
# br(),
# selectInput("family", "choose a family",names(families))
# )),
# column(8,
# h4("Family"),
# textOutput("family"),
# h4("Number of Species"),
# textOutput("N_count"),
# h4("Mean Body Length"),
# textOutput("tbl"),
# h4("Mean Forewing Length"),
# textOutput("fwl"),
# h4("Mean Hindwing Length"),
# textOutput("hwl"),
# h4("Body Colors Present in Family"),
# textOutput("body_colors"),
# h4("Body Color Types Present in Family"),
# textOutput("body_colortypes"),
# h4("Body Patterns Types Present in Family"),
# textOutput("body_patterns"),
# plotOutput("histTbl")
# )))
