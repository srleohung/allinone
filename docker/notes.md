# docker

## Build docker image
```bash
docker build .
```

## Run docker image
```bash
docker run .
```

## Show docker container list
```bash
docker ps -a
```

## Show docker image list
```bash
docker image ls
```

## Remove many docker container
```bash
docker rm $(docker ps -a | grep $image | awk '{print $1}')
```

## Remove many docker image
```bash
docker rmi $(docker image ls | grep $repository | awk '{print $3}')
```

## Mapping port
```bash
docker run -d -p $destination_port:$docker_internal_port $docker_image:$docker_image_tag
```

## Use docker compose to start
```bash
docker-compose up -d
```

## Rebuild docker compose and start
```bash
docker-compose up --build
```

## Execute commands in the running docker container
```bash
docker exec -it $docker_container_id $command
```