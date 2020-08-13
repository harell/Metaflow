################################################################################
## Episode 1: Linear Flow
################################################################################
# Setup -------------------------------------------------------------------
pkgload::load_all()
setwd(usethis::proj_path("./inst/user2020_tutorials/episode1_linear_flow"))
source("./scripts/pull_data.R")
source("./scripts/compute_features.R")
source("./scripts/build_model.R")
step <- metaflow::step
run <- metaflow::run
metaflow <- metaflow::metaflow
tictoc::tic("metaflow")

# Data Modeling -----------------------------------------------------------
#' The 'flow' must have a 'start' and an 'end' steps in order to be runnable
flow <- metaflow("HouseFlow") %>%
    step(step = "start", next_step = "pull_house_data") %>%
    step(step = "pull_house_data", r_function = pull_house_data, next_step = "compute_features") %>%
    step(step = "compute_features", r_function = compute_features, next_step = "build_model") %>%
    step(step = "build_model", r_function = build_gbm_model, next_step = "end") %>%
    step(step = "end", r_function = summarize_model)

run(flow, datastore = "local")

# Cleanup -----------------------------------------------------------------
tictoc::toc()
setwd(usethis::proj_get())
