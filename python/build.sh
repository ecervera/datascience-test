#!/bin/bash

cp ../data/litigation.csv .
docker build -t robinlab/datascience-python:lab-4.0.7 .
rm litigation.csv
