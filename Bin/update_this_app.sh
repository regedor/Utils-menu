#!/bin/bash

if [[ -z "$1" ]] ; then
  echo
  echo "Usage: gb-server-update-this-app <instance .yml file>"
else
  LOCALCONFIG="$1"
fi

NAME=$(basename "$LOCALCONFIG" | perl -p -e 's/(.*)\.yml/$1/')
PROJECTDIR="$HOME/public_html/$NAME/site_files"
THEMESPROJECTPATH="$HOME/gb-handyant-themes"

rm -rf "$PROJECTDIR"/site_files/public/javascripts/cache/ 
rm -rf "$PROJECTDIR"/site_files/public/stylesheets/cache/ 

echo "$UTILS_PROJECT_PATH/Menu/utils-menu/group_buddies/change_theme.pl $LOCALCONFIG $THEMESPROJECTPATH $PROJECTDIR"
echo 
"$UTILS_PROJECT_PATH"/Menu/utils-menu/group_buddies/change_theme.pl "$LOCALCONFIG" "$THEMESPROJECTPATH" "$PROJECTDIR"

touch "$PROJECTDIR"/tmp/restart.txt 

echo "The application $1 has been restarted!"
