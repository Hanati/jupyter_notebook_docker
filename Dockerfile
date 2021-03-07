FROM python:3.8

WORKDIR /home

COPY requirements.txt /home/requirements.txt
RUN pip install -r /home/requirements.txt

# IPython
EXPOSE 8888

CMD jupyter lab --ip="0.0.0.0" --no-browser --allow-root
