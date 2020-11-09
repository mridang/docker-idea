#!/bin/sh
set -x
# Installs given plugin
# The plugin is defined by passing the plugin id as an argument.
# See the scala plugin for example https://plugins.jetbrains.com/plugin/1347-scala
# The id would be 1347.
# This script assumes the following arguments
# - IDEA_VERSION: The idea version, e.g. 2020.1
# - PLUGIN_ID: The id of the plugin
# - PLUGINS_DIR: The directory where to install the plugin
#
# See https://stackoverflow.com/a/55243388/11140326
# how to get the plugin URL

IDEA_VERSION=$1
PLUGIN_ID=$2
PLUGINS_DIR=$3

echo "Installing plugin $PLUGIN_ID for $IDEA_VERSION in $PLUGINS_DIR"
cd "$PLUGINS_DIR" || exit

LATEST=$(curl -s https://plugins.jetbrains.com/api/plugins/$PLUGIN_ID/updates \
  | jq --arg IDEA_VERSION "$IDE_VERSION" -r '[.[] | select( .version | startswith($IDEA_VERSION))][0].file')
ARCHIVE_NAME=$(basename "$LATEST")
curl "https://plugins.jetbrains.com/files/$LATEST" > "$ARCHIVE_NAME"
unzip $ARCHIVE_NAME
rm $ARCHIVE_NAME
