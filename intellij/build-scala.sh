#!/usr/bin/env bash

IDEA_VERSION=2020.1

docker build \
  --build-arg IDEA_VERSION=$IDEA_VERSION \
  --build-arg PLUGIN_IDS=1347 \
  --tag intellijidea-scala:$IDEA_VERSION \
  .
