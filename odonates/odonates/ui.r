

load("data/Species.rda")

library(shiny)

GenusSpecies = setNames(as.list(Species$GenusSpecies),Species$GenusSpecies)

enableBookmarking("url")


ui = function(request) {
htmlTemplate("template.html",
speciesSelection = selectizeInput("GenusSpecies",label = "",choices = names(GenusSpecies),options = list(maxOptions = 1),multiple = TRUE),
choose_family = uiOutput("choose_family"),
choose_genus = uiOutput("choose_genus"),
downButton = downloadButton("outputId", label = "Complete Database", class="w3-button w3-light-grey w3-padding-large w3-section w3-hide-small"),
downVariableDefinitions = downloadButton("downVariableDefinitions", label = "Variable Definitions", class="w3-button w3-light-grey w3-padding-large w3-section w3-hide-small"),
choose_species = uiOutput("choose_species"),
species = textOutput("species"),
tbl = textOutput("tbl"),
female_tbl = textOutput("female_tbl"),
fwl = textOutput("fwl"),
female_fwl = textOutput("female_fwl"),
hwl = textOutput("hwl"),
female_hwl = textOutput("female_hwl"),
body_colors = textOutput("body_colors"),
body_colortypes = textOutput("body_colortypes"),
body_patterns = textOutput("body_patterns"),
sex_dimorphisms = textOutput("sex_dimorphisms"),
sex_polymorphisms = textOutput("sex_polymorphisms"),
geo_polymorphisms = textOutput("geo_polymorphisms"),
mate_guarding = textOutput("mate_guarding"),
flight_mode = textOutput("flight_mode"),
territoriality = textOutput("territoriality"),
climates = textOutput("climates"),
continents = textOutput("continents"),
ecozones = textOutput("ecozones"),
habitat_openness = textOutput("habitat_openness"),
aquatic_habitat = textOutput("aquatic_habitat"),
wing_pigment_extent_discrete = textOutput("wing_pigment_extent_discrete"),
wing_pigment_pattern = textOutput("wing_pigment_pattern"),
wing_pigment_symmetry = textOutput("wing_pigment_symmetry"),
wing_pigment_dimorphism = textOutput("wing_pigment_dimorphism"),
wing_pigment_color = textOutput("wing_pigment_color"),
wing_pigment_placement = textOutput("wing_pigment_placement"),
wing_pigment_color_type = textOutput("wing_pigment_color_type"),
female_wing_pigment_placement = textOutput("female_wing_pigment_placement"),
female_wing_pigment_extent_discrete = textOutput("female_wing_pigment_extent_discrete"),


citations = textOutput("citations")
)
}

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
