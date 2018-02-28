FROM ubuntu:16.04

COPY requirements.txt /requirements.txt

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends apt-utils
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
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
RUN curl -O https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tar.xz
RUN tar -xf Python-3.5.3.tar.xz
WORKDIR /tmp/Python-3.5.3
RUN ./configure
RUN make \
    && make install

WORKDIR /
RUN rm -rf /tmp/Python-3.5.3.tar.xz /tmp/Python-3.5.3

RUN pip3 install -r /requirements.txt

RUN pip3 install --no-cache-dir \
        ipykernel \
        jupyter

# IPython
EXPOSE 8888

WORKDIR "/home"

CMD jupyter-notebook --ip="*" --no-browser --allow-root
