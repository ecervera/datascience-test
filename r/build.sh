#!/bin/bash

cp ../data/litigation.csv .
docker build -t robinlab/litigations-gng-r:lab-4.0.7 .
rm litigation.csv
