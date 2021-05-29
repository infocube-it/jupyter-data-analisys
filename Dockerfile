FROM openjdk:15.0.2-jdk-slim-buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget python3 python3-pip build-essential zlib1g-dev liblzma-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libjpeg-dev zlib1g-dev libbz2-dev
RUN apt-get install -y gfortran libopenblas-dev liblapack-dev
RUN pip3 install cython jupyterlab

COPY requirements.txt /tmp/

RUN pip3 install -r /tmp/requirements.txt

WORKDIR /opt
RUN mkdir workspace

ARG JUPYTER_HOME=/opt/workspace    
ENV JUPYTER_HOME=${JUPYTER_HOME}
ARG JUPYTER_TOKEN=123456
ENV JUPYTER_TOKEN=$JUPYTER_TOKEN

EXPOSE 8888
WORKDIR ${JUPYTER_HOME}


ENTRYPOINT jupyter notebook --NotebookApp.token=$JUPYTER_TOKEN --allow-root --no-browser --ip=0.0.0.0 --port=8888 --NotebookApp.notebook_dir=$JUPYTER_HOME
