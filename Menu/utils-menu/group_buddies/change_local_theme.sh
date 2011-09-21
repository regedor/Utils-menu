#!/bin/bash

if [[ -z "$1" ]] ; then
  echo "Enter the path for the Project:"
  read PROJECTDIR
else
  PROJECTDIR="$1"
fi
LOCALCONFIG="$PROJECTDIR"/config/config.local
THEMESPROJECTPATH=$(grep themes_project_path "$PROJECTDIR"/config/config.local | perl -p -e 's/.*"(.*)"/$1/')

"$UTILS_PROJECT_PATH"/Menu/utils-menu/group_buddies/change_theme.pl "$LOCALCONFIG" "$THEMESPROJECTPATH" "$PROJECTDIR"

echo "Theme has been updated!"
