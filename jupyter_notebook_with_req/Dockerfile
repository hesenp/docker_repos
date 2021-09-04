FROM jupyter/minimal-notebook:hub-1.4.2

USER root 

WORKDIR /tmp/

COPY requirements.txt .
RUN pip3 install -r requirements.txt 

USER ${NB_USER}