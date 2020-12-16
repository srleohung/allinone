# docker

## Build docker image
```
docker build .
```

## Run docker image
```
docker run .
```

## Show docker list
```
docker ps -a
```

## Mapping port
```bash
docker run -d -p $destination_port:$docker_port $docker_image
```

## Use docker compose to start
```bash
docker-compose up -d
```

## Rebuild docker compose and start
```bash
docker-compose up --build
```