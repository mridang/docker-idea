#!/usr/bin/env bash

IDEA_VERSION=2020.3

docker build \
  --build-arg IDEA_VERSION=$IDEA_VERSION \
  --build-arg PLUGIN_IDS=1347 \
  --tag docker.pkg.github.com/mridang/docker-idea/intellijidea:$IDEA_VERSION \
  .

docker push docker.pkg.github.com/mridang/docker-idea/intellijidea:$IDEA_VERSION

docker tag docker.pkg.github.com/mridang/docker-idea/intellijidea:$IDEA_VERSION mridang/ijidea:$IDEA_VERSION

docker push mridang/ijidea:$IDEA_VERSION

docker tag mridang/ijidea:$IDEA_VERSION mridang/ijidea:latest
