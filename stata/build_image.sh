#!/usr/bin/env bash

docker build --secret id=statalic,src=$(pwd)/stata.lic -t jupyter-stata .
