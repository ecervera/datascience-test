#!/usr/bin/env bash

docker run -it --rm --name jupyter-stata \
  -p 8888:8888 \
  -v $(pwd)/stata.lic:/usr/local/stata/stata.lic \
  jupyter-stata
