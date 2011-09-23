#!/bin/bash

if [[ -z "$1" ]] ; then
  echo
  echo "Usage: gb-server-update-this-app <instance .yml file>"
else
  LOCALCONFIG="$1"
fi

PROJECTDIR="/home/hokage/public_html/$(basename $LOCALCONFIG)"
THEMESPROJECTPATH="~/home/hokage/gb-handyant-themes"

rm -rf public/javascripts/cache/ 
rm -rf public/stylesheets/cache/ 

"$UTILS_PROJECT_PATH"/Menu/utils-menu/group_buddies/change_theme.pl "$LOCALCONFIG" "$THEMESPROJECTPATH" "$PROJECTDIR"

touch tmp/restart.txt 

echo "The application $1 has been restarted!"
