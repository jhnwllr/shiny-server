


library(shiny)


ui = function(request) {
htmlTemplate("template.html",
CalopteryxApp=downloadButton("CalopteryxApp", label = "Download", class = "w3-button w3-light-grey w3-padding-large w3-section w3-hide-small")
)
}


