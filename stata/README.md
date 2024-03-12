# Stata implementation

Based on [AEA Data Editor Docker image](https://github.com/AEADataEditor/docker-stata).

## Pre-requisite
A Stata 18 license. Copy the "stata.lic" file to the working directory and run the container as shown below.

## Run the Docker container
1. In a terminal, run the command:
```
docker run -it --rm -p 8888:8888 \
  -v $(pwd)/stata.lic:/usr/local/stata/stata.lic \
  robinlab/litigations-gng-stata:lab-4.0.7
```
2. In the browser, open the Jupyter notebook [`Litigation_Stata.ipynb`](http://127.0.0.1:8888/lab/tree/Litigation_Stata.ipynb)
