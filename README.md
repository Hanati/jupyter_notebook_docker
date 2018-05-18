# Docker File for jupyter notebook for single user on cloud
----
### The basic structure
   Ubuntu16.04 => miniconda3 => jupyter

### How to use

    make all

### Docker run
    docker build -t jupyter-notebook-py3 .
    docker run --rm -p 8888:8888 -v your_directory:/home jupyter-notebook-py3


