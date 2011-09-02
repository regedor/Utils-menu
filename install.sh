#!/bin/bash

# Exit if any simple command fails	
set -e 

# Check if user is root
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root!" 1>&2
	exit 1
fi


# Check if Utils-menu is already installed
if [[ -n "$UTILS_PROJECT_PATH" && -d "$UTILS_PROJECT_PATH" ]] ; then 
	echo "It seems you have already installed Utils Menu."
	echo "Try utils-menu command for more information."
else
	# Choose bashrc depending on OS
	if [ `uname` == "Darwin" ] ; then
	  BASHRC_PATH="~/.bash_profile"	
	  BASHRC_FILE="bashrc_mac"
	else	
	  BASHRC_PATH=~/.bashrc
	  BASHRC_FILE="bashrc"	
	fi
	
	# Configure prompt
	# echo  "# Improve with options for prompt" >> "$BASHRC_PATH"
	# echo  "export PS1='\[\033[0;35m\]\h \[\033[0;33m\]\w\[\033[0;32m\] \$(parse_git_branch)\[\033[00m\]: '" >> "$BASHRC_PATH"
	
	if [ -z "$UTILS_PROJECT_PATH"]; then
		UTILS_PROJECT_PATH="/opt/utils-menu"
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

	# Add $UTILS_PROJECT_PATH to bashrc
	# cat <<- END >> $BASHRC_PATH

	# ## Utils Menu Path."                         
	# export UTILS_PROJECT_PATH="$UTILS_PROJECT_PATH"
	# END

	export DMINSTALLDIR="$UTILS_PROJECT_PATH/Vendor/dirmenu"
	cd "$DMINSTALLDIR"
	bash "$DMINSTALLDIR"/dirmenu_generate

	# Add utils-menu to /usr/local/bin
	cat <<- END > /usr/local/bin/utils-menu
	#!/bin/bash

	export UTILS_PROJECT_PATH="$UTILS_PROJECT_PATH"

	UTILSDIROWNER=\$(ls -ld "$UTILS_PROJECT_PATH" | awk '{ print \$3}')
	UTILSUSER=\$(echo \$USER)
	if [ "\$UTILSDIROWNER" != "\$UTILSUSER" ]; then
		echo "You need to own '$UTILS_PROJECT_PATH' to run utils-menu,"
		echo "but the current owner is '\$UTILSDIROWNER'!"
		echo
		echo "Do you want to change the ownership of '$UTILS_PROJECT_PATH'?"
		read -p "(sudo password will be needed) [y/N] "
		if [[ "\$REPLY" == "y" || "\$REPLY" == "Y" ]]; then
			sudo chown -R "\$UTILSUSER":"\$UTILSUSER" "$UTILS_PROJECT_PATH"
		else
			echo
			echo utils-menu aborted!
			exit 1
		fi
	fi

	export dirmenu="$UTILS_PROJECT_PATH/Vendor/dirmenu/dirmenu"
	"$UTILS_PROJECT_PATH"/Menu/utils-menu/configurations/auto_update_um.sh
	dirmenu "$UTILS_PROJECT_PATH"/Menu/utils-menu
	END

	chmod +x /usr/local/bin/utils-menu

fi


