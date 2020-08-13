assign(".Rprofile", new.env(), envir = globalenv())

# .First ------------------------------------------------------------------
.First <- function(){
    try(if(testthat::is_testing()) return())

    # Global Options
    options(stringsAsFactors = TRUE)

    # Package Management System
    Date <- as.character(read.dcf("DESCRIPTION", "Date"));
    URL <- if(is.na(Date)) "https://cran.rstudio.com/" else paste0("https://mran.microsoft.com/snapshot/", Date)
    options(repos = URL)
}

# .Last -------------------------------------------------------------------
.Last <- function(){
}
