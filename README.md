[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/ecervera/datascience-test/main)

# datascience-test

Pre-requisites:
* [Docker](https://docs.docker.com/engine/install/)

## Run a container
Open a terminal and run the command:
```
docker run --rm -it -p 8888:8888 robinlab/datascience:lab-4.0.7 
```

## Build the image
Clone this repository, open a terminal in the main folder and run the command:
```
docker build -t robinlab/datascience:lab-4.0.7 .
```
