#' Access external data in package
#'
#' @param dta filename to access from extdata, including folders
#'
#' @return path to the file
#' @export
#'
#' @examples
#' read.csv(ex("sierra/sierraStations.csv"))
ex <- function(dta){
  system.file("extdata",dta,package="iGIScData")
  }
