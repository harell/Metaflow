devtools::load_all(".")
Docker$new()$kill_all_containers()$remove_dangling_images()

docker <- DockerCompose$new()
docker$restart()
docker$browse_url("r-flow")
