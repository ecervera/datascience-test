# Stata implementation

## Pre-requisite
A Stata 18 license. Copy the "stata.lic" file to the working directory and run the container as shown below.

## Run the Docker container
```
docker run -it --rm -p 8888:8888 \
  -v $(pwd)/stata.lic:/usr/local/stata/stata.lic \
  robinlab/litigations-gng-stata:lab-4.0.7
```
