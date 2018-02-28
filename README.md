# Docker File for jupyter notebook for single user on cloud

----

### Docker build

    docker build -t juypter-notebook .
    #### build using proxy
    docker build build-arg HTTP_PROXY=http://*.*.*.*:*

### Docker run
    docker run --rm -p 8888:8888 -v your_directory:/home jupyter-notebook


