#!/bin/bash

update_instances() {
  GB_INSTANCES_FOLDER="$HOME"/gb-instances
  GB_INSTANCES_PATH="$GB_INSTANCES_FOLDER"/*.yml
  THEMESPROJECTPATH="$HOME"/gb-handyant-themes
  
  cd "$GB_INSTANCES_FOLDER" ; echo "Estou na:$(pwd)" ; git pull ; cd -
  cd "$THEMESPROJECTPATH" ; echo "Estou na:$(pwd)" ; git pull ; cd -
  
  echo
  echo "Here's the list gb's instances:"
  echo
  
  # Calculate the list of sites in public_html and their state 
  for site in  $(ls -1 $GB_INSTANCES_PATH); do
    sitelist=(${sitelist[@]-} "$site\n")
  done
  
  # Repeat until valid choice
  CHOICE="NO"
  while [ "$CHOICE" == "NO" ]; do
  # Calculate the list of sites and their states
    echo -e "${sitelist[@]}" |\
    nl |\
    perl -plne 's/^\s+(\d+)\s+/ [$1]\t/g' |\
    cat - <(echo ""; echo "[A] Update all"; echo "[X] Cancel") |\
    column -t
  
    read -p "Choose an instance: " -e NUMBER
  
    case $NUMBER in
    X|x) # Cancel and exit
      exit 1
      ;;
  
    [0-9]|[0-9][0-9]) # Number with one or two digits. 
      SITE=$(ls -1 $GB_INSTANCES_PATH | head -$NUMBER | tail -1)
      update_instance "$SITE" "$THEMESPROJECTPATH"
      CHOICE='YES'
      ;;
  
    A|a) # Put all sites under maintenance
      for SITE in $(ls -1 $GB_INSTANCES_PATH); do
        update_instance "$SITE" "$THEMESPROJECTPATH"
      done
      CHOICE='YES'
      ;;		
  
    *)
      echo "UNDEFINED option '$NUMBER'!"
      CHOICE='NO'
      ;;
    esac
  done
}


update_instance() {
  CONFIGFILE=$1
  THEMESPROJECTPATH=$2
  NAME=$(basename "$LOCALCONFIG" | perl -p -e 's/(.*)\.yml/$1/')
  PROJECTDIR="$HOME/public_html/$NAME/site_files"

  echo "$THEMESPROJECTPATH"
  exit 1
  
  echo "** Removing cache files"
  echo 
  rm -rf "$PROJECTDIR"/site_files/public/javascripts/cache/ 
  rm -rf "$PROJECTDIR"/site_files/public/stylesheets/cache/ 
  
  echo "** Updating instance repository"
  echo 
  cd "$PROJECTDIR"
  git pull
  rake db:migrate
  cd -
  
  echo "** Running:"
  echo "  $UTILS_PROJECT_PATH/Menu/utils-menu/group_buddies/change_theme.pl $LOCALCONFIG $THEMESPROJECTPATH $PROJECTDIR"
  echo 
  "$UTILS_PROJECT_PATH"/Menu/utils-menu/group_buddies/change_theme.pl "$LOCALCONFIG" "$THEMESPROJECTPATH" "$PROJECTDIR"
  
  echo "  ** Restarting the application $PROJECTDIR"
  echo 
  touch "$PROJECTDIR"/tmp/restart.txt 
  echo "** The instance $1 has been restarted!"
  echo 
}

update_instances
exit 0
