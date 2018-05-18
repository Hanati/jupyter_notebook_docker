docker_name=jupyter-notebook-py3
all: stop rm build run

stop:
	-docker stop ${docker_name} || true
rm:
	-docker rm ${docker_name} || true
build:
	docker build -t ${docker_name} .
run:
	docker run -p 8888:8888 -d ${docker_name} 
