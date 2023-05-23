#!/usr/bin/env bash

IDEA_VERSION=PhpStorm-2023.1.2

docker build \
  --build-arg IDEA_VERSION=$IDEA_VERSION \
  --tag ghcr.io/mridang/docker-idea/phpstorm:$IDEA_VERSION \
  .

docker push ghcr.io/mridang/docker-idea/phpstorm:$IDEA_VERSION

docker tag ghcr.io/mridang/docker-idea/phpstorm:$IDEA_VERSION mridang/jbstorm:$IDEA_VERSION

docker push mridang/jbstorm:$IDEA_VERSION

docker tag mridang/jbstorm:$IDEA_VERSION mridang/jbstorm:latest