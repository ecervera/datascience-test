#!/usr/bin/env bash

cp ../data/litigation.csv .
docker build --secret id=statalic,src=$(pwd)/stata.lic -t robinlab/datascience-stata:lab-4.0.7 .
rm litigation.csv
