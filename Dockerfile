FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y wget
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/3.7.10/Python-3.7.10.tgz && tar xf Python-3.7.10.tgz
WORKDIR /tmp/Python-3.7.10
RUN apt-get install -y build-essential zlib1g-dev liblzma-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev
RUN ./configure --enable-optimizations
RUN make -j 4 && make altinstall
WORKDIR /tmp/Python-3.7.10
RUN pip3.7 install jupyterlab


COPY requirements.txt /tmp/

RUN pip3.7 install -r /tmp/requirements.txt
# fix a bug on jdk install
RUN mkdir -p /usr/share/man/man1 
# fix a bug on jdk install
RUN apt-get install -y default-jdk

WORKDIR /opt
RUN mkdir workspace
ARG JUPYTER_HOME=/opt/workspace    
ENV JUPYTER_HOME=${JUPYTER_HOME}

ARG JUPYTER_TOKEN=123456
ENV JUPYTER_TOKEN=$JUPYTER_TOKEN

EXPOSE 8888
WORKDIR ${JUPYTER_HOME}


ENTRYPOINT jupyter notebook --NotebookApp.token=$JUPYTER_TOKEN --allow-root --no-browser --ip=0.0.0.0 --port=8888 --NotebookApp.notebook_dir=$JUPYTER_HOME
