# Docker

A collection of custom Dockerfiles.

## Requirements

Requires Docker version >= 19.03.8.

## Images

Supported images:
- bitnami/mariadb
- nginx

## Build

To build all avaialble images under current directory, run `./build.sh` To build each image separately, navigate to respective folder and run default `make` target. 
- `make clean` removes built image.
- `make build` builds image.
- `make test-start-server` starts test container from built image. 
- `make test-stop-server` stops test container. 



## Example execution

    s3@host:~/task/docker$ ./build.sh 
    [2020-04-22T10:47:44Z] [ INFO ] >>> Processing /home/s3/task/docker/mariadb/Dockerfile
    [2020-04-22T10:47:44Z] [ INFO ] >>> Makefile found, building using default target
    docker build -f Dockerfile --no-cache="false" \
    -t "custom-mariadb":"alpha" .
    Sending build context to Docker daemon  4.096kB
    Step 1/4 : FROM bitnami/mariadb:10.1.28-r0
    ---> d44f2165a431
    Step 2/4 : ENV ALLOW_EMPTY_PASSWORD="yes"     BITNAMI_APP_NAME="s3-app"     BITNAMI_IMAGE_VERSION="10.1.28-r0"     MARIADB_DATABASE="s3-db"     MARIADB_MASTER_HOST=""     MARIADB_MASTER_PORT_NUMBER=""     MARIADB_MASTER_ROOT_PASSWORD=""     MARIADB_MASTER_ROOT_USER=""     MARIADB_PASSWORD=""     MARIADB_PORT_NUMBER="3306"     MARIADB_REPLICATION_MODE=""     MARIADB_REPLICATION_PASSWORD=""     MARIADB_REPLICATION_USER=""     MARIADB_ROOT_PASSWORD=""     MARIADB_ROOT_USER="root"     MARIADB_USER=""     PATH="/opt/bitnami/mariadb/bin:/opt/bitnami/mariadb/sbin:$PATH"
    ---> Using cache
    ---> 0499906a34cb
    Step 3/4 : EXPOSE 3306
    ---> Using cache
    ---> 99a4da425cd7
    Step 4/4 : RUN echo "Europe/Warsaw" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
    ---> Using cache
    ---> fdafc780d693
    Successfully built fdafc780d693
    Successfully tagged custom-mariadb:alpha
    [2020-04-22T10:47:44Z] [ INFO ] >>> Processing /home/s3/task/docker/nginx/Dockerfile
    [2020-04-22T10:47:44Z] [ INFO ] >>> Makefile found, building using default target
    docker build -f Dockerfile --no-cache="false" \
    -t "custom-nginx":"alpha" .
    Sending build context to Docker daemon  6.144kB
    Step 1/3 : FROM nginx:alpine
    ---> 29b49a39bc47
    Step 2/3 : COPY files/default.conf /etc/nginx/conf.d/
    ---> Using cache
    ---> 6ecee6d4e35d
    Step 3/3 : COPY files/index.html /usr/share/nginx/html/
    ---> Using cache
    ---> 926ab13fe766
    Successfully built 926ab13fe766
    Successfully tagged custom-nginx:alpha