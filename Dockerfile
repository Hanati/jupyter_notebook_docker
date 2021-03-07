FROM ubuntu:18.04

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
	    wget \
	    bzip2 \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy

RUN ln -s /opt/conda/bin/pip /opt/conda/bin/pip3
ENV TINI_VERSION v0.16.1 
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini  
ENV PATH /opt/conda/bin:$PATH

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

RUN pip3 install --no-cache-dir \
        ipykernel \
        jupyter \
	jupyterlab \
	mlflow \
	cloudpickle

# IPython
EXPOSE 8888

WORKDIR "/home"

CMD jupyter lab --ip="0.0.0.0" --no-browser --allow-root
