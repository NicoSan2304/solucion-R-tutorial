#' Clasificacion columnas dataframe
#'
#' @param dataframe1 Dataframe exportado ó creado con datos externos
#'
#' @return clase de cada columna
#' @export
#'
#' @examples
#' d <- data.frame(Nombre = c("Esteban", "Mario", "Beatriz"),
#'                 Edad = c(2, 93, 57),
#'                 Ciudad = factor(c("Jaén", "Granada", "Jaén")),
#'                 Casado = c(FALSE, TRUE, FALSE))
#' clasificacion(d)
#'
#' edad <- c(22, 34, 29, 25, 30)
#' tiempo <- c(14.21, 10.36, 11.89, 13.81, 12.03)
#' sexo <- c("M","H","H","M","M")
#' misDatos <- data.frame(edad,tiempo,sexo)
#' clasificacion(misDatos)
#'
clasificacion <- function(dataframe1) {
  if(is.data.frame(dataframe1) == FALSE) { return("Ingrese un Data frame")} else {
    result <- c()
    for(j in 1:ncol(dataframe1))
      result[j] <- class(dataframe1[,j])
    result1 <- c(result)

    return(result1)
  }
}

