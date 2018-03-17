docker_name=jupyter-notebook-python3.6.4
all: stop rm build

stop:
	docker stop ${docker_name} || true
rm:
	docker rm ${docker_name} || true
build:
	docker build -t ${docker_name} .
run:
	docker run -p 8888:8888 -d ${docker_name} 
