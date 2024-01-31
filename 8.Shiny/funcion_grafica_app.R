library(dplyr)
library(ggplot2)


grafica_final <- function(datafram,input) {
  datafram |>
    filter(edad >= input[1] & edad <= input[2])|>
    group_by(edad) |>
    summarise(n = n()) |>
    ggplot(aes(edad, n)) +
    geom_point()
}
  
