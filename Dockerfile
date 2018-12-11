FROM ubuntu:16.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends apt-utils \
            curl \
            xz-utils \
            build-essential \
            libsqlite3-dev \
            libreadline-dev \
            libssl-dev \
            ca-certificates \
            openssl \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN curl -O https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
RUN tar -xf Python-3.6.4.tar.xz
WORKDIR /tmp/Python-3.6.4

RUN ./configure && \
    make && make install

WORKDIR /
RUN rm -rf /tmp/Python-3.6.4.tar.xz /tmp/Python-3.6.4

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

RUN pip3 install --no-cache-dir \
        ipykernel \
        jupyter

# IPython
EXPOSE 8888

WORKDIR "/home"

CMD jupyter-notebook --ip="0.0.0.0" --no-browser --allow-root
