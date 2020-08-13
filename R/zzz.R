.onAttach <- function(...) {
    Sys.setenv(METAFLOW_ENV = "metaflow-env")
    Sys.setenv(METAFLOW_VER = "2.2.0")
    options(stringsAsFactors = TRUE)
}
