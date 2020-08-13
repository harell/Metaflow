load_dependencies <- function(){
    pkgs <- c("data.table", "caret", "glmnet", "gbm")
    invisible(sapply(pkgs, require))
}
