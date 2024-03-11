#!/usr/bin/env bash

docker run -it --rm --name datascience-stata \
  -p 8888:8888 \
  -v $(pwd)/stata.lic:/usr/local/stata/stata.lic \
  robinlab/datascience-stata:lab-4.0.7
