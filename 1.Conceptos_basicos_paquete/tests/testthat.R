# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

#Call the library
library(testthat)
##Exercise 1
#Write the Dataframe that will make the test
edad <- c(22, 34, 29, 25, NA)
tiempo <- c(14.21,NA, 11.89, 13.81, 12.03)
sexo <- c("M","H","H","M","M")
misDatos <- data.frame(edad,tiempo,sexo)
#Do the estructure of the test and later check that the test passed
test_that("Comprobar la clasificación de cada columna del dataframe", {
  expect_equal(clasificacion(misDatos), c("numeric","numeric","character"))
})


##Excercise 2
#Write the Dataframe that will make the test
Producto <- c("Zumo", "Queso", "Yogurt")
Seccion <- c("Bebidas", "Productos lácteos", "Productos lácteos")
Unidades <- c(2, 1, 10)
Alimentos <- data.frame(Producto, Seccion, Unidades)
#Do the estructure of the test and later check that the test passed

test_that("Comprobar la clasificación de cada columna del dataframe", {
  expect_equal(clasificacion(Alimentos), c("character","character","numeric"))
})


