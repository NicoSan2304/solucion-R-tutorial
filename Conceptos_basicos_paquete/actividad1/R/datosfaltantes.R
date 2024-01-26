#' Datos faltantes
#'
#' @param dataframe1 Dataframe exportado ó creado con datos externos
#'
#' @return mensaje de en que columna existen datos faltantes
#' @export
#'
#' @examples
#' d <- data.frame(Nombre = c("Esteban", NA, "Beatriz"),
#'                 Edad = c(2, 93, 57),
#'                 Ciudad = factor(c(NA, "Granada", "Jaén")),
#'                 Casado = c(FALSE, TRUE, NA))
#' datos_faltantes(d)
#'
#' edad <- c(22, 34, 29, 25, NA)
#' tiempo <- c(14.21,NA, 11.89, 13.81, 12.03)
#' sexo <- c("M","H","H","M","M")
#' misDatos <- data.frame(edad,tiempo,sexo)
#' datos_faltantes(misDatos)
#'
datos_faltantes <- function(dataframe1) {
  cat("Datos faltantes(NA) en las siguientes columnas: \n")
  datf <- apply(X = is.na(dataframe1), MARGIN = 2, FUN = sum)
  return(datf)
}
