#!/bin/bash

# Exit if any simple command fails	
set -e 

# Check if Utils-menu is already installed
if [[ -n "$UTILS_PROJECT_PATH" && -d "$UTILS_PROJECT_PATH" ]] ; then 
	echo "It seems you have already installed Utils Menu."
	echo "Try utils-menu command for more information."
else
	 # Choose bashrc depending on OS
	if [ `uname` == "Darwin" ] ; then
	  BASHRC_PATH="$HOME/.bash_profile"	
	  BASHRC_FILE="bashrc_mac"
	else	
	  BASHRC_PATH="$HOME/.bashrc"
	  BASHRC_FILE="bashrc"	
	fi
	
	# Configure prompt
	# echo	"# Improve with options for prompt" >> "$BASHRC_PATH"
	# echo	"export PS1='\[\033[0;35m\]\h \[\033[0;33m\]\w\[\033[0;32m\] \$(parse_git_branch)\[\033[00m\]: '" >> "$BASHRC_PATH"
	
	if [ -z "$UTILS_PROJECT_PATH" ]; then
		UTILS_PROJECT_PATH="$HOME/.utils-menu"
	fi

	echo "*** Creating directory '$UTILS_PROJECT_PATH'..."
	mkdir -p "$UTILS_PROJECT_PATH"
	
	echo "*** Cloning Utils-menu Git repository to '$UTILS_PROJECT_PATH'..."
	git clone git://github.com/regedor/Utils-menu.git "$UTILS_PROJECT_PATH" 2>/dev/null
	cd "$UTILS_PROJECT_PATH"

	git submodule init 2>/dev/null
	git submodule update 2>/dev/null
	git submodule foreach git checkout master 2>/dev/null
	git submodule foreach git pull 2>/dev/null

	echo >> "$BASHRC_PATH"
	echo "# Utils-menu related" >> "$BASHRC_PATH"
	echo "export UTILS_PROJECT_PATH='$UTILS_PROJECT_PATH'" >> "$BASHRC_PATH"
	bash "$UTILS_PROJECT_PATH"/Menu/utils-menu/configurations/add_to_bashrc.sh
	echo 'PATH="$PATH:$UTILS_PROJECT_PATH/Bin"' >> "$BASHRC_PATH"
fi
