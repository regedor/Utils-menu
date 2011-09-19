#!/bin/bash

read -p "Queres por isto no teu bashrc? [Y/n] "
if [[ "$REPLY" == "n" || "$REPLY" == "N" ]]; then
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

echo "source \"$UTILS_PROJECT_PATH\"/BASHRC/\"$BASHRC_FILE\"" >> "$BASHRC_PATH"

exit 0
