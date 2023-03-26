#!/bin/bash

docker build -t isaudits/powerhub .
docker image prune -f