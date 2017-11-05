
load("data/Species.rda")
load("data/bodyColorTable.rda")
load("data/sizeTable.rda")
load("data/sexDiffPolymorpTable.rda")
load("data/behaviourTable.rda")
load("data/geographyHabitatTable.rda")
load("data/wingPigmentTable.rda")

# female data
load("data/femaleWingPigmentTable.rda")
load("data/femaleBodySizeTable.rda")

load("data/referencesTable.rda")

enableBookmarking("url")
function(input, output, session) {

if(TRUE) { # set up bookmarking

setBookmarkExclude(c("choose_family", "choose_genus"))

observe({
reactiveValuesToList(input)
session$doBookmark()
})
onBookmarked(function(url) {
updateQueryString(url)
})

}

if(TRUE) { # choose taxonomy


output$choose_family <- renderUI({
Family = as.character(Species$Family)
Family = sort(Family)
Family = setNames(as.list(Family,Family),Family)
selectizeInput("choose_family", "Select family",c(Choose = "",Family),multiple = FALSE)
})


output$choose_genus <- renderUI({
if(input$choose_family != "") {
Family = input$choose_family
genus = Species$Genus[Species$Family == Family]
genus = as.character(genus)
genus = sort(genus)
genus = setNames(as.list(genus,genus),genus)
} else {
genus = Species$Genus
genus = as.character(genus)
genus = sort(genus)
genus = setNames(as.list(genus,genus),genus)
}
selectizeInput("choose_genus", "Select genus",c(Choose = "",genus),multiple = FALSE)
})

output$choose_species <- renderUI({
if(is.null(input$choose_genus)) return()
if(is.null(input$choose_family)) return()

if(input$choose_family != "" & input$choose_genus == "") {
Family = input$choose_family
GenusSpecies = Species$GenusSpecies[Species$Family == Family]

GenusSpecies = as.character(GenusSpecies)
GenusSpecies = sort(GenusSpecies)

GenusSpecies = setNames(as.list(GenusSpecies,GenusSpecies),GenusSpecies)
} 

if(input$choose_genus != "") {
genus = input$choose_genus
GenusSpecies = Species$GenusSpecies[Species$Genus == genus]

GenusSpecies = as.character(GenusSpecies)
GenusSpecies = sort(GenusSpecies)

GenusSpecies = setNames(as.list(GenusSpecies,GenusSpecies),GenusSpecies)
}

if(input$choose_family == "" & input$choose_genus == "") {
GenusSpecies = Species$GenusSpecies

GenusSpecies = as.character(GenusSpecies)
GenusSpecies = sort(GenusSpecies)

GenusSpecies = setNames(as.list(GenusSpecies,GenusSpecies),GenusSpecies)
}

selectizeInput("choose_species", "Select species",c(Choose = "",GenusSpecies),multiple = FALSE)

})


output$species <- renderText({

if(is.null(input$choose_species)) {
return("Genus species")
} else if(input$choose_species == "") {
return("Genus species")
} else { 
return(paste(input$choose_species))
}

})

}

if(TRUE) { # download buttons 
output$outputId <- downloadHandler(
filename <- function() {
paste("opdb", "csv", sep=".")
},
content <- function(file) {
file.copy("mergeDataReduced.csv", file)
}
)

# # download button 
output$downVariableDefinitions <- downloadHandler(
filename <- function() {
paste("variable definitions", "pdf", sep=".")
},
content <- function(file) {
file.copy("variableDescription.pdf", file)
}
)

}

if(TRUE) { # Male body size

output$tbl <- renderText({

x = sizeTable[sizeTable$GenusSpecies==input$choose_species,]$body_lengths # total body lengths
if(identical(x, numeric(0))) return("-")
x = as.character(round(mean(na.omit(x)),2))
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "NaN") return("-")

x = paste(x,"mm")

return(x)
})


output$fwl <- renderText({

x = sizeTable[sizeTable$GenusSpecies==input$choose_species,]$forewing_lengths # total body lengths
if(identical(x, numeric(0))) return("-")
mean_x = as.character(round(mean(na.omit(x)),2))
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(x,"mm"))
})

output$hwl <- renderText({

x = sizeTable[sizeTable$GenusSpecies==input$choose_species,]$hindwing_lengths # total body lengths
if(identical(x, numeric(0))) return("-")
mean_x = as.character(round(mean(na.omit(x)),2))
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(x,"mm"))
})

}

if(TRUE) { # Female body size
output$female_tbl <- renderText({
x = femaleBodySizeTable[sizeTable$GenusSpecies==input$choose_species,]$female_body_lengths # total body lengths
if(identical(x, numeric(0))) return("-")
x = as.character(round(mean(na.omit(x)),2))
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "NaN") return("-")


x = paste(x,"mm")
return(x)
})


output$female_fwl <- renderText({
x = femaleBodySizeTable[sizeTable$GenusSpecies==input$choose_species,]$female_forewing_lengths # total body lengths
if(identical(x, numeric(0))) return("-")
x = as.character(round(mean(na.omit(x)),2))
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "NaN") return("-")
x = paste(x,"mm")

return(x)
})

output$female_hwl <- renderText({
x = femaleBodySizeTable[sizeTable$GenusSpecies==input$choose_species,]$female_hindwing_lengths # total body lengths
if(identical(x, numeric(0))) return("-")
x = as.character(round(mean(na.omit(x)),2))
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "NaN") return("-")
x = paste(x,"mm")

return(x)
})

}

if(TRUE) { # Male body colors
output$body_colors <- renderText({

x = bodyColorTable[bodyColorTable$GenusSpecies == input$choose_species,]$body_colors
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(unique(as.character(na.omit(x))))
})

output$body_colortypes <- renderText({
x = bodyColorTable[bodyColorTable$GenusSpecies == input$choose_species,]$body_colortypes
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(unique(as.character(na.omit(x))))
})

output$body_patterns <- renderText({
x = bodyColorTable[bodyColorTable$GenusSpecies == input$choose_species,]$body_patterns
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(unique(as.character(na.omit(x))))
})

}

if(TRUE) { # Morphisms
output$sex_dimorphisms <- renderText({
x = sexDiffPolymorpTable[sexDiffPolymorpTable$GenusSpecies == input$choose_species,]$sex_dimorphisms
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(unique(as.character(na.omit(x))))
})

output$sex_polymorphisms <- renderText({
x = sexDiffPolymorpTable[sexDiffPolymorpTable$GenusSpecies == input$choose_species,]$sex_polymorphisms

x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(unique(as.character(na.omit(x))))
})

output$geo_polymorphisms <- renderText({
x = sexDiffPolymorpTable[sexDiffPolymorpTable$GenusSpecies == input$choose_species,]$geo_polymorphisms

x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(unique(as.character(na.omit(x))))
})
}

if(TRUE) { # Male Behaviour
output$mate_guarding <- renderText({
x = behaviourTable[behaviourTable$GenusSpecies == input$choose_species,]$mate_guarding

x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(x)
})

output$fligth_mode <- renderText({
x = behaviourTable[behaviourTable$GenusSpecies == input$choose_species,]$flight_mode

x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(x)
})

output$territoriality <- renderText({
x = behaviourTable[behaviourTable$GenusSpecies == input$choose_species,]$territoriality
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(x)
})

output$flight_mode <- renderText({
x = behaviourTable[behaviourTable$GenusSpecies == input$choose_species,]$flight_mode
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(x)
})
}

if(TRUE) { # geographyHabitatTable

output$continents <- renderText({
x = geographyHabitatTable[geographyHabitatTable$GenusSpecies == input$choose_species,]$continents
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(unique(as.character(na.omit(x))))
})

output$climates <- renderText({
x = geographyHabitatTable[geographyHabitatTable$GenusSpecies == input$choose_species,]$climates
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(unique(as.character(na.omit(x))))
})

output$ecozones <- renderText({
x = geographyHabitatTable[geographyHabitatTable$GenusSpecies == input$choose_species,]$ecozones
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(unique(as.character(na.omit(x))))
})

output$habitat_openness <- renderText({
x = geographyHabitatTable[geographyHabitatTable$GenusSpecies == input$choose_species,]$habitat_openness
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(unique(as.character(na.omit(x))))
})


output$aquatic_habitat <- renderText({
x = geographyHabitatTable[geographyHabitatTable$GenusSpecies == input$choose_species,]$aquatic_habitat
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(unique(as.character(na.omit(x))))
})

}

if(TRUE) { # Male wingPigmentTable

output$wing_pigment_extent_discrete <- renderText({
# wing_pigment_extent_continuous
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$wing_pigment_extent_discrete
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(paste(unique(as.character(na.omit(x))),"%"))
})


# wing_pigment_pattern
output$wing_pigment_pattern <- renderText({
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$wing_pigment_pattern
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")
if(x == "") return("-")

return(paste(unique(as.character(na.omit(x)))))
})

# wing_pigment_symmetry
output$wing_pigment_symmetry <- renderText({
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$wing_pigment_symmetry
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(unique(as.character(na.omit(x)))))
})


# wing_pigment_dimorphism
output$wing_pigment_dimorphism <- renderText({
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$wing_pigment_dimorphism
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(unique(as.character(na.omit(x)))))
})

# wing_pigment_color
output$wing_pigment_color <- renderText({
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$wing_pigment_color
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(unique(as.character(na.omit(x)))))
})


# wing_pigment_placement
output$wing_pigment_placement <- renderText({
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$wing_pigment_placement
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(unique(as.character(na.omit(x)))))
})


# wing_pigment_color_type
output$wing_pigment_color_type <- renderText({
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$wing_pigment_color_type
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(unique(as.character(na.omit(x)))))
})

}


if(TRUE) { # femaleWingPigmentTable
output$female_wing_pigment_extent_discrete <- renderText({
# wing_pigment_extent_continuous
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$female_wing_pigment_extent_discrete
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(unique(as.character(na.omit(x))),"%"))
})

output$female_wing_pigment_placement <- renderText({
# wing_pigment_extent_continuous
x = wingPigmentTable[wingPigmentTable$GenusSpecies == input$choose_species,]$female_wing_pigment_placement
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(paste(unique(as.character(na.omit(x))),"%"))
})

}

output$citations <- renderText({
x = referencesTable[referencesTable$GenusSpecies == input$choose_species,]$citations
x = as.character(x)
x[x == ""] = NA
x = na.omit(x)
if(length(x) == 0) return("-")

return(unique(as.character(na.omit(x))))
})


}

