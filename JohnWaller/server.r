
library(shiny)
function(input, output) {

output$CalopteryxApp <- downloadHandler(
filename <- function() {
paste("CalopteryxApp", "txt", sep=".")
},
content <- function(file) {
file.copy("CalopteryxApp.txt", file)
})

}


