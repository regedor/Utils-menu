#!/bin/bash

read -p "Start Backup Simulation? (yes/no)" ANSWER

if [[ "$ANSWER" = "yes" ]]; then
  sudo rsync -aHnv --delete ~ /media/SilverDisk/Backup
fi
read -p "Start Backuping? (yes/no)" ANSWER
if [[ "$ANSWER" = "yes" ]]; then 
  sudo rsync -aHv --delete ~ /media/SilverDisk/Backup
fi
