# Jupyter Notebook for Data analisys
A Jupyter notebook docker image for data analysis and data visualization

## Usage
Just run the image setting a token:

```
docker run -it -p 8888:8888 -e JUPYTER_TOKEN=mytoken infocubesrl/jupyter-data-analysis:latest
```

The notebooks are executed in `/opt/workspace` inside container's filesystem (just mind it if you want to mount a volume)
