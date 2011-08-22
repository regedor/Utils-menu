#!/bin/bash

	
if [ "$UTILS_PROJECT_PATH" = "" ] ; then 
  if [ `uname` == "Darwin" ] ; then
	BASHRC_PATH="~/.bash_profile"	
	BASHRC_FILE="bashrc_mac"
  else	
    BASHRC_PATH="~/.bashrc"
    BASHRC_FILE="bashrc"	
  fi
  echo "## Utils Menu Installer."                                                                            >> "$BASHRC_PATH"
  echo "export UTILS_PROJECT_PATH=\"$(dirname $PWD/$0)\""                                                    >> "$BASHRC_PATH"
  echo "source \"`dirname $0`/BASHRC/$BASHRC_FILE\""                                                         >> "$BASHRC_PATH"
  #Improve with options for prompt
  echo  export PS1="'"'\[\033[0;35m\]\h \[\033[0;33m\]\w\[\033[0;32m\] $(parse_git_branch)\[\033[00m\]: '"'" >> "$BASHRC_PATH"
  echo "Restart your bash and run utils-menu."                                                                                
else
  echo "It seems you have already installed Utils Menu."
  echo "Try utils-menu command for more information."
fi


