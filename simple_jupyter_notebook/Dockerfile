FROM ubuntu

USER root

RUN apt-get update && \
  apt-get install -y python3 python3-setuptools python3-pip virtualenv

WORKDIR /tmp/

COPY requirements.txt .
RUN pip3 install -r requirements.txt

EXPOSE 8888

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# fix user permission etc. Mostly inspired by this: https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile

ARG NB_USER="user_1"
ARG NB_UID="1000"
ARG NB_GID="1000"

COPY fix-permissions /usr/local/bin/fix-permissions

RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc && \
   useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
   mkdir -p /home/${NB_USER} && \
   chown $NB_USER:$NB_GID /home/${NB_USER} && \
   chown $NB_USER:$NB_GID /home/${NB_USER} && \
   mkdir -p /code && \
   chown $NB_USER:$NB_GID /code && \
   chown $NB_USER:$NB_GID /code && \
   chmod a+rx /usr/local/bin/fix-permissions && \
   fix-permissions /home/${NB_USER} && \
   fix-permissions /code

USER ${NB_USER}

# Get better looking CSS font for Jupyter notebook
COPY custom.css ~/.jupyter/custom/

WORKDIR /code

# Run your program under Tini
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
