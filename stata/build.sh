#!/usr/bin/env bash

docker build --secret id=statalic,src=$(pwd)/stata.lic -t robinlab/datascience-stata:lab-4.0.7 .
