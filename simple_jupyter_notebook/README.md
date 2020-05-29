# A Simple Jupyter Notebook Docker Image

Here is a simple Jupyter notebook image that I personally use. It aims to have:
 - Common packages that I use, including Pytorch
 - Package management through pip (no Annaconda)
 - User name that doesn't scare me

# Instructions 

To use:

```
docker run -p 8888:8888 smilywhale/simple_jupyter_notebook 
```

# Interesting reads:
 - [the official Jupyter notebook image](https://hub.docker.com/r/jupyter/datascience-notebook/dockerfile)
 - [Tini](https://github.com/krallin/tini/)


