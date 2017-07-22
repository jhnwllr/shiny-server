htmlTemplate("template.html",
  
  button = actionButton("action", "Action"),
  slider = sliderInput("x", "X", 1, 100, 50),
  Text = textInput("text", label = h3("Text input"), value = "Enter text..."),
  Out = verbatimTextOutput("value")
  )