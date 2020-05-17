FROM ubuntu

USER root

RUN groupadd -r modeler && useradd --no-log-init -r -g modeler user_1

RUN apt-get update && \
  apt-get install -y python3 python3-setuptools python3-pip virtualenv

WORKDIR /code/

COPY requirements.txt .
RUN virtualenv venv && \
  sh venv/bin/activate && \
  pip3 install -r requirements.txt

EXPOSE 8888

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

USER user_1

# Run your program under Tini
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
