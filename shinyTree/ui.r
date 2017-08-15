


library(shiny)

htmlTemplate("template.html",
downloadTree = downloadButton("downloadTree", label = "Download Trees & R-code",class = "w3-button w3-light-grey w3-padding-large w3-section w3-hide-small")
)

