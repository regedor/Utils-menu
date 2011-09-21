#!/bin/bash

echo "This script is going to do the following things:"
echo " * Add to you bashrc:"
echo "   |  source \"\$UTILS_PROJECT_PATH\"/BASHRC/group_buddies"

read -p "Do you wanna run it? [Y/n]"
if [[ "$REPLY" == "n" || "$REPLY" == "N" ]]; then
	echo "Tabem, má bontade..."
	exit 1
fi

# Choose bashrc depending on OS
if [ `uname` == "Darwin" ] ; then
  BASHRC_PATH="$HOME/.bash_profile" 
  BASHRC_FILE="bashrc_mac"
else    
  BASHRC_PATH="$HOME/.bashrc"
  BASHRC_FILE="bashrc"  
fi  

echo "source \"$UTILS_PROJECT_PATH\"/BASHRC/group_buddies" >> "$BASHRC_PATH"
echo "Done!"
exit 0
