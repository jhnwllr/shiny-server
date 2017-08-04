

function(input, output) {

output$downloadTree <- downloadHandler(
  filename <- function() {
    paste("trees", "zip", sep=".")
  },

  content <- function(file) {
    file.copy("trees.zip", file)
  },
  contentType = "application/zip"
)

output$downloadR <- downloadHandler(
  filename <- function() {
    paste("R-code", "r", sep=".")
  },

  content <- function(file) {
    file.copy("downFly.r", file)
  }
)



}

