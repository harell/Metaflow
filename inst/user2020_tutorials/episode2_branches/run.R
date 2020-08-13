################################################################################
## Episode 2: Branches
################################################################################
# Setup -------------------------------------------------------------------
pkgload::load_all()
setwd(usethis::proj_path("./inst/user2020_tutorials/episode2_branches"))
source("./scripts/pull_data.R")
source("./scripts/compute_features.R")
source("./scripts/build_model.R")
parameter <- metaflow::parameter
step <- metaflow::step
run <- metaflow::run
metaflow <- metaflow::metaflow
tictoc::tic("metaflow")

# Data Modeling -----------------------------------------------------------
flow <- metaflow("HouseFlow") %>%
    parameter("lr", help="learning rate", type="float", default=0.01) %>%
    parameter("reg", help="regularization parameter", type="float", default=0.01) %>%
    step(step = "start", next_step = "pull_house_data") %>%
    step(step = "pull_house_data", r_function = pull_house_data, next_step = "compute_features") %>%
    step(step = "compute_features", r_function = compute_features, next_step = c("build_gbm_model", "build_lasso_model")) %>%
    step(step = "build_gbm_model", r_function = build_gbm_model, next_step = "select_model") %>%
    step(step = "build_lasso_model", r_function = build_lasso_model, next_step = "select_model") %>%
    step(step = "select_model", r_function = select_model, join = TRUE, next_step = "end") %>%
    step(step = "end", r_function = summarize_model)

run(flow, datastore = "local")

# Cleanup -----------------------------------------------------------------
tictoc::toc()
setwd(usethis::proj_get())


